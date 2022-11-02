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
import com.baidu.mapapi.map.track.TraceAnimationListener;
import com.baidu.mapapi.map.track.TraceOptions;
import com.baidu.mapapi.map.track.TraceOverlay;
import com.baidu.mapapi.model.LatLng;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * 3.1.0 动态轨迹绘制
 */
public class TraceHandler extends OverlayHandler implements TraceAnimationListener {
    private static final String TAG = "TraceHandler";

    protected final HashMap<String, TraceOverlay> mTraceOverlayMap = new HashMap<>();
    
    public TraceHandler(BMFMapController bmfMapController) {
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
            case Constants.MethodProtocol.TraceProtocol.MAP_ADD_TRACE_OVERLAY_METHOD:
                ret = addTraceOverlay(argument);
                break; 
            case Constants.MethodProtocol.TraceProtocol.MAP_REMOVE_TRACE_OVERLAY_METHOD:
                ret = removeOneTraceOverLayById(argument);
                break;
            default:
                break;
        }

        result.success(ret);
    }

    private boolean addTraceOverlay(Map<String, Object> argument) {
        if (mMapController == null) {
            return false;
        }

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

        if (mTraceOverlayMap.containsKey(id)) {
            return false;
        }

        List<Map<String, Double>> coordinates =
                (List<Map<String, Double>>) argument.get("coordinates");
        List<LatLng> latLngList = FlutterDataConveter.mapToLatlngs(coordinates);
        if (null == latLngList) {
            if (Env.DEBUG) {
                Log.d(TAG, "latLngList is null");
            }
            return false;
        }

        TraceOptions traceOptions = new TraceOptions();
        traceOptions.points(latLngList);
        
        Map<String, Object> traceOverlayAnimateOption = 
                (Map<String, Object>) argument.get("traceOverlayAnimateOption");
        if (null != traceOverlayAnimateOption && traceOverlayAnimateOption.size() > 0) {
            Boolean animate = (Boolean) traceOverlayAnimateOption.get("animate");
            if (null != animate) {
                traceOptions.animate(animate);
            }

            Double delay = (Double) traceOverlayAnimateOption.get("delay");
            if (null != delay) {
                traceOptions.animationDuration(delay.intValue() * 1000);
            }

            Double duration = (Double) traceOverlayAnimateOption.get("duration");
            if (null != duration) {
                traceOptions.animationTime(duration.intValue() * 1000);
            }

            Integer easingCurve = (Integer) traceOverlayAnimateOption.get("easingCurve");
            if (null != easingCurve) {
                traceOptions.animationType(TraceOptions.TraceAnimateType.values()[easingCurve]);
            }

            Boolean trackMove = (Boolean) traceOverlayAnimateOption.get("trackMove");
            if (null != trackMove) {
                traceOptions.setTrackMove(trackMove);
            }
        }
        
        Integer width = (Integer) argument.get("width");
        if (null != width) {
            traceOptions.width(width);
        }

        String fillColorStr = (String) argument.get("fillColor");
        if (!TextUtils.isEmpty(fillColorStr)) {
            Integer fillColor = FlutterDataConveter.getColor(fillColorStr);
            if (null != fillColor) {
                traceOptions.color(fillColor);
            }
        }
        
        final TraceOverlay overlay = baiduMap.addTraceOverlay(traceOptions, this);
        if (null == overlay) {
            return false;
        }

        Bundle bundle = new Bundle();
        bundle.putString("id", id);
        mTraceOverlayMap.put(id, overlay);
        return true;
    }

    private boolean removeOneTraceOverLayById(Map<String, Object> argument) {
        if (mMapController == null) {
            return false;
        }

        BaiduMap baiduMap = mMapController.getBaiduMap();
        if (baiduMap == null) {
            return false;
        }

        if (!argument.containsKey("id")) {
            if (Env.DEBUG) {
                Log.d(TAG, "argument does not contain");
            }
            return false;
        }
        
        String id = new TypeConverter<String>().getValue(argument, "id");
        if (TextUtils.isEmpty(id)) {
            return false;
        }

        TraceOverlay overlay = mTraceOverlayMap.get(id);
        if (null == overlay) {
            if (Env.DEBUG) {
                Log.d(TAG, "not found overlay with id:" + id);
            }
            return false;
        }

        overlay.remove();
        if (mTraceOverlayMap != null) {
            mTraceOverlayMap.remove(id);
        }

        if (Env.DEBUG) {
            Log.d(TAG, "remove Overlay success");
        }
        return true;
    }
    
    @Override
    public void onTraceAnimationUpdate(int i) {

    }

    @Override
    public void onTraceUpdatePosition(LatLng latLng) {

    }

    @Override
    public void onTraceAnimationFinish() {

    }

    @Override
    public void clean() {
        super.clean();

        if (mTraceOverlayMap != null && mTraceOverlayMap.size() > 0) {
            mTraceOverlayMap.clear();
        }
    }
}
