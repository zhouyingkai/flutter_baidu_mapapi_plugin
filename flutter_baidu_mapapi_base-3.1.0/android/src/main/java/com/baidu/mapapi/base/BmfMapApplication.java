package com.baidu.mapapi.base;

import android.app.Application;
import android.content.Context;

import com.baidu.mapapi.SDKInitializer;
import com.baidu.mapapi.common.BaiduMapSDKException;

/**
 * BmfMapApplicationt有两种使用方式：
 * 1、直接继承与BmfMapApplication
 * 2、将onCreate里的初始化逻辑拷到业务工程Application的onCreate函数里
 */
public class BmfMapApplication extends Application {

    public static Context mContext;

    @Override
    public void onCreate() {
        super.onCreate();
        mContext = getApplicationContext();
        try {
            SDKInitializer.setAgreePrivacy(this, false);
            SDKInitializer.initialize(this);
        } catch (BaiduMapSDKException e) {
            e.getMessage();
        }
    }
}
