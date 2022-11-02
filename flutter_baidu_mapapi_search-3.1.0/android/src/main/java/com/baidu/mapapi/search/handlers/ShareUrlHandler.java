package com.baidu.mapapi.search.handlers;

import android.text.TextUtils;
import android.util.Log;

import com.baidu.mapapi.search.Constants;
import com.baidu.mapapi.search.MethodChannelManager;
import com.baidu.mapapi.search.MethodID;
import com.baidu.mapapi.search.bean.option.LocationShareUrlOptionBean;
import com.baidu.mapapi.search.bean.option.PoiDetailShareUrlOptionBean;
import com.baidu.mapapi.search.bean.option.RoutePlanShareUrlOptionBean;
import com.baidu.mapapi.search.bean.result.ShareUrlResultBean;
import com.baidu.mapapi.search.core.SearchResult;
import com.baidu.mapapi.search.route.PlanNode;
import com.baidu.mapapi.search.share.LocationShareURLOption;
import com.baidu.mapapi.search.share.OnGetShareUrlResultListener;
import com.baidu.mapapi.search.share.PoiDetailShareURLOption;
import com.baidu.mapapi.search.share.RouteShareURLOption;
import com.baidu.mapapi.search.share.ShareUrlResult;
import com.baidu.mapapi.search.share.ShareUrlSearch;
import com.baidu.mapapi.search.utils.GsonFactory;
import com.baidu.mapapi.search.utils.ParseErrorCode;
import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import com.google.gson.reflect.TypeToken;

import java.util.HashMap;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * 短串分享handler
 */
public class ShareUrlHandler extends MethodChannelHandler implements OnGetShareUrlResultListener {

    public static final String TAG = ShareUrlHandler.class.getSimpleName();

    private ShareUrlSearch mShareUrlSearch;

    private Gson mGson;

    MethodChannel mMethodChannel;

    public ShareUrlHandler() {
        mShareUrlSearch = ShareUrlSearch.newInstance();
        mShareUrlSearch.setOnGetShareUrlResultListener(this);
        mGson = GsonFactory.getInstance().getGson();
        mMethodChannel = MethodChannelManager.getInstance().getSearchChannel();
    }

    @Override
    public void handleMethodCallResult(MethodCall call, MethodChannel.Result result) {
        super.handleMethodCallResult(call, result);
        if (null == mShareUrlSearch) {
            return;
        }

        if (null == mGson) {
            return;
        }

        String methodId = call.method;
        switch (methodId) {
            case MethodID.ShareUrlMethodID.REQUEST_POIDETAIL_SHARE_URL:
                handlePoiDetailShareCallResult(call, result);
                break;
            case MethodID.ShareUrlMethodID.REQUEST_ROUTEPLAN_SHARE_URL:
                handleRoutePlanShareCallResult(call, result);
                break;
            case MethodID.ShareUrlMethodID.REQUEST_LOCATION_SHARE_URL:
                handleLocationShareCallResult(call, result);
                break;
            default:
                break;
        }

    }

    @Override
    public void destroy() {
        if (null != mShareUrlSearch) {
            mShareUrlSearch.destroy();
        }
    }

    @Override
    public void sendSearchResult(final Object value, final int errorCode) {
        return;
    }

    public void sendSearchResult(final Object value, final int errorCode, String methodId) {
        if (null == mMethodChannel) {
            return;
        }

        mMethodChannel.invokeMethod(methodId, new HashMap<String, Object>() {
            {
                put(Constants.RESULT_KEY, value);
                put(Constants.ERROR_KEY, errorCode);
            }
        });
    }

    private void handlePoiDetailShareCallResult(MethodCall call, MethodChannel.Result result) {
        HashMap<String, Object> argumentsMap = (HashMap<String, Object>) call.arguments;
        if (null == argumentsMap) {
            sendReturnResult(false);
            return;
        }

        HashMap<String, Object> shareOptionMap = (HashMap<String, Object>) argumentsMap.get("poiDetailShareURLOption");
        if (null == shareOptionMap) {
            sendReturnResult(false);
            return;
        }

        String jsonStr = mGson.toJson(shareOptionMap);
        if (null == jsonStr) {
            sendReturnResult(false);
            return;
        }

        PoiDetailShareUrlOptionBean poiDetailShareUrlOptionBean = mGson
                .fromJson(jsonStr, PoiDetailShareUrlOptionBean.class);
        if (null == poiDetailShareUrlOptionBean) {
            sendReturnResult(false);
            return;
        }

        if (TextUtils.isEmpty(poiDetailShareUrlOptionBean.uid)) {
            sendReturnResult(false);
            return;
        }


        PoiDetailShareURLOption poiDetailShareURLOption = new PoiDetailShareURLOption();
        poiDetailShareURLOption.mUid = poiDetailShareUrlOptionBean.uid.trim();

        boolean ret = mShareUrlSearch.requestPoiDetailShareUrl(poiDetailShareURLOption);

        sendReturnResult(ret);
    }

    private void handleRoutePlanShareCallResult(MethodCall call, MethodChannel.Result result) {
        HashMap<String, Object> argumentsMap = (HashMap<String, Object>) call.arguments;
        if (null == argumentsMap) {
            sendReturnResult(false);
            return;
        }

        HashMap<String, Object> shareOptionMap = (HashMap<String, Object>) argumentsMap.get("routePlanShareURLOption");
        if (null == shareOptionMap) {
            sendReturnResult(false);
            return;
        }

        String jsonStr = mGson.toJson(shareOptionMap);
        if (null == jsonStr) {
            sendReturnResult(false);
            return;
        }

        RoutePlanShareUrlOptionBean routePlanShareUrlOptionBean = mGson
                .fromJson(jsonStr, RoutePlanShareUrlOptionBean.class);
        if (null == routePlanShareUrlOptionBean) {
            sendReturnResult(false);
            return;
        }

        if (null == routePlanShareUrlOptionBean.from) {
            sendReturnResult(false);
            return;
        }

        if (null == routePlanShareUrlOptionBean.to) {
            sendReturnResult(false);
            return;
        }

        if (routePlanShareUrlOptionBean.routePlanType < 0
                || routePlanShareUrlOptionBean.routePlanType > RouteShareURLOption.RouteShareMode.values().length) {
            sendReturnResult(false);
            return;
        }

        PlanNode from = null;
        PlanNode to = null;
        RouteShareURLOption routeShareURLOption = new RouteShareURLOption();
        routeShareURLOption.mCityCode = routePlanShareUrlOptionBean.cityID;

        if (null != routePlanShareUrlOptionBean.from.pt && null != routePlanShareUrlOptionBean.to.pt) {
            from = PlanNode.withLocation(routePlanShareUrlOptionBean.from.pt);
            to = PlanNode.withLocation(routePlanShareUrlOptionBean.to.pt);
        } else if (!TextUtils.isEmpty(routePlanShareUrlOptionBean.from.cityName)
                && !TextUtils.isEmpty(routePlanShareUrlOptionBean.from.name)
                && !TextUtils.isEmpty(routePlanShareUrlOptionBean.to.cityName)
                && !TextUtils.isEmpty(routePlanShareUrlOptionBean.to.name)) {
            from = PlanNode.withCityNameAndPlaceName(routePlanShareUrlOptionBean.from.cityName
                    , routePlanShareUrlOptionBean.from.name);
            to = PlanNode.withCityNameAndPlaceName(routePlanShareUrlOptionBean.to.cityName
                    , routePlanShareUrlOptionBean.to.name);
        } else if (routePlanShareUrlOptionBean.cityID >= 0
                && !TextUtils.isEmpty(routePlanShareUrlOptionBean.from.name)
                && !TextUtils.isEmpty(routePlanShareUrlOptionBean.to.name)) {
            from = PlanNode.withCityCodeAndPlaceName(routePlanShareUrlOptionBean.cityID, routePlanShareUrlOptionBean.from.name);
            to = PlanNode.withCityCodeAndPlaceName(routePlanShareUrlOptionBean.cityID, routePlanShareUrlOptionBean.to.name);
        }

        if (null == from || null == to) {
            sendReturnResult(false);
            return;
        }

        routeShareURLOption.from(from).to(to);
        routeShareURLOption.mCityCode = routePlanShareUrlOptionBean.cityID;
        routeShareURLOption.mPn = routePlanShareUrlOptionBean.routeIndex;
        routeShareURLOption.mMode = RouteShareURLOption.RouteShareMode.values()[routePlanShareUrlOptionBean.routePlanType];

        boolean ret = mShareUrlSearch.requestRouteShareUrl(routeShareURLOption);

        sendReturnResult(ret);
    }

    private void handleLocationShareCallResult(MethodCall call, MethodChannel.Result result) {
        HashMap<String, Object> argumentsMap = (HashMap<String, Object>) call.arguments;
        if (null == argumentsMap) {
            sendReturnResult(false);
            return;
        }

        HashMap<String, Object> shareOptionMap = (HashMap<String, Object>) argumentsMap.get("reverseGeoShareURLOption");
        if (null == shareOptionMap) {
            sendReturnResult(false);
            return;
        }

        String jsonStr = mGson.toJson(shareOptionMap);
        if (null == jsonStr) {
            sendReturnResult(false);
            return;
        }

        LocationShareUrlOptionBean locationShareUrlOptionBean = mGson
                .fromJson(jsonStr, LocationShareUrlOptionBean.class);
        if (null == locationShareUrlOptionBean) {
            sendReturnResult(false);
            return;
        }

        if (TextUtils.isEmpty(locationShareUrlOptionBean.name)) {
            sendReturnResult(false);
            return;
        }

        if (TextUtils.isEmpty(locationShareUrlOptionBean.snippet)) {
            sendReturnResult(false);
            return;
        }

        if (null == locationShareUrlOptionBean.location) {
            sendReturnResult(false);
            return;
        }

        LocationShareURLOption locationShareURLOption = new LocationShareURLOption();
        locationShareURLOption.mLocation = locationShareUrlOptionBean.location;
        locationShareURLOption.mName = locationShareUrlOptionBean.name;
        locationShareURLOption.mSnippet = locationShareUrlOptionBean.snippet;


        boolean ret = mShareUrlSearch.requestLocationShareUrl(locationShareURLOption);

        sendReturnResult(ret);
    }

    @Override
    public void onGetPoiDetailShareUrlResult(ShareUrlResult shareUrlResult) {
        this.onGetResultImp(shareUrlResult, MethodID.ShareUrlMethodID.REQUEST_POIDETAIL_SHARE_URL);
    }

    @Override
    public void onGetLocationShareUrlResult(ShareUrlResult shareUrlResult) {
        this.onGetResultImp(shareUrlResult, MethodID.ShareUrlMethodID.REQUEST_LOCATION_SHARE_URL);
    }

    @Override
    public void onGetRouteShareUrlResult(ShareUrlResult shareUrlResult) {
        this.onGetResultImp(shareUrlResult, MethodID.ShareUrlMethodID.REQUEST_ROUTEPLAN_SHARE_URL);
    }

    private void onGetResultImp(ShareUrlResult shareUrlResult, String methodId) {
        if (null == mMethodChannel) {
            return;
        }

        if (null == shareUrlResult) {
            sendSearchResult(null, -1, methodId);
            return;
        }

        ShareUrlResultBean poiDetailShareUrlResultBean = new ShareUrlResultBean(shareUrlResult);

        String busLineResultJson = mGson.toJson(poiDetailShareUrlResultBean);
        if (TextUtils.isEmpty(busLineResultJson)) {
            sendSearchResult(null, -1, methodId);
            return;
        }

        try {
            final HashMap<String, Object> resultMap = mGson.fromJson(busLineResultJson,
                    new TypeToken<HashMap<String, Object>>() {
                    }.getType());
            String errorStr = (String) resultMap.get("error");
            if (TextUtils.isEmpty(errorStr)) {
                sendSearchResult(null, -1, methodId);
                return;
            }

            int errorCode = ParseErrorCode.getInstance().getErrorCode(SearchResult.ERRORNO.valueOf(errorStr));
            sendSearchResult(resultMap, errorCode, methodId);
        } catch (JsonSyntaxException e) {
            Log.e(TAG, e.toString());
        }
    }
}
