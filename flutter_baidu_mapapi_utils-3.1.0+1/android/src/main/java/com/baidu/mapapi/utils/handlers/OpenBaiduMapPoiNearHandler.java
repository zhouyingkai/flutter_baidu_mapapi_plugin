package com.baidu.mapapi.utils.handlers;

import java.util.HashMap;

import com.baidu.mapapi.utils.Constants;
import com.baidu.mapapi.utils.FlutterBmfUtilsPlugin;
import com.baidu.mapapi.utils.bean.OpenBaiduPoiNearBean;
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
 * 打开附近poi
 */
public class OpenBaiduMapPoiNearHandler extends MethodChannelHandler {

    public static final String TAG = OpenBaiduMapPoiNearHandler.class.getSimpleName();

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

        HashMap<String, Object> nearOptions =
                (HashMap<String, Object>) argumentsMap.get("poiNearOption");

        if (null == nearOptions) {
            returnResult(Constants.ErrorCode.OPTION_ERROR);
            return;
        }
        if (nearOptions.containsKey("radius")) {
            Integer radius = (Integer) nearOptions.get("radius");
            if (radius <= 0) {
                returnResult(Constants.ErrorCode.OPTION_ERROR);
                return;
            }
        }
        Gson gson = new GsonBuilder().enableComplexMapKeySerialization().create();
        String json = gson.toJson(nearOptions);
        if (TextUtils.isEmpty(json)) {
            returnResult(Constants.ErrorCode.OPTION_ERROR);
            return;
        }

        OpenBaiduPoiNearBean openBaiduPoiNearBean = gson.fromJson(json, OpenBaiduPoiNearBean.class);
        openBaiduPoiNearImp(openBaiduPoiNearBean, result);
    }

    private void openBaiduPoiNearImp(OpenBaiduPoiNearBean openBaiduPoiNearBean,
                                     MethodChannel.Result result) {
        Context applicationContext = FlutterBmfUtilsPlugin.getApplicationContext();
        if (null == applicationContext) {
            returnResult(Constants.ErrorCode.OPEN_OTHER_ERROR);
            return;
        }

        PoiParaOption poiParaOption = toPoiNear(openBaiduPoiNearBean);
        if (null == poiParaOption) {
            returnResult(Constants.ErrorCode.OPTION_ERROR);
            return;
        }

        BaiduMapPoiSearch.setSupportWebPoi(openBaiduPoiNearBean.isSupportWeb);
        boolean ret = false;
        try {
            ret = BaiduMapPoiSearch.openBaiduMapPoiNearbySearch(poiParaOption, applicationContext);
        } catch (Exception e) {
            Log.e(TAG, e.toString());
        }

        if (true == ret) {
            returnResult(Constants.ErrorCode.OPEN_NO_ERROR);
        } else {
            returnResult(Constants.ErrorCode.OPEN_OTHER_ERROR);
        }
    }

    private PoiParaOption toPoiNear(OpenBaiduPoiNearBean openBaiduPoiNearBean) {
        if (null == openBaiduPoiNearBean) {
            return null;
        }

        PoiParaOption poiParaOption = new PoiParaOption();
        poiParaOption.key(openBaiduPoiNearBean.keyword);
        poiParaOption.center(openBaiduPoiNearBean.location);
        poiParaOption.radius(openBaiduPoiNearBean.radius);
        return poiParaOption;

    }
}