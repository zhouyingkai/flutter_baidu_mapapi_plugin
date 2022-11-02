package com.baidu.flutter_bmflocation;

import io.flutter.plugin.common.MethodChannel;

public class MethodChannelManager {
    /* 声明实例对象 */
    private  static  MethodChannelManager sInstance;

     // 声明methodChannel
    private static MethodChannel mLocationChannel;

    /* 返回实例对象 */
    public  static  MethodChannelManager getInstance() {
        if (null == sInstance) {
            sInstance = new MethodChannelManager();
        }
        return sInstance;
    }

     // 设置methodChannel
    public  void   putLocationChannel(MethodChannel methodChannel) {
        mLocationChannel = methodChannel;
    }

     // 获取channel
    public  MethodChannel getLocationChannel() {
        return mLocationChannel;
    }

}
