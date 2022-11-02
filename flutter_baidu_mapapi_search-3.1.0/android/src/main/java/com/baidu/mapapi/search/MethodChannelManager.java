package com.baidu.mapapi.search;

import io.flutter.plugin.common.MethodChannel;

public class MethodChannelManager {
    private static MethodChannelManager sInstance;

    private MethodChannel mSearchChannel;

    public static MethodChannelManager getInstance() {
        if (null == sInstance) {
            sInstance = new MethodChannelManager();
        }

        return sInstance;
    }

    public void putSearchChannel(MethodChannel methodChannel) {
        mSearchChannel = methodChannel;
    }

    public MethodChannel getSearchChannel() {
        return mSearchChannel;
    }

}
