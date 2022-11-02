package com.baidu.bmfmap.map.overlayhandler;

import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;

import com.baidu.bmfmap.BMFMapController;
import com.baidu.bmfmap.utils.Constants;
import com.baidu.bmfmap.utils.Env;
import com.baidu.bmfmap.utils.converter.FlutterDataConveter;
import com.baidu.bmfmap.utils.converter.TypeConverter;
import com.baidu.mapapi.map.BaiduMap;
import com.baidu.mapapi.map.BitmapDescriptor;
import com.baidu.mapapi.map.Overlay;
import com.baidu.mapapi.map.PrismOptions;
import com.baidu.mapapi.model.LatLng;
import com.baidu.mapapi.search.core.BuildingInfo;

import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * 3.1.0 3D棱柱
 */
public class PrismHandler extends OverlayHandler {
    private static final String TAG = "PrismHandler";

    public PrismHandler(BMFMapController bmfMapController) {
        super(bmfMapController);
    }

    @Override
    public void handlerMethodCall(MethodCall call, MethodChannel.Result result) {
        super.handlerMethodCall(call, result);

        if (Env.DEBUG) {
            Log.d(TAG, "handlerMethodCall enter");
        }

        if (null == result) {
            return;
        }
        Map<String, Object> argument = call.arguments();
        if (null == argument) {
            if (Env.DEBUG) {
                Log.d(TAG, "argument is null");
            }
            result.success(false);
            return;
        }

        String methodId = call.method;
        boolean ret = false;
        switch (methodId) {
            case Constants.MethodProtocol.PrismProtocol.MAP_ADD_PRISM_OVERLAY_METHOD:
                ret = addPrismOverlay(argument);
                break;
            default:
                break;
        }

        result.success(ret);
    }

    private boolean addPrismOverlay(Map<String, Object> argument) {
        BaiduMap baiduMap = mMapController.getBaiduMap();
        if (baiduMap == null) {
            return false;
        }

        if (!argument.containsKey("id")
                || !argument.containsKey("coordinates")) {
            if (Env.DEBUG) {
                Log.d(TAG, "argument does not contain");
            }
            return false;
        }

        final String id = new TypeConverter<String>().getValue(argument, "id");
        if (TextUtils.isEmpty(id)) {
            if (Env.DEBUG) {
                Log.d(TAG, "id is null");
            }
            return false;
        }

        if (mOverlayMap.containsKey(id)) {
            return false;
        }

        PrismOptions prismOptions = new PrismOptions();
        setOptions(argument, prismOptions);

        final Overlay overlay = baiduMap.addOverlay(prismOptions);
        if (null == overlay) {
            return false;
        }

        Bundle bundle = new Bundle();
        bundle.putString("id", id);
        overlay.setExtraInfo(bundle);
        mOverlayMap.put(id, overlay);
        mMapController.mOverlayIdMap.put(id, overlay);
        
        return true;
    }

    private boolean setOptions(Map<String, Object> prismOptionsMap, PrismOptions prismOptions) {
        if (null == prismOptionsMap || null == prismOptions) {
            return false;
        }

        List<Map<String, Double>> coordinates =
                (List<Map<String, Double>>) prismOptionsMap.get("coordinates");
        List<LatLng> latLngList = FlutterDataConveter.mapToLatlngs(coordinates);
        if (null == latLngList) {
            if (Env.DEBUG) {
                Log.d(TAG, "latLngList is null");
            }
            return false;
        }

        String topFaceColorStr = (String) prismOptionsMap.get("topFaceColor");
        if (TextUtils.isEmpty(topFaceColorStr)) {
            return false;
        }

        String sideFaceColorStr = (String) prismOptionsMap.get("sideFaceColor");
        String sideFacTextureStr = (String) prismOptionsMap.get("sideFacTexture");
        if (TextUtils.isEmpty(sideFaceColorStr) &&
                TextUtils.isEmpty(sideFacTextureStr)) {
            return false;
        }

        prismOptions.setPoints(latLngList);

        Integer topFaceColor = FlutterDataConveter.getColor(topFaceColorStr);
        prismOptions.setTopFaceColor(topFaceColor);

        if (!TextUtils.isEmpty(sideFaceColorStr)) {
            Integer sideFaceColor = FlutterDataConveter.getColor(sideFaceColorStr);
            prismOptions.setSideFaceColor(sideFaceColor);
        }

        /*
         * color和icon只能使用一个
         */
        if (!TextUtils.isEmpty(sideFacTextureStr)) {
            BitmapDescriptor sideFacTexture = FlutterDataConveter.getIcon(sideFacTextureStr);
            prismOptions.customSideImage(sideFacTexture);
        }

        Map<String, Object> buildInfoMap = (Map<String, Object>) prismOptionsMap.get("buildInfo");
        BuildingInfo buildInfo = createBuildInfo(buildInfoMap);
        if (buildInfo != null) {
            prismOptions.setBuildingInfo(buildInfo);
        }

        Integer height = new TypeConverter<Integer>().getValue(prismOptionsMap, "height");
        if (null != height) {
            prismOptions.setHeight(height);
        }

        Boolean visible = new TypeConverter<Boolean>().getValue(prismOptionsMap, "visible");
        if (null != visible) {
            prismOptions.visible(visible);
        }

        return true;
    }

    private BuildingInfo createBuildInfo(Map<String, Object> buildInfoMap) {
        if (buildInfoMap == null || buildInfoMap.size() <= 0) {
            return null;
        }

        BuildingInfo buildingInfo = new BuildingInfo();
        Double height = (Double) buildInfoMap.get("height");
        Double accuracy = (Double) buildInfoMap.get("accuracy");
        String paths = (String) buildInfoMap.get("paths");
        String center = (String) buildInfoMap.get("center");
        if (!TextUtils.isEmpty(paths)) {
            buildingInfo.setGeom(paths);
        }

        if (!TextUtils.isEmpty(center)) {
            buildingInfo.setCenter(center);
        }

        if (null != height) {
            buildingInfo.setHeight(height.floatValue());
        }

        if (null != accuracy) {
            buildingInfo.setAccuracy(accuracy.intValue());
        }

        return buildingInfo;
    }
}
