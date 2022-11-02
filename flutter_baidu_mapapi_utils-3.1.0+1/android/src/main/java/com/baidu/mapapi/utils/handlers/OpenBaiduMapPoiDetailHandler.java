package com.baidu.mapapi.utils.handlers;

import java.util.HashMap;

import com.baidu.mapapi.utils.Constants.ErrorCode;
import com.baidu.mapapi.utils.FlutterBmfUtilsPlugin;
import com.baidu.mapapi.utils.bean.OpenBaiduPoiDetailBean;
import com.baidu.mapapi.utils.poi.BaiduMapPoiSearch;
import com.baidu.mapapi.utils.poi.PoiParaOption;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import android.content.Context;
import android.text.TextUtils;
import android.util.Log;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import com.baidu.mapapi.utils.Env;

/**
 * 打开poi详情
 */
public class OpenBaiduMapPoiDetailHandler extends MethodChannelHandler {

    public static final String TAG = OpenBaiduMapPoiDetailHandler.class.getSimpleName();

    @Override
    public void handlerMethodCallResult(MethodCall call, MethodChannel.Result result) {
        super.handlerMethodCallResult(call, result);
        if (Env.DEBUG) {
            Log.d(TAG, "handlerMethodCallResult enter" + call.arguments.toString());
        }

        if (null == call.arguments) {
            returnResult(ErrorCode.OPEN_OPTION_NULL);
            return;
        }

        HashMap<String, Object> argumentsMap = (HashMap<String, Object>) call.arguments;
        if (null == argumentsMap) {
            returnResult(ErrorCode.OPEN_OPTION_NULL);
            return;
        }

        HashMap<String, Object> naviOptions =
                (HashMap<String, Object>) argumentsMap.get("poiDetailOption");
        if (null == naviOptions) {
            returnResult(ErrorCode.OPEN_OPTION_NULL);
            return;
        }

        Gson gson = new GsonBuilder().enableComplexMapKeySerialization().create();
        String json = gson.toJson(naviOptions);
        if (TextUtils.isEmpty(json)) {
            returnResult(ErrorCode.OPTION_ERROR);
            return;
        }

        OpenBaiduPoiDetailBean openBaiduPoiDetailBean =
                gson.fromJson(json, OpenBaiduPoiDetailBean.class);
        openBaiduPoiDetailImp(openBaiduPoiDetailBean, result);
    }

    private void openBaiduPoiDetailImp(OpenBaiduPoiDetailBean openBaiduPoiDetailBean,
                                       MethodChannel.Result result) {
        Context applicationContext = FlutterBmfUtilsPlugin.getApplicationContext();
        if (null == applicationContext) {
            returnResult(ErrorCode.OPEN_OTHER_ERROR);
            return;
        }

        PoiParaOption poiParaOption = toPoiParaOption(openBaiduPoiDetailBean);
        if (null == poiParaOption) {
            returnResult(ErrorCode.OPTION_ERROR);
            return;
        }

        BaiduMapPoiSearch.setSupportWebPoi(openBaiduPoiDetailBean.isSupportWeb);

        boolean ret = false;
        try {
            ret = BaiduMapPoiSearch.openBaiduMapPoiDetialsPage(poiParaOption, applicationContext);
        } catch (Exception e) {
            Log.e(TAG, e.toString());
        }

        if (true == ret) {
            returnResult(ErrorCode.OPEN_NO_ERROR);
        } else {
            returnResult(ErrorCode.OPEN_OTHER_ERROR);
        }
    }

    private PoiParaOption toPoiParaOption(OpenBaiduPoiDetailBean openBaiduPoiDetailBean) {
        if (null == openBaiduPoiDetailBean) {
            return null;
        }

        PoiParaOption poiParaOption = new PoiParaOption();
        poiParaOption.uid(openBaiduPoiDetailBean.poiUid);
        return poiParaOption;
    }
}