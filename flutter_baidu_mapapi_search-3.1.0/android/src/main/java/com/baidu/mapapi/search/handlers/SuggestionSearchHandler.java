package com.baidu.mapapi.search.handlers;

import android.text.TextUtils;
import android.util.Log;

import com.baidu.mapapi.search.Constants;

import java.util.HashMap;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

import com.baidu.mapapi.search.MethodChannelManager;
import com.baidu.mapapi.search.MethodID;
import com.baidu.mapapi.search.bean.option.SuggestionOptionBean;
import com.baidu.mapapi.search.bean.result.sugesstion.SuggestionResultBean;
import com.baidu.mapapi.search.utils.GsonFactory;
import com.baidu.mapapi.search.utils.ParseErrorCode;
import com.baidu.mapapi.search.core.SearchResult;
import com.baidu.mapapi.search.sug.OnGetSuggestionResultListener;
import com.baidu.mapapi.search.sug.SuggestionResult;
import com.baidu.mapapi.search.sug.SuggestionSearch;
import com.baidu.mapapi.search.sug.SuggestionSearchOption;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonSyntaxException;
import com.google.gson.reflect.TypeToken;

/**
 * 搜索建议handler
 */
public class SuggestionSearchHandler extends MethodChannelHandler implements OnGetSuggestionResultListener {

    private static final String TAG = SuggestionSearchHandler.class.getSimpleName();

    SuggestionSearch mSuggestionSearch;

    public SuggestionSearchHandler(){
        mSuggestionSearch = SuggestionSearch.newInstance();
        mGson = GsonFactory.getInstance().getGson();
        mMethodChannel = MethodChannelManager.getInstance().getSearchChannel();
    }

    @Override
    public void handleMethodCallResult(MethodCall call, MethodChannel.Result result) {
        super.handleMethodCallResult(call, result);
        HashMap<String, Object> argumentsMap = (HashMap<String, Object>) call.arguments;
        if (null == argumentsMap) {
            sendReturnResult(false);
            return;
        }

        HashMap<String, Object> buslineOptionMap = (HashMap<String, Object>) argumentsMap.get("suggestionSearchOption");
        if (null == buslineOptionMap) {
            sendReturnResult(false);
            return;
        }

        Gson gson = new GsonBuilder().enableComplexMapKeySerialization().create();

        String jsonStr = gson.toJson(buslineOptionMap);
        if (null == jsonStr) {
            sendReturnResult(false);
            return;
        }

        SuggestionOptionBean suggestionOptionBean = gson.fromJson(jsonStr, SuggestionOptionBean.class);
        if (null == suggestionOptionBean) {
            sendReturnResult(false);
            return;
        }

        if (TextUtils.isEmpty(suggestionOptionBean.cityname)) {
            sendReturnResult(false);
            return;
        }

        if (TextUtils.isEmpty(suggestionOptionBean.keyword)) {
            sendReturnResult(false);
            return;
        }


        SuggestionSearchOption suggestionSearchOption = new SuggestionSearchOption();
        suggestionSearchOption.mCity = suggestionOptionBean.cityname.trim();
        suggestionSearchOption.mKeyword = suggestionOptionBean.keyword.trim();
        suggestionSearchOption.mLocation = suggestionOptionBean.location;
        suggestionSearchOption.mCityLimit = suggestionOptionBean.cityLimit;

        mSuggestionSearch.setOnGetSuggestionResultListener(this);
        boolean ret = mSuggestionSearch.requestSuggestion(suggestionSearchOption);
        sendReturnResult(ret);
    }

    @Override
    public void destroy() {
        if (null != mSuggestionSearch) {
            mSuggestionSearch.destroy();
        }
    }

    @Override
    public void sendSearchResult(final Object value, final int errorCode) {
        if (null == mMethodChannel) {
            return;
        }

        mMethodChannel.invokeMethod(MethodID.SuggestionMethodID.SUGGESTION_METHOD_NAME,
                new HashMap<String, Object>(){
                    {
                        put(Constants.RESULT_KEY, value);
                        put(Constants.ERROR_KEY, errorCode);
                    }
                });
    }

    @Override
    public void onGetSuggestionResult(SuggestionResult suggestionResult) {
        if (null == mMethodChannel) {
            return;
        }
        if (null == suggestionResult) {
            sendSearchResult(null, -1);
            return;
        }

        SuggestionResultBean poiDetailShareUrlResultBean = new SuggestionResultBean(suggestionResult);

        String busLineResultJson = mGson.toJson(poiDetailShareUrlResultBean);
        if (TextUtils.isEmpty(busLineResultJson)) {
            sendSearchResult(null, -1);
            return;
        }

        try {
            final HashMap<String, Object> resultMap = mGson.fromJson(busLineResultJson, new TypeToken<HashMap<String, Object>>(){}.getType());
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
