package com.baidu.mapapi.search.handlers;

import android.text.TextUtils;
import android.util.Log;

import com.baidu.mapapi.search.Constants;
import com.baidu.mapapi.search.MethodChannelManager;
import com.baidu.mapapi.search.MethodID;
import com.baidu.mapapi.search.bean.option.RecommendOptionBean;
import com.baidu.mapapi.search.bean.result.recommend.RecommendStopBean;
import com.baidu.mapapi.search.core.SearchResult;
import com.baidu.mapapi.search.recommendstop.OnGetRecommendStopResultListener;
import com.baidu.mapapi.search.recommendstop.RecommendStopResult;
import com.baidu.mapapi.search.recommendstop.RecommendStopSearch;
import com.baidu.mapapi.search.recommendstop.RecommendStopSearchOption;
import com.baidu.mapapi.search.utils.GsonFactory;
import com.baidu.mapapi.search.utils.ParseErrorCode;
import com.google.gson.JsonSyntaxException;
import com.google.gson.reflect.TypeToken;

import java.util.HashMap;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;


public class RecommendStopHandler extends MethodChannelHandler implements OnGetRecommendStopResultListener {
    private static final String TAG = RecommendStopHandler.class.getSimpleName();

    private RecommendStopSearch mRecommendStopSearch;

    public RecommendStopHandler() {
        mRecommendStopSearch = RecommendStopSearch.newInstance();
        mRecommendStopSearch.setOnGetRecommendStopResultListener(this);
        mGson = GsonFactory.getInstance().getGson();
        mMethodChannel = MethodChannelManager.getInstance().getSearchChannel();
    }

    @Override
    public void handleMethodCallResult(MethodCall call, MethodChannel.Result result) {
        super.handleMethodCallResult(call, result);
        if (null == mGson || null == mRecommendStopSearch) {
            sendReturnResult(false);
            return;
        }

        HashMap<String, Object> argumentsMap = (HashMap<String, Object>) call.arguments;
        if (null == argumentsMap) {
            sendReturnResult(false);
            return;
        }

        HashMap<String, Object> recommendStopMap =
                (HashMap<String, Object>) argumentsMap.get("recommendStopSearchOption");
        if (null == recommendStopMap) {
            sendReturnResult(false);
            return;
        }

        String jsonStr = mGson.toJson(recommendStopMap);
        if (null == jsonStr) {
            sendReturnResult(false);
            return;
        }

        RecommendOptionBean recommendOptionBean = mGson.fromJson(jsonStr, RecommendOptionBean.class);
        if (null == recommendOptionBean) {
            sendReturnResult(false);
            return;
        }

        RecommendStopSearchOption recommendStopSearchOption = new RecommendStopSearchOption();
        recommendStopSearchOption.mLocation = recommendOptionBean.location;
        boolean ret = mRecommendStopSearch.requestRecommendStop(recommendStopSearchOption);

        sendReturnResult(ret);
    }

    @Override
    public void destroy() {
        if (mRecommendStopSearch != null) {
            mRecommendStopSearch.destroy();
        }
    }

    @Override
    public void sendSearchResult(final Object value, final int errorCode) {
        if (null == mMethodChannel) {
            return;
        }

        mMethodChannel.invokeMethod(MethodID.BMFRecommendStopSearchMethodID.RECOMMEND_STOP_SEARCH, new HashMap<String,
                Object>() {
            {
                put(Constants.RESULT_KEY, value);
                put(Constants.ERROR_KEY, errorCode);
            }
        });
    }

    @Override
    public void onGetRecommendStopResult(RecommendStopResult recommendStopResult) {
        if (null == mMethodChannel) {
            return;
        }

        if (null == recommendStopResult) {
            sendSearchResult(null, -1);
            return;
        }

        RecommendStopBean recommendStopBean = new RecommendStopBean(recommendStopResult);
        String recommendResultJson = mGson.toJson(recommendStopBean);
        if (TextUtils.isEmpty(recommendResultJson)) {
            sendSearchResult(null, -1);
            return;
        }

        try {
            final HashMap<String, Object> resultMap = mGson.fromJson(recommendResultJson,
                    new TypeToken<HashMap<String, Object>>() {
                    }.getType());
            String errorStr = (String) resultMap.get("error");
            if (TextUtils.isEmpty(errorStr)) {
                sendSearchResult(null, -1);
                return;
            }

            int errorCode = ParseErrorCode.getInstance().getErrorCode(SearchResult.ERRORNO.valueOf(errorStr));
            sendSearchResult(resultMap, errorCode);
        } catch (JsonSyntaxException e) {
            Log.e(TAG, e.toString());
        }
    }
}
