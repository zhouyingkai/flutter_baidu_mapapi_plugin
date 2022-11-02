package com.baidu.mapapi.search.handlers;

import java.util.HashMap;

import com.baidu.mapapi.search.Constants;
import com.google.gson.Gson;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * handler公共类
 */
public abstract class MethodChannelHandler {
    protected Gson mGson = null;

    protected MethodChannel mMethodChannel = null;

    protected MethodChannel.Result mResult = null;

    public void handleMethodCallResult(MethodCall call, MethodChannel.Result result){
        mResult = result;
    }

    public abstract void destroy();

    public void sendReturnResult(final boolean ret){
        if(null == mResult){
            return;
        }

        mResult.success(new HashMap<String, Boolean>(){
            {
                put(Constants.RESULT_KEY, ret);
            }
        });
    }

    public abstract void sendSearchResult(final Object value, final int errorCode);
    public void sendSearchResult(String methodID, final Object value, final int errorCode){
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