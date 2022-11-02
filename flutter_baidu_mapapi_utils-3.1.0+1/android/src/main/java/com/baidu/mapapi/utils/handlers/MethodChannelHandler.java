package com.baidu.mapapi.utils.handlers;

import java.util.HashMap;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * handler公共类
 */
public abstract class MethodChannelHandler {
    MethodChannel.Result mResult = null;

    public void handlerMethodCallResult(MethodCall call, MethodChannel.Result result) {
        mResult = result;
    }

    public void returnResult(final Object value) {
        if (null == mResult || null == value) {
            return;
        }

        mResult.success(new HashMap<String, Object>() {
            {
                put("result", value);
            }
        });
    }

    public void returnResult(final String key, final Object value) {
        if (null == mResult || null == value) {
            return;
        }

        mResult.success(new HashMap<String, Object>() {
            {
                put(key, value);
            }
        });
    }
}