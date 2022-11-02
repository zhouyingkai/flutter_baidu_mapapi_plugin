package com.baidu.mapapi.utils.handlers;

import java.util.HashMap;
import java.util.Map;

import com.baidu.mapapi.utils.Constants;
import com.baidu.mapapi.utils.Env;
import com.baidu.mapapi.utils.MethodID;

import android.util.Log;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * method handle 工厂类
 */
public class HandlersFactory {

    public static final String TAG = HandlersFactory.class.getSimpleName();
    private static volatile HandlersFactory sInstance;

    public Map<Integer, MethodChannelHandler> methodHandlerMap = new HashMap<>();

    public static HandlersFactory getInstance() {

        if (null == sInstance) {
            synchronized (HandlersFactory.class) {
                if (null == sInstance) {
                    sInstance = new HandlersFactory();
                }
            }
        }

        return sInstance;
    }

    private HandlersFactory() {
        methodHandlerMap.put(Constants.HandlerType.OPEN_NAVI_TYPE, new OpenBaiduMapNaviHandler());
        methodHandlerMap.put(Constants.HandlerType.OPEN_ROUTE_TYPE, new OpenBaiduRouteHandler());
        methodHandlerMap.put(Constants.HandlerType.OPEN_PANO_TYPE, new OpenPanoHandler());
        methodHandlerMap.put(Constants.HandlerType.OPEN_POI_DETAIL_TYPE,
                new OpenBaiduMapPoiDetailHandler());
        methodHandlerMap
                .put(Constants.HandlerType.OPEN_POI_NEAR_TYPE, new OpenBaiduMapPoiNearHandler());
        methodHandlerMap.put(Constants.HandlerType.CALCULATE_TYPE, new CalculateHandler());
        methodHandlerMap.put(Constants.HandlerType.GET_VERSION_TYPE, new VersionHandler());
    }

    public void dispatchMethodHandler(MethodCall call, MethodChannel.Result result) {
        if (Env.DEBUG) {
            Log.d(TAG, "dispatchMethodHandler enter");
        }
        if (null == call || null == result) {
            return;
        }

        MethodChannelHandler methodChannelHandler = null;
        String method = call.method;
        switch (method) {
            case MethodID.OpenMethodID.kOpenBaiduMapNavi:
                methodChannelHandler = methodHandlerMap.get(Constants.HandlerType.OPEN_NAVI_TYPE);
                break;
            case MethodID.OpenMethodID.kOpenBaiduMapRoute:
                methodChannelHandler = methodHandlerMap.get(Constants.HandlerType.OPEN_ROUTE_TYPE);
                break;
            case MethodID.OpenMethodID.kOpenBaiduMapPanorama:
                methodChannelHandler = methodHandlerMap.get(Constants.HandlerType.OPEN_PANO_TYPE);
                break;
            case MethodID.OpenMethodID.kOpenBaiduMapPoiDetail:
                methodChannelHandler =
                        methodHandlerMap.get(Constants.HandlerType.OPEN_POI_DETAIL_TYPE);
                break;
            case MethodID.OpenMethodID.kOpenBaiduMapPoiNear:
                methodChannelHandler =
                        methodHandlerMap.get(Constants.HandlerType.OPEN_POI_NEAR_TYPE);
                break;
            case MethodID.CalcMethodID.kCalculateRectArea:
            case MethodID.CalcMethodID.kCalculatePolygonArea:
            case MethodID.CalcMethodID.kCoordTypeConvert:
            case MethodID.CalcMethodID.kPolygonContainsCoord:
            case MethodID.CalcMethodID.kCircleContainsCoord:
            case MethodID.CalcMethodID.kLocationDistance:
            case MethodID.CalcMethodID.kNearestPointToLine:
                methodChannelHandler = methodHandlerMap.get(Constants.HandlerType.CALCULATE_TYPE);
                break;
            case MethodID.CommonMethodID.kGetVersion:
                methodChannelHandler = methodHandlerMap.get(Constants.HandlerType.GET_VERSION_TYPE);
                break;
            default:
                break;
        }

        if (null != methodChannelHandler) {
            methodChannelHandler.handlerMethodCallResult(call, result);
        }
    }
}