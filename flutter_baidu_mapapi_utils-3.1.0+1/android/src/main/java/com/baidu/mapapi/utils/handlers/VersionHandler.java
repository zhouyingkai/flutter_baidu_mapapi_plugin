package com.baidu.mapapi.utils.handlers;

import java.util.HashMap;
import java.util.Map;

import com.baidu.mapapi.VersionInfo;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class VersionHandler extends MethodChannelHandler {
    @Override
    public void handlerMethodCallResult(MethodCall call, MethodChannel.Result result) {
        super.handlerMethodCallResult(call, result);
        if (null == result) {
            return;
        }

        Map<String, String> versionMap = new HashMap<>();
        versionMap.put("version", VersionInfo.getApiVersion());
        versionMap.put("platform", "Android");
        result.success(versionMap);

    }
}
