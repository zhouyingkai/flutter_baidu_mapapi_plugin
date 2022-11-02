package com.baidu.flutter_bmflocation;

import android.content.Context;

import com.baidu.geofence.GeoFenceClient;
import com.baidu.location.LocationClient;

import java.util.HashMap;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public abstract class MethodChannelHandler {

     // channel
    protected MethodChannel mMethodChannel = null;

    protected MethodChannel.Result mResult = null;

    public void handleMethodCallResult(LocationClient mLocationClient, MethodCall call, MethodChannel.Result result){
        mResult = result;
    }

    public void handleMethodGeofenceCallResult(
        Context context, GeoFenceClient mGeoFenceClient, MethodCall call, MethodChannel.Result result){
        mResult = result;
    }

    public void handleMethodHeadingCallResult(
            Context context, MethodCall call, MethodChannel.Result result){
        mResult = result;
    }

    public void sendReturnResult(final boolean ret){
        if (null == mResult){
            return;
        }

        mResult.success(new HashMap<String, Boolean>(){
            {
                put(Constants.RESULT_KEY, ret);
            }
        });
    }

    public void sendResultCallback(String methodID, final Object value, final int errorCode){
        if (null == mMethodChannel) {
            return;
        }

        mMethodChannel.invokeMethod(methodID, new HashMap<String,
                Object>(){
            {
                put(Constants.RESULT_KEY, value);
                put(Constants.ERROR_KEY, errorCode);
            }
        });
    }
}
