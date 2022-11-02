package com.baidu.bmfmap.map.overlayhandler;

import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;

import com.baidu.bmfmap.BMFMapController;
import com.baidu.bmfmap.utils.BMFFileUtils;
import com.baidu.bmfmap.utils.Constants;
import com.baidu.bmfmap.utils.Env;
import com.baidu.bmfmap.utils.converter.FlutterDataConveter;
import com.baidu.bmfmap.utils.converter.TypeConverter;
import com.baidu.mapapi.map.BM3DModelOptions;
import com.baidu.mapapi.map.BaiduMap;
import com.baidu.mapapi.map.Overlay;
import com.baidu.mapapi.model.LatLng;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class BM3DModelHandler extends OverlayHandler {
    private static final String TAG = "BM3DModelHandler";

    private BMFFileUtils mFileUtils;

    public BM3DModelHandler(BMFMapController bmfMapController) {
        super(bmfMapController);

        mFileUtils = BMFFileUtils.getInstance();
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
            case Constants.MethodProtocol.BM3DModelProtocol.MAP_ADD_3DMODEL_OVERLAY_METHOD:
                ret = addBM3DModelOverlay(argument);
                break;
            default:
                break;
        }

        result.success(ret);
    }

    private boolean addBM3DModelOverlay(Map<String, Object> argument) {
        if (mMapController == null) {
            return false;
        }

        if (mFileUtils == null) {
            return false;
        }

        BaiduMap baiduMap = mMapController.getBaiduMap();
        if (baiduMap == null) {
            return false;
        }

        if (!argument.containsKey("id")
                || !argument.containsKey("center")
                || !argument.containsKey("option")) {
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

        Map<String, Object> center = (Map<String, Object>) argument.get("center");
        if (null == center || center.size() <= 0) {
            return false;
        }
        
        LatLng position = FlutterDataConveter.mapToLatlng(center);
        if (null == position) {
            if (Env.DEBUG) {
                Log.d(TAG, "position is null");
            }
            return false;
        }

        Map<String, Object> option = (Map<String, Object>) argument.get("option");
        String modelPath = (String) option.get("modelPath");
        if (TextUtils.isEmpty(modelPath)) {
            if (Env.DEBUG) {
                Log.d(TAG, "modelPath is null");
            }
            return false;
        }

        String modelName = (String) option.get("modelName");
        if (TextUtils.isEmpty(modelName)) {
            if (Env.DEBUG) {
                Log.d(TAG, "modelName is null");
            }
            return false;
        }

        String parentPath = mFileUtils.getDirPath(modelPath);
        if (TextUtils.isEmpty(parentPath)) {
            return false;
        }
        BM3DModelOptions bm3DModelOptions = new BM3DModelOptions();
        bm3DModelOptions.setPosition(position);
        bm3DModelOptions.setModelPath(parentPath);
        bm3DModelOptions.setModelName(modelName);
        
        Integer type = (Integer) option.get("type");
        if (null != type) {
            bm3DModelOptions.setBM3DModelType(BM3DModelOptions.BM3DModelType.values()[type]);
        }

        Double offsetX = (Double) option.get("offsetX");
        Double offsetY = (Double) option.get("offsetX");
        Double offsetZ = (Double) option.get("offsetX");
        if (null != offsetX && null != offsetY && null != offsetZ) {
            bm3DModelOptions.setOffset(offsetX.floatValue(), offsetY.floatValue(), offsetZ.floatValue());
        }

        Double rotateX = (Double) option.get("rotateX");
        Double rotateY = (Double) option.get("rotateY");
        Double rotateZ = (Double) option.get("rotateZ");

        if (null != rotateX && null != rotateY && null != rotateZ) {
            bm3DModelOptions.setRotate(rotateX.floatValue(), rotateY.floatValue(), rotateZ.floatValue());
        }

        Double scale = (Double) option.get("scale");
        if (null != scale) {
            bm3DModelOptions.setScale(scale.floatValue());
        }

        Boolean zoomFixed = (Boolean) option.get("zoomFixed");
        if (null != zoomFixed) {
            bm3DModelOptions.setZoomFixed(zoomFixed);
        }

        Boolean visible = new TypeConverter<Boolean>().getValue(argument, "visible");
        if (null != visible) {
            bm3DModelOptions.visible(visible);
        }

        final Overlay overlay = baiduMap.addOverlay(bm3DModelOptions);
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
}
