package com.baidu.mapapi.search.handlers;

import android.text.TextUtils;
import android.util.Log;

import com.baidu.mapapi.search.Constants;
import com.baidu.mapapi.search.MethodChannelManager;
import com.baidu.mapapi.search.MethodID;
import com.baidu.mapapi.search.bean.result.ReverseGeoCodeResultBean;
import com.baidu.mapapi.search.bean.option.GeoCodeBean;
import com.baidu.mapapi.search.bean.result.GeoCodeResultBean;
import com.baidu.mapapi.search.bean.option.LatLngBean;
import com.baidu.mapapi.search.bean.option.ReverseGeoCodeBean;
import com.baidu.mapapi.search.utils.GsonFactory;
import com.baidu.mapapi.search.utils.ParseErrorCode;
import com.baidu.mapapi.model.LatLng;
import com.baidu.mapapi.search.core.SearchResult;
import com.baidu.mapapi.search.geocode.GeoCodeOption;
import com.baidu.mapapi.search.geocode.GeoCodeResult;
import com.baidu.mapapi.search.geocode.GeoCoder;
import com.baidu.mapapi.search.geocode.OnGetGeoCoderResultListener;
import com.baidu.mapapi.search.geocode.ReverseGeoCodeOption;
import com.baidu.mapapi.search.geocode.ReverseGeoCodeResult;
import com.google.gson.JsonSyntaxException;
import com.google.gson.reflect.TypeToken;

import java.util.HashMap;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public  class GeoCoderHandler extends MethodChannelHandler implements OnGetGeoCoderResultListener {
    private static final String Tag = GeoCoderHandler.class.getSimpleName();

    public GeoCoderHandler(){
        mGson = GsonFactory.getInstance().getGson();
        mMethodChannel = MethodChannelManager.getInstance().getSearchChannel();
    }

    @Override
    public void handleMethodCallResult(MethodCall call, MethodChannel.Result result) {
        super.handleMethodCallResult(call, result);
        if(null == mGson){
            return;
        }

        String methodID = call.method;
        if (TextUtils.isEmpty(methodID)) {
            return;
        }
        switch (methodID) {
            case MethodID.BMFGeoAndReverseGeoMethodID.GEO_CODE:
                searchGeoCode(call,result);
                break;

            case MethodID.BMFGeoAndReverseGeoMethodID.REVERSE_GEO_CODE:
                searchReverseGeoCode(call,result);
                break;

            default:
                break;
        }

    }

    @Override
    public void destroy() {

    }

    @Override
    public void sendSearchResult(Object value, int errorCode) {

    }

    @Override
    public void sendSearchResult(String MethodID, final Object value, final int errorCode) {
        if (null == mMethodChannel) {
            return;
        }

        mMethodChannel.invokeMethod(MethodID, new HashMap<String,
                Object>(){
            {
                put(Constants.RESULT_KEY, value);
                put(Constants.ERROR_KEY, errorCode);
            }
        });
    }

    /**
     * 逆地理编码查询
     */
    private void searchReverseGeoCode(MethodCall call, MethodChannel.Result result) {
        HashMap<String,Object> arguments= (HashMap<String, Object>) call.arguments;
        if (!arguments.containsKey("reverseGeoCodeSearchOption")) {
            sendReturnResult(false);
            return;
        }
        HashMap<String,Object> reverseGeoCodeSearchOption =
                (HashMap<String, Object>) arguments.get("reverseGeoCodeSearchOption");
        if (null == reverseGeoCodeSearchOption) {
            sendReturnResult(false);
            return;
        }

        String json = mGson.toJson(reverseGeoCodeSearchOption);
        if(TextUtils.isEmpty(json)){
            sendReturnResult(false);
            return;
        }
        ReverseGeoCodeBean reverseGeoCodeBean = null;
        try {
            reverseGeoCodeBean = mGson.fromJson(json, ReverseGeoCodeBean.class);
        }catch (JsonSyntaxException e) {
            Log.e(Tag, "fromJson error: " + e );
        }
        if (null == reverseGeoCodeBean) {
            sendReturnResult(false);
            return;
        }
        boolean isLatestAdmin = reverseGeoCodeBean.isLatestAdmin;
        LatLng location = reverseGeoCodeBean.location;
        int pageNum = reverseGeoCodeBean.pageNum;
        int pageSize = reverseGeoCodeBean.pageSize;
        int radius = reverseGeoCodeBean.radius;

        GeoCoder search = GeoCoder.newInstance();
        search.setOnGetGeoCodeResultListener(this);
        ReverseGeoCodeOption reverseGeoCodeOption = new ReverseGeoCodeOption();
        if (null == location) {
            sendReturnResult(false);
            return;
        }
        reverseGeoCodeOption.location(location);
        reverseGeoCodeOption.pageNum(pageNum);
        reverseGeoCodeOption.pageSize(pageSize);
        reverseGeoCodeOption.radius(radius);
        if (isLatestAdmin) {
            reverseGeoCodeOption.newVersion(1);
        } else {
            reverseGeoCodeOption.newVersion(0);
        }
        boolean ret = search.reverseGeoCode(reverseGeoCodeOption);
        sendReturnResult(ret);
        search.destroy();
    }

    /**
     * 正地理编码查询
     */
    private void searchGeoCode(MethodCall call, MethodChannel.Result result) {
        // 初始化搜索模块，注册事件监听
        GeoCoder search = GeoCoder.newInstance();
        search.setOnGetGeoCodeResultListener(this);
        HashMap<String,Object> arguments= (HashMap<String, Object>) call.arguments;
        GeoCodeOption geoCodeOption = new GeoCodeOption();
        if (!arguments.containsKey("geoCodeSearchOption")) {
            sendReturnResult(false);
            return;
        }
        HashMap<String,Object> geoCodeSearchOption = (HashMap<String, Object>) arguments.get("geoCodeSearchOption");
        if (null == geoCodeSearchOption) {
            sendReturnResult(false);
            return;
        }

        String json = mGson.toJson(geoCodeSearchOption);
        if(TextUtils.isEmpty(json)){
            sendReturnResult(false);
            return;
        }
        GeoCodeBean geoCodeBean = null;
        try {
            geoCodeBean = mGson.fromJson(json, GeoCodeBean.class);
        }catch (JsonSyntaxException e) {
            Log.e(Tag, "fromJson error: " + e );
        }
        if (null == geoCodeBean) {
            sendReturnResult(false);
            return;
        }

        String city = geoCodeBean.city;
        String address = geoCodeBean.address;
        if (TextUtils.isEmpty(city) || TextUtils.isEmpty(address)) {
            sendReturnResult(false);
            return;
        }
        geoCodeOption.city(city.trim());
        geoCodeOption.address(address.trim());
        boolean ret = search.geocode(geoCodeOption);
        sendReturnResult(ret);
        search.destroy();
    }

    @Override
    public void onGetGeoCodeResult(GeoCodeResult geoCodeResult) {
        if (null == geoCodeResult) {
            sendSearchResult(MethodID.BMFGeoAndReverseGeoMethodID.GEO_CODE, null, -1);
            return;
        }
        SearchResult.ERRORNO error = geoCodeResult.error;
        int errorCode = ParseErrorCode.getInstance().getErrorCode(error);

        GeoCodeResultBean geoCodeResultBean = new GeoCodeResultBean();
        geoCodeResultBean.confidence = geoCodeResult.getConfidence();
        geoCodeResultBean.level = geoCodeResult.getLevel();
        LatLng location = geoCodeResult.getLocation();
        if (null != location) {
            geoCodeResultBean.location = new LatLngBean(location.latitude, location.longitude);
        }

        geoCodeResultBean.precise = geoCodeResult.getPrecise();
        geoCodeResultBean.address = geoCodeResult.getAddress();

        HashMap resultHashMap = null;
        try{
            String resultJson = mGson.toJson(geoCodeResultBean);
            resultHashMap = mGson.fromJson(resultJson,new TypeToken<HashMap<String, Object>>() {}.getType());
        } catch (JsonSyntaxException e) {
            Log.e(Tag, "fromJson error: " + e );
        }
        if (null == resultHashMap) {
            sendSearchResult(MethodID.BMFGeoAndReverseGeoMethodID.GEO_CODE, null, -1);
            return;
        }

        sendSearchResult(MethodID.BMFGeoAndReverseGeoMethodID.GEO_CODE, resultHashMap, errorCode);
    }

    @Override
    public void onGetReverseGeoCodeResult(ReverseGeoCodeResult reverseGeoCodeResult) {
        if (null == reverseGeoCodeResult) {
            sendSearchResult(MethodID.BMFGeoAndReverseGeoMethodID.REVERSE_GEO_CODE, null, -1);
            return;
        }
        SearchResult.ERRORNO error = reverseGeoCodeResult.error;
        int errorCode = ParseErrorCode.getInstance().getErrorCode(error);

        ReverseGeoCodeResultBean reverseGeoCodeResultBean = new ReverseGeoCodeResultBean(reverseGeoCodeResult);

        HashMap resultHashMap = null;
        try{
            String resultJson = mGson.toJson(reverseGeoCodeResultBean);
            Log.e(Tag, "resultJson: " + resultJson);
            resultHashMap = mGson.fromJson(resultJson,new TypeToken<HashMap<String, Object>>() {}.getType());
        } catch (JsonSyntaxException e) {
            Log.e(Tag, "fromJson error: " + e );
        }
        if (null == resultHashMap) {
            sendSearchResult(MethodID.BMFGeoAndReverseGeoMethodID.REVERSE_GEO_CODE, null, -1);
            return;
        }

        sendSearchResult(MethodID.BMFGeoAndReverseGeoMethodID.REVERSE_GEO_CODE, resultHashMap, errorCode);
    }
}
