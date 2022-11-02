package com.baidu.mapapi.search.handlers;

import java.util.HashMap;

import com.baidu.mapapi.search.Constants;
import com.baidu.mapapi.search.MethodChannelManager;
import com.baidu.mapapi.search.MethodID;
import com.baidu.mapapi.search.bean.option.BuslineOptionBean;
import com.baidu.mapapi.search.bean.result.busline.BusLineResultBean;
import com.baidu.mapapi.search.busline.BusLineResult;
import com.baidu.mapapi.search.busline.BusLineSearch;
import com.baidu.mapapi.search.busline.BusLineSearchOption;
import com.baidu.mapapi.search.busline.OnGetBusLineSearchResultListener;
import com.baidu.mapapi.search.core.SearchResult;
import com.baidu.mapapi.search.utils.GsonFactory;
import com.baidu.mapapi.search.utils.ParseErrorCode;
import com.google.gson.JsonSyntaxException;
import com.google.gson.reflect.TypeToken;

import android.text.TextUtils;
import android.util.Log;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * 公交线路检索handler
 */
public class BusLineSearchHandler extends MethodChannelHandler
        implements OnGetBusLineSearchResultListener {

    private static final String TAG = BusLineSearchHandler.class.getSimpleName();

    private BusLineSearch mBusLineSearch;

    public BusLineSearchHandler() {
        mBusLineSearch = BusLineSearch.newInstance();
        mGson = GsonFactory.getInstance().getGson();
        mMethodChannel = MethodChannelManager.getInstance().getSearchChannel();
    }

    @Override
    public void handleMethodCallResult(MethodCall call, MethodChannel.Result result) {
        super.handleMethodCallResult(call, result);
        if (null == mGson || null == mBusLineSearch) {
            sendReturnResult(false);
            return;
        }

        HashMap<String, Object> argumentsMap = (HashMap<String, Object>) call.arguments;
        if (null == argumentsMap) {
            sendReturnResult(false);
            return;
        }

        HashMap<String, Object> buslineOptionMap =
                (HashMap<String, Object>) argumentsMap.get("busLineSearchOption");
        if (null == buslineOptionMap) {
            sendReturnResult(false);
            return;
        }

        String jsonStr = mGson.toJson(buslineOptionMap);
        if (null == jsonStr) {
            sendReturnResult(false);
            return;
        }

        BuslineOptionBean buslineOptionBean = mGson.fromJson(jsonStr, BuslineOptionBean.class);
        if (null == buslineOptionBean) {
            sendReturnResult(false);
            return;
        }

        if (TextUtils.isEmpty(buslineOptionBean.city)) {
            sendReturnResult(false);
            return;
        }

        if (TextUtils.isEmpty(buslineOptionBean.busLineUid)) {
            sendReturnResult(false);
            return;
        }

        BusLineSearchOption busLineSearchOption = new BusLineSearchOption();
        busLineSearchOption.mCity = buslineOptionBean.city.trim();
        busLineSearchOption.mUid = buslineOptionBean.busLineUid.trim();

        mBusLineSearch.setOnGetBusLineSearchResultListener(this);
        boolean ret = mBusLineSearch.searchBusLine(busLineSearchOption);

        sendReturnResult(ret);
    }

    @Override
    public void destroy() {
        if (null != mBusLineSearch) {
            mBusLineSearch.destroy();
        }
    }

    @Override
    public void sendSearchResult(final Object value, final int errorCode) {
        if (null == mMethodChannel) {
            return;
        }

        mMethodChannel
                .invokeMethod(MethodID.BuslineSearchMethodID.BUSLINE_SEARCH, new HashMap<String,
                        Object>() {
                    {
                        put(Constants.RESULT_KEY, value);
                        put(Constants.ERROR_KEY, errorCode);
                    }
                });
    }

    @Override
    public void onGetBusLineResult(BusLineResult busLineResult) {
        if (null == busLineResult) {
            sendSearchResult(null, -1);
            return;
        }

        BusLineResultBean busLineResultBean = new BusLineResultBean(busLineResult);

        String busLineResultJson = mGson.toJson(busLineResultBean);
        if (TextUtils.isEmpty(busLineResultJson)) {
            sendSearchResult(null, -1);
            return;
        }

        try {
            final HashMap<String, Object> resultMap =
                    mGson.fromJson(busLineResultJson, new TypeToken<HashMap<String, Object>>() {
                    }.getType());
            String errorStr = (String) resultMap.get("error");
            if (TextUtils.isEmpty(errorStr)) {
                sendSearchResult(null, -1);
                return;
            }

            int errorCode = ParseErrorCode.getInstance()
                    .getErrorCode(SearchResult.ERRORNO.valueOf(errorStr));

            sendSearchResult(resultMap, errorCode);
        } catch (JsonSyntaxException e) {
            Log.e(TAG, e.toString());
        }
    }
}
