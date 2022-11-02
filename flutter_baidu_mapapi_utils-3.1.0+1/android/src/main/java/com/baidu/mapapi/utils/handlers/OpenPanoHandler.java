package com.baidu.mapapi.utils.handlers;

import java.util.HashMap;

import com.baidu.mapapi.utils.Constants;
import com.baidu.mapapi.utils.FlutterBmfUtilsPlugin;
import com.baidu.mapapi.utils.OpenClientUtil;
import com.baidu.mapapi.utils.bean.PanoOptionBean;
import com.baidu.mapapi.utils.poi.BaiduMapPoiSearch;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import android.content.Context;
import android.text.TextUtils;
import android.util.Log;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import com.baidu.mapapi.utils.Env;

/**
 * 打开全景
 */
public class OpenPanoHandler extends MethodChannelHandler {

    public static final String TAG = OpenPanoHandler.class.getSimpleName();

    @Override
    public void handlerMethodCallResult(MethodCall call, MethodChannel.Result result) {
        super.handlerMethodCallResult(call, result);
        if (Env.DEBUG) {
            Log.d(TAG, "handlerMethodCallResult enter" + call.arguments.toString());
        }

        if (null == call.arguments) {
            returnResult(Constants.ErrorCode.OPEN_OPTION_NULL);
            return;
        }

        HashMap<String, Object> argumentsMap = (HashMap<String, Object>) call.arguments;
        if (null == argumentsMap) {
            returnResult(Constants.ErrorCode.OPEN_OPTION_NULL);
            return;
        }

        HashMap<String, Object> naviOptions =
                (HashMap<String, Object>) argumentsMap.get("panoramaOption");
        if (null == naviOptions) {
            returnResult(Constants.ErrorCode.OPEN_OPTION_NULL);
            return;
        }

        Gson gson = new GsonBuilder().enableComplexMapKeySerialization().create();
        String json = gson.toJson(naviOptions);
        if (TextUtils.isEmpty(json)) {
            returnResult(Constants.ErrorCode.OPTION_ERROR);
            return;
        }

        PanoOptionBean panoOptionBean = gson.fromJson(json, PanoOptionBean.class);
        openBaiduPanoImp(panoOptionBean);

    }

    private void openBaiduPanoImp(PanoOptionBean panoOptionBean) {
        Context applicationContext = FlutterBmfUtilsPlugin.getApplicationContext();
        if (null == applicationContext) {
            returnResult(Constants.ErrorCode.OPEN_OTHER_ERROR);
            return;
        }

        if (0 == OpenClientUtil.getBaiduMapVersion(applicationContext)) {
            returnResult(Constants.ErrorCode.OPEN_NOT_SUPPORT);
            return;
        }

        try {
            BaiduMapPoiSearch.openBaiduMapPanoShow(panoOptionBean.poiUid, applicationContext);
        } catch (Exception e) {
            returnResult(Constants.ErrorCode.OPEN_OTHER_ERROR);
            Log.e(TAG, e.toString());
        }
    }
}
