package com.baidu.mapapi.search.handlers;

import android.text.TextUtils;
import android.util.Log;

import com.baidu.mapapi.search.Constants;
import com.baidu.mapapi.search.MethodChannelManager;
import com.baidu.mapapi.search.MethodID;
import com.baidu.mapapi.search.bean.option.DistrictOptionBean;
import com.baidu.mapapi.search.bean.result.DisrictResultBean;
import com.baidu.mapapi.search.utils.GsonFactory;
import com.baidu.mapapi.search.utils.MapTypeAdapter;
import com.baidu.mapapi.search.utils.ParseErrorCode;
import com.baidu.mapapi.search.core.SearchResult;
import com.baidu.mapapi.search.district.DistrictResult;
import com.baidu.mapapi.search.district.DistrictSearch;
import com.baidu.mapapi.search.district.DistrictSearchOption;
import com.baidu.mapapi.search.district.OnGetDistricSearchResultListener;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonSyntaxException;
import com.google.gson.reflect.TypeToken;

import java.util.HashMap;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * 街区检索handler
 */
public  class DistrictSearchHandler extends MethodChannelHandler implements OnGetDistricSearchResultListener {
    private static final String TAG = DistrictSearchHandler.class.getSimpleName();


    private DistrictSearch mDistrictSearch;

    public DistrictSearchHandler(){
        mDistrictSearch = DistrictSearch.newInstance();
        mGson = GsonFactory.getInstance().getGson();
        mMethodChannel = MethodChannelManager.getInstance().getSearchChannel();
    }

    @Override
    public void handleMethodCallResult(MethodCall call, MethodChannel.Result result) {
        super.handleMethodCallResult(call, result);
        if(null == mGson || null == mDistrictSearch){
            sendReturnResult(false);
            return;
        }

        HashMap<String, Object> argumentsMap = (HashMap<String, Object>) call.arguments;
        if (null == argumentsMap) {
            sendReturnResult(false);
            return;
        }

        HashMap<String, Object> districtOptionMap = (HashMap<String, Object>) argumentsMap.get("districtSearchOption");
        if (null == districtOptionMap) {
            sendReturnResult(false);
            return;
        }

        String jsonStr = mGson.toJson(districtOptionMap);
        if (null == jsonStr) {
            sendReturnResult(false);
            return;
        }

        DistrictOptionBean districtOptionBean = mGson.fromJson(jsonStr, DistrictOptionBean.class);
        if (null == districtOptionBean) {
            sendReturnResult(false);
            return;
        }

        if (TextUtils.isEmpty(districtOptionBean.city)) {
            sendReturnResult(false);
            return;
        }

        if (TextUtils.isEmpty(districtOptionBean.district)) {
            sendReturnResult(false);
            return;
        }

        DistrictSearchOption districtSearchOption = new DistrictSearchOption();
        districtSearchOption.mCityName = districtOptionBean.city.trim();
        districtSearchOption.mDistrictName = districtOptionBean.district.trim();

        DistrictSearch districtSearch = DistrictSearch.newInstance();
        districtSearch.setOnDistrictSearchListener(this);

        boolean ret = districtSearch.searchDistrict(districtSearchOption);

        sendReturnResult(ret);
    }

    @Override
    public void destroy() {
        if (null != mDistrictSearch) {
            mDistrictSearch.destroy();
        }
    }

    @Override
    public void sendSearchResult(final Object value, final int errorCode) {
        if (null == mMethodChannel) {
            return;
        }

        mMethodChannel.invokeMethod(MethodID.BMFDistrictSearchMethodID.DISTRICT_SEARCH, new HashMap<String,
                Object>(){
            {
                put(Constants.RESULT_KEY, value);
                put(Constants.ERROR_KEY, errorCode);
            }
        });
    }

    @Override
    public void onGetDistrictResult(DistrictResult districtResult) {
        if(null == districtResult){
            sendSearchResult(null, -1);
            return;
        }

        DisrictResultBean disrictResultBean = new DisrictResultBean(districtResult);

        Gson gson =
                new GsonBuilder().registerTypeAdapter(new TypeToken<HashMap<String, Object>>() { }
                .getType(), new MapTypeAdapter()).enableComplexMapKeySerialization().create();
        String busLineResultJson = gson.toJson(disrictResultBean);
        if(TextUtils.isEmpty(busLineResultJson)){
            sendSearchResult(null, -1);
            return;
        }

        try {
            final HashMap<String, Object> resultMap = gson.fromJson(busLineResultJson, new TypeToken<HashMap<String, Object>>(){}.getType());
            String errorStr = (String)resultMap.get("error");
            if(TextUtils.isEmpty(errorStr)){
                sendSearchResult(null, -1);
                return;
            }

            int errorCode = ParseErrorCode.getInstance().getErrorCode(SearchResult.ERRORNO.valueOf(errorStr));
            sendSearchResult(resultMap, errorCode);
        }catch (JsonSyntaxException e){
            Log.e(TAG, e.toString());
        }
    }
}
