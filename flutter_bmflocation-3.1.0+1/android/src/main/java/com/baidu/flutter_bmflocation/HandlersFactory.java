package com.baidu.flutter_bmflocation;

import android.content.Context;
import android.text.TextUtils;

import com.baidu.geofence.GeoFenceClient;
import com.baidu.location.LocationClient;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class HandlersFactory {
    /* 类名 */
    public static final String TAG = HandlersFactory.class.getSimpleName();
    /* 声明实例变量 */
    private static volatile HandlersFactory sInstance;

    private LocationClient mLocationClient;

    private GeoFenceClient mGeoFenceClient;
    // 初始化一个MAP
    public Map<String, MethodChannelHandler> methodHandlerMap = new HashMap<>();

    static MethodChannelHandler methodChannelHandler = null;

     /* 返回实例对象 */
    public static HandlersFactory getInstance(Context context) {
        if (null == sInstance) {
            synchronized (HandlersFactory.class) {
                if (null == sInstance) {
                    sInstance = new HandlersFactory();
                    if (null == sInstance.mLocationClient){
                        try {
                            sInstance.mLocationClient =  new LocationClient(context);
                        } catch(Exception e) {
                        }
                    }
                    if (null == sInstance.mGeoFenceClient){
                        try {
                            sInstance.mGeoFenceClient =  new GeoFenceClient(context);
                        } catch(Exception e) {
                        }
                    }
                }
            }
        }
        return sInstance;
    }

     // 根据方法名存入到Map中对应的handler对象
    private HandlersFactory() {
        methodHandlerMap
                .put(Constants.MethodID.LOCATION_SETOPTIONS, new LocationSetOptionsHandler());
        methodHandlerMap
                .put(Constants.MethodID.LOCATION_SERIESLOC, new LocationResultHandler());
        methodHandlerMap
                .put(Constants.MethodID.LOCATION_STOPLOC, new LocationResultHandler());
        methodHandlerMap.put(Constants.MethodID.LOCATION_CIRCLEGEOFENCE, new GeofenceHandler());
        methodHandlerMap.put(Constants.MethodID.LOCATION_POLYGONGEOFENCE, new GeofenceHandler());
        methodHandlerMap.put(Constants.MethodID.LOCATION_GETALLGEOFENCEID, new GeofenceHandler());
        methodHandlerMap.put(Constants.MethodID.LOCATION_NERWORKSTATE, new AuxiliaryFunctionHandler());
        methodHandlerMap.put(Constants.MethodID.LOCATION_STARTHEADING, new HeadingResultHandler());
        methodHandlerMap.put(Constants.MethodID.LOCATION_STOPHEADING, new HeadingResultHandler());
    }

     // 根据传入的方法名从map中取出对应的handle去执行handleMethodCallResult
    public void dispatchMethodHandler(Context context, MethodCall call, MethodChannel.Result result) {
        if (null == call || null == result) {
            return;
        }

        String method = call.method;
        if (TextUtils.isEmpty(method)) {
            return;
        }

        switch (method) {
            case Constants.MethodID.LOCATION_SETOPTIONS:
                methodChannelHandler =
                        methodHandlerMap.get(Constants.MethodID.LOCATION_SETOPTIONS);
                break;
            case Constants.MethodID.LOCATION_SERIESLOC:
                methodChannelHandler =
                        methodHandlerMap.get(Constants.MethodID.LOCATION_SERIESLOC);
                break;
            case Constants.MethodID.LOCATION_STOPLOC:
                methodChannelHandler =
                        methodHandlerMap.get(Constants.MethodID.LOCATION_STOPLOC);
                break;
            case Constants.MethodID.LOCATION_CIRCLEGEOFENCE:
                methodChannelHandler =
                        methodHandlerMap.get(Constants.MethodID.LOCATION_CIRCLEGEOFENCE);
                break;
            case Constants.MethodID.LOCATION_POLYGONGEOFENCE:
                methodChannelHandler =
                        methodHandlerMap.get(Constants.MethodID.LOCATION_POLYGONGEOFENCE);
                break;
            case Constants.MethodID.LOCATION_GETALLGEOFENCEID:
                methodChannelHandler =
                        methodHandlerMap.get(Constants.MethodID.LOCATION_GETALLGEOFENCEID);
                break;
            case Constants.MethodID.LOCATION_NERWORKSTATE:
                methodChannelHandler =
                        methodHandlerMap.get(Constants.MethodID.LOCATION_NERWORKSTATE);
                break;
            case Constants.MethodID.LOCATION_STARTHEADING:
                methodChannelHandler =
                        methodHandlerMap.get(Constants.MethodID.LOCATION_STARTHEADING);
                break;
            case Constants.MethodID.LOCATION_STOPHEADING:
                methodChannelHandler =
                        methodHandlerMap.get(Constants.MethodID.LOCATION_STOPHEADING);
                break;
            default:
                break;
        }

        if (null != methodChannelHandler) {
            if (method.equals(Constants.MethodID.LOCATION_CIRCLEGEOFENCE) ||
                method.equals(Constants.MethodID.LOCATION_POLYGONGEOFENCE) ||
                method.equals(Constants.MethodID.LOCATION_REMOVEGEOFENCE) ||
                    method.equals(Constants.MethodID.LOCATION_GETALLGEOFENCEID)) {
                methodChannelHandler.handleMethodGeofenceCallResult(context, mGeoFenceClient, call, result);
            } else if (method.equals(Constants.MethodID.LOCATION_STARTHEADING) ||
                    method.equals(Constants.MethodID.LOCATION_STOPHEADING)){
                methodChannelHandler.handleMethodHeadingCallResult(context, call, result);
            } else {
                methodChannelHandler.handleMethodCallResult(mLocationClient, call, result);
            }
        }
    }
}
