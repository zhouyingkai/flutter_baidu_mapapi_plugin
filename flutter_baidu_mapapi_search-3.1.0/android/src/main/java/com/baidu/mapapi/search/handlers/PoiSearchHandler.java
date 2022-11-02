package com.baidu.mapapi.search.handlers;

import java.util.HashMap;

import com.baidu.mapapi.search.Constants;
import com.baidu.mapapi.search.MethodChannelManager;
import com.baidu.mapapi.search.MethodID;
import com.baidu.mapapi.search.bean.option.poi.PoiBoundSearchOptionBean;
import com.baidu.mapapi.search.bean.option.poi.PoiCitySearchOptionBean;
import com.baidu.mapapi.search.bean.option.poi.PoiDetailSearchOptionBean;
import com.baidu.mapapi.search.bean.option.poi.PoiIndoorSearchOptionBean;
import com.baidu.mapapi.search.bean.option.poi.PoiNearbySearchOptionBean;
import com.baidu.mapapi.search.bean.result.poi.PoiDetailResultBean;
import com.baidu.mapapi.search.bean.result.poi.PoiDetailSearchResultBean;
import com.baidu.mapapi.search.bean.result.poi.PoiIndoorResultBean;
import com.baidu.mapapi.search.bean.result.poi.PoiResultBean;
import com.baidu.mapapi.search.core.SearchResult;
import com.baidu.mapapi.search.poi.OnGetPoiSearchResultListener;
import com.baidu.mapapi.search.poi.PoiBoundSearchOption;
import com.baidu.mapapi.search.poi.PoiCitySearchOption;
import com.baidu.mapapi.search.poi.PoiDetailResult;
import com.baidu.mapapi.search.poi.PoiDetailSearchOption;
import com.baidu.mapapi.search.poi.PoiDetailSearchResult;
import com.baidu.mapapi.search.poi.PoiIndoorOption;
import com.baidu.mapapi.search.poi.PoiIndoorResult;
import com.baidu.mapapi.search.poi.PoiNearbySearchOption;
import com.baidu.mapapi.search.poi.PoiResult;
import com.baidu.mapapi.search.poi.PoiSearch;
import com.baidu.mapapi.search.utils.GsonFactory;
import com.baidu.mapapi.search.utils.ParseErrorCode;
import com.google.gson.JsonSyntaxException;
import com.google.gson.reflect.TypeToken;

import android.text.TextUtils;
import android.util.Log;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class PoiSearchHandler extends MethodChannelHandler implements OnGetPoiSearchResultListener {

    private static final String TAG = PoiSearchHandler.class.getSimpleName();

    private PoiSearch mPoiSearch = null;

    /**
     * 仅用来区分poiSearch的handle类型，默认为citySearch
     */
    private int mPoiSearchHandleType = Constants.HandlerType.POI_CITY_SEARCH;

    public PoiSearchHandler(int handleType) {
        mPoiSearch = PoiSearch.newInstance();
        mPoiSearch.setOnGetPoiSearchResultListener(this);
        mGson = GsonFactory.getInstance().getGson();
        mMethodChannel = MethodChannelManager.getInstance().getSearchChannel();
        mPoiSearchHandleType = handleType;
    }

    public PoiSearchHandler() {
        mPoiSearch = PoiSearch.newInstance();
        mPoiSearch.setOnGetPoiSearchResultListener(this);
        mGson = GsonFactory.getInstance().getGson();
        mMethodChannel = MethodChannelManager.getInstance().getSearchChannel();
    }

    @Override
    public void handleMethodCallResult(MethodCall call, MethodChannel.Result result) {
        super.handleMethodCallResult(call, result);

        if (null == mGson || null == mPoiSearch) {
            return;
        }

        String methodId = call.method;
        switch (methodId) {
            case MethodID.PoiMethodID.POI_DETAIL_SEARCH:
                handlePoiDetailSearchCallResult(call, result);
                break;
            case MethodID.PoiMethodID.POI_INDOOR_SEARCH:
                handlePoiIndoorSearchCallResult(call, result);
                break;
            case MethodID.PoiMethodID.POI_SEARCH_INBOUNDS:
                handlePoiInBoundsSearchCallResult(call, result);
                break;
            case MethodID.PoiMethodID.POI_SEARCH_NEARBY:
                handlePoiNearbySearchCallResult(call, result);
                break;
            case MethodID.PoiMethodID.POI_SEARCHIN_CITY:
                handlePoiCitySearchCallResult(call, result);
                break;
            default:
                break;
        }
    }

    @Override
    public void destroy() {
        if (null != mPoiSearch) {
            mPoiSearch.destroy();
        }
    }

    @Override
    public void sendSearchResult(Object value, int errorCode) {

    }

    private void handlePoiDetailSearchCallResult(MethodCall call, MethodChannel.Result result) {
        HashMap<String, Object> argumentsMap = (HashMap<String, Object>) call.arguments;
        if (null == argumentsMap) {
            sendReturnResult(false);
            return;
        }

        HashMap<String, Object> buslineOptionMap =
                (HashMap<String, Object>) argumentsMap.get("poiDetailSearchOption");
        if (null == buslineOptionMap) {
            sendReturnResult(false);
            return;
        }

        String jsonStr = mGson.toJson(buslineOptionMap);
        if (null == jsonStr) {
            sendReturnResult(false);
            return;
        }

        PoiDetailSearchOptionBean poiDetailSearchOptionBean = mGson
                .fromJson(jsonStr, PoiDetailSearchOptionBean.class);
        if (null == poiDetailSearchOptionBean) {
            sendReturnResult(false);
            return;
        }

        PoiDetailSearchOption poiDetailSearchOption =
                poiDetailSearchOptionBean.toPoiDetaioSearchOption();
        if (null == poiDetailSearchOption) {
            sendReturnResult(false);
            return;
        }

        boolean ret = mPoiSearch.searchPoiDetail(poiDetailSearchOption);

        sendReturnResult(ret);
    }

    private void handlePoiIndoorSearchCallResult(MethodCall call, MethodChannel.Result result) {
        HashMap<String, Object> argumentsMap = (HashMap<String, Object>) call.arguments;
        if (null == argumentsMap) {
            sendReturnResult(false);
            return;
        }

        HashMap<String, Object> buslineOptionMap =
                (HashMap<String, Object>) argumentsMap.get("poiIndoorSearchOption");
        if (null == buslineOptionMap) {
            sendReturnResult(false);
            return;
        }

        String jsonStr = mGson.toJson(buslineOptionMap);
        if (null == jsonStr) {
            sendReturnResult(false);
            return;
        }

        PoiIndoorSearchOptionBean poiIndoorSearchOptionBean = mGson
                .fromJson(jsonStr, PoiIndoorSearchOptionBean.class);
        if (null == poiIndoorSearchOptionBean) {
            sendReturnResult(false);
            return;
        }

        PoiIndoorOption poiIndoorSearchOption = poiIndoorSearchOptionBean.toPoiIndoorSearchOption();
        if (null == poiIndoorSearchOption) {
            sendReturnResult(false);
            return;
        }

        boolean ret = mPoiSearch.searchPoiIndoor(poiIndoorSearchOption);

        sendReturnResult(ret);
    }

    private void handlePoiInBoundsSearchCallResult(MethodCall call, MethodChannel.Result result) {
        HashMap<String, Object> argumentsMap = (HashMap<String, Object>) call.arguments;
        if (null == argumentsMap) {
            sendReturnResult(false);
            return;
        }

        HashMap<String, Object> buslineOptionMap =
                (HashMap<String, Object>) argumentsMap.get("poiBoundSearchOption");
        if (null == buslineOptionMap) {
            sendReturnResult(false);
            return;
        }

        String jsonStr = mGson.toJson(buslineOptionMap);
        if (null == jsonStr) {
            sendReturnResult(false);
            return;
        }

        PoiBoundSearchOptionBean poiBoundSearchOptionBean = mGson.fromJson(jsonStr,
                PoiBoundSearchOptionBean.class);
        if (null == poiBoundSearchOptionBean) {
            sendReturnResult(false);
            return;
        }

        PoiBoundSearchOption poiBoundSearchOption =
                poiBoundSearchOptionBean.toPoiBoundsSeatchOption();

        boolean ret = mPoiSearch.searchInBound(poiBoundSearchOption);

        sendReturnResult(ret);
    }

    private void handlePoiNearbySearchCallResult(MethodCall call, MethodChannel.Result result) {
        HashMap<String, Object> argumentsMap = (HashMap<String, Object>) call.arguments;
        if (null == argumentsMap) {
            sendReturnResult(false);
            return;
        }

        HashMap<String, Object> buslineOptionMap =
                (HashMap<String, Object>) argumentsMap.get("poiNearbySearchOption");
        if (null == buslineOptionMap) {
            sendReturnResult(false);
            return;
        }

        String jsonStr = mGson.toJson(buslineOptionMap);
        if (null == jsonStr) {
            sendReturnResult(false);
            return;
        }

        PoiNearbySearchOptionBean poiNearbySearchOptionBean = mGson.fromJson(jsonStr,
                PoiNearbySearchOptionBean.class);
        if (null == poiNearbySearchOptionBean) {
            sendReturnResult(false);
            return;
        }

        PoiNearbySearchOption poiNearbySearchOption =
                poiNearbySearchOptionBean.toPoiNearbySearchOption();

        if (null == poiNearbySearchOption) {
            sendReturnResult(false);
            return;
        }

        boolean ret = mPoiSearch.searchNearby(poiNearbySearchOption);

        sendReturnResult(ret);
    }

    private void handlePoiCitySearchCallResult(MethodCall call, MethodChannel.Result result) {
        HashMap<String, Object> argumentsMap = (HashMap<String, Object>) call.arguments;
        if (null == argumentsMap) {
            sendReturnResult(false);
            return;
        }

        HashMap<String, Object> buslineOptionMap =
                (HashMap<String, Object>) argumentsMap.get("poiCitySearchOption");
        if (null == buslineOptionMap) {
            sendReturnResult(false);
            return;
        }

        String jsonStr = mGson.toJson(buslineOptionMap);
        if (null == jsonStr) {
            sendReturnResult(false);
            return;
        }

        PoiCitySearchOptionBean poiCitySearchOptionBean = mGson.fromJson(jsonStr,
                PoiCitySearchOptionBean.class);
        if (null == poiCitySearchOptionBean) {
            sendReturnResult(false);
            return;
        }

        PoiCitySearchOption poiCitySearchOption = poiCitySearchOptionBean.toPoiCitySearchOption();
        if (null == poiCitySearchOption) {
            sendReturnResult(false);
            return;
        }

        boolean ret = mPoiSearch.searchInCity(poiCitySearchOption);

        sendReturnResult(ret);
    }

    @Override
    public void onGetPoiResult(PoiResult poiResult) {
        String methodId = getPoiResultMethodId();
        if (TextUtils.isEmpty(methodId)) {
            return;
        }
        if (null == poiResult || null == mMethodChannel) {
            sendSearchResult(methodId, null, -1);
            return;
        }

        PoiResultBean poiResultBean = new PoiResultBean(poiResult);

        String busLineResultJson = mGson.toJson(poiResultBean);
        if (TextUtils.isEmpty(busLineResultJson)) {
            sendSearchResult(methodId, null, -1);
            return;
        }

        try {
            final HashMap<String, Object> resultMap =
                    mGson.fromJson(busLineResultJson, new TypeToken<HashMap<String, Object>>() {
                    }.getType());
            String errorStr = (String) resultMap.get("error");
            if (TextUtils.isEmpty(errorStr)) {
                sendSearchResult(methodId, null, -1);
                return;
            }

            int errorCode = ParseErrorCode.getInstance()
                    .getErrorCode(SearchResult.ERRORNO.valueOf(errorStr));

            sendSearchResult(methodId, resultMap, errorCode);
        } catch (JsonSyntaxException e) {
            Log.e(TAG, e.toString());
        }

    }

    /**
     * @param poiDetailResult
     * @deprecated
     */
    @Override
    public void onGetPoiDetailResult(PoiDetailResult poiDetailResult) {
        if (null == poiDetailResult || null == mMethodChannel) {
            sendSearchResult(MethodID.PoiMethodID.POI_DETAIL_SEARCH, null, -1);
            return;
        }

        PoiDetailResultBean poiDetailResultBean = new PoiDetailResultBean(poiDetailResult);
        PoiDetailSearchResultBean poiDetailSearchResultBean = new PoiDetailSearchResultBean();
        poiDetailSearchResultBean.error = poiDetailResultBean.error;
        poiDetailSearchResultBean.totalPOINum = 1;
        poiDetailSearchResultBean.poiInfoList.add(poiDetailResultBean);

        String resultJson = mGson.toJson(poiDetailSearchResultBean);
        if (TextUtils.isEmpty(resultJson)) {
            sendSearchResult(MethodID.PoiMethodID.POI_INDOOR_SEARCH, null, -1);
            return;
        }

        try {
            final HashMap<String, Object> resultMap =
                    mGson.fromJson(resultJson, new TypeToken<HashMap<String, Object>>() {
                    }.getType());
            String errorStr = (String) resultMap.get("error");
            if (TextUtils.isEmpty(errorStr)) {
                sendSearchResult(MethodID.PoiMethodID.POI_INDOOR_SEARCH, null, -1);
                return;
            }

            final int errorCode = ParseErrorCode.getInstance()
                    .getErrorCode(SearchResult.ERRORNO.valueOf(errorStr));

            sendSearchResult(MethodID.PoiMethodID.POI_DETAIL_SEARCH, resultMap, errorCode);
        } catch (JsonSyntaxException e) {
            Log.e(TAG, e.toString());
        }
    }

    @Override
    public void onGetPoiDetailResult(PoiDetailSearchResult poiDetailSearchResult) {
        Log.d(TAG, "onGetPoiDetailResult");
        if (null == poiDetailSearchResult || null == mMethodChannel) {
            sendSearchResult(MethodID.PoiMethodID.POI_DETAIL_SEARCH, null, -1);
            return;
        }

        PoiDetailSearchResultBean
                poiDetailSearchResultBean = new PoiDetailSearchResultBean(poiDetailSearchResult);

        String resultJson = mGson.toJson(poiDetailSearchResultBean);
        if (TextUtils.isEmpty(resultJson)) {
            sendSearchResult(MethodID.PoiMethodID.POI_INDOOR_SEARCH, null, -1);
            return;
        }

        try {
            final HashMap<String, Object> resultMap =
                    mGson.fromJson(resultJson, new TypeToken<HashMap<String, Object>>() {
                    }.getType());
            String errorStr = (String) resultMap.get("error");
            if (TextUtils.isEmpty(errorStr)) {
                sendSearchResult(MethodID.PoiMethodID.POI_INDOOR_SEARCH, null, -1);
                return;
            }

            final int errorCode = ParseErrorCode.getInstance()
                    .getErrorCode(SearchResult.ERRORNO.valueOf(errorStr));

            sendSearchResult(MethodID.PoiMethodID.POI_DETAIL_SEARCH, resultMap, errorCode);
        } catch (JsonSyntaxException e) {
            Log.e(TAG, e.toString());
        }
    }

    @Override
    public void onGetPoiIndoorResult(PoiIndoorResult poiIndoorResult) {
        if (null == poiIndoorResult || null == mMethodChannel) {
            sendSearchResult(MethodID.PoiMethodID.POI_INDOOR_SEARCH, null, -1);
            return;
        }

        PoiIndoorResultBean poiIndoorResultBean = new PoiIndoorResultBean(poiIndoorResult);

        String busLineResultJson = mGson.toJson(poiIndoorResultBean);
        if (TextUtils.isEmpty(busLineResultJson)) {
            sendSearchResult(MethodID.PoiMethodID.POI_INDOOR_SEARCH, null, -1);
            return;
        }

        try {
            final HashMap<String, Object> resultMap =
                    mGson.fromJson(busLineResultJson, new TypeToken<HashMap<String, Object>>() {
                    }.getType());
            String errorStr = (String) resultMap.get("error");
            if (TextUtils.isEmpty(errorStr)) {
                sendSearchResult(MethodID.PoiMethodID.POI_INDOOR_SEARCH, null, -1);
                return;
            }

            final int errorCode = ParseErrorCode.getInstance()
                    .getErrorCode(SearchResult.ERRORNO.valueOf(errorStr));

            sendSearchResult(MethodID.PoiMethodID.POI_INDOOR_SEARCH, resultMap, errorCode);
        } catch (JsonSyntaxException e) {
            Log.e(TAG, e.toString());
        }
    }

    private String getPoiResultMethodId() {
        String methodId = "";
        switch (mPoiSearchHandleType) {
            case Constants.HandlerType.POI_CITY_SEARCH:
                methodId = MethodID.PoiMethodID.POI_SEARCHIN_CITY;
                break;
            case Constants.HandlerType.POI_BOUNDS_SEARCH:
                methodId = MethodID.PoiMethodID.POI_SEARCH_INBOUNDS;
                break;
            case Constants.HandlerType.POI_NEARBY_SEARCH:
                methodId = MethodID.PoiMethodID.POI_SEARCH_NEARBY;
                break;
            default:
                break;

        }

        return methodId;
    }

}
