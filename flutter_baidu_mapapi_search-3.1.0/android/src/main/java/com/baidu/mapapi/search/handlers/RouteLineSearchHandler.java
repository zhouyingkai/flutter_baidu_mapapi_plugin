package com.baidu.mapapi.search.handlers;

import java.util.HashMap;

import com.baidu.mapapi.search.MethodChannelManager;
import com.baidu.mapapi.search.MethodID;
import com.baidu.mapapi.search.bean.option.route.BikingRoutePlanOptionBean;
import com.baidu.mapapi.search.bean.option.route.DrivingRoutePlanOptionBean;
import com.baidu.mapapi.search.bean.option.route.IndoorRoutePlanOptionBean;
import com.baidu.mapapi.search.bean.option.route.MassTransitRoutePlanOptionBean;
import com.baidu.mapapi.search.bean.option.route.TransitRoutePlanOptionBean;
import com.baidu.mapapi.search.bean.option.route.WalkingRoutePlanOptonBean;
import com.baidu.mapapi.search.bean.result.route.drivingroute.BMFDrivingRouteResultBean;
import com.baidu.mapapi.search.bean.result.route.indoorroute.BMFIndoorRouteResult;
import com.baidu.mapapi.search.bean.result.route.masstransirouteresult.BMFMassTransitRouteResult;
import com.baidu.mapapi.search.bean.result.route.ridingrouteresult.BMFRidingRouteResultBean;
import com.baidu.mapapi.search.bean.result.route.transirouteresult.BMFTransitRouteResult;
import com.baidu.mapapi.search.bean.result.route.walkingrouteresult.WalkingRouteReusltBean;
import com.baidu.mapapi.search.core.SearchResult;
import com.baidu.mapapi.search.route.BikingRoutePlanOption;
import com.baidu.mapapi.search.route.BikingRouteResult;
import com.baidu.mapapi.search.route.DrivingRoutePlanOption;
import com.baidu.mapapi.search.route.DrivingRouteResult;
import com.baidu.mapapi.search.route.IndoorRoutePlanOption;
import com.baidu.mapapi.search.route.IndoorRouteResult;
import com.baidu.mapapi.search.route.MassTransitRoutePlanOption;
import com.baidu.mapapi.search.route.MassTransitRouteResult;
import com.baidu.mapapi.search.route.OnGetRoutePlanResultListener;
import com.baidu.mapapi.search.route.RoutePlanSearch;
import com.baidu.mapapi.search.route.TransitRoutePlanOption;
import com.baidu.mapapi.search.route.TransitRouteResult;
import com.baidu.mapapi.search.route.WalkingRoutePlanOption;
import com.baidu.mapapi.search.route.WalkingRouteResult;
import com.baidu.mapapi.search.utils.GsonFactory;
import com.baidu.mapapi.search.utils.ParseErrorCode;
import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import com.google.gson.reflect.TypeToken;

import android.text.TextUtils;
import android.util.Log;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * 路径规划handler
 */
public class RouteLineSearchHandler extends MethodChannelHandler implements
        OnGetRoutePlanResultListener {

    private static final String TAG = RouteLineSearchHandler.class.getSimpleName();

    private RoutePlanSearch mRouteSearch = null;    // 搜索模块，也可去掉地图模块独立使用
    
    private Gson mGson = null;

    public RouteLineSearchHandler() {
        mRouteSearch = RoutePlanSearch.newInstance();
        mRouteSearch.setOnGetRoutePlanResultListener(this);
        mGson = GsonFactory.getInstance().getGson();
        mMethodChannel = MethodChannelManager.getInstance().getSearchChannel();
    }

    @Override
    public void handleMethodCallResult(MethodCall call, MethodChannel.Result result) {
        super.handleMethodCallResult(call, result);
        if (null == mGson || null == mRouteSearch) {
            sendReturnResult(false);
            return;
        }

        HashMap<String, Object> argumentsMap = (HashMap<String, Object>) call.arguments;
        if (null == argumentsMap) {
            sendReturnResult(false);
            return;
        }

        String methodId = call.method;
        switch (methodId) {
            case MethodID.RouteMethodID.sDrivingSearch:
                handleDrivingSearch(argumentsMap);
                break;
            case MethodID.RouteMethodID.sIndoorRoutePlanSearch:
                handleIndoorSearch(argumentsMap);
                break;
            case MethodID.RouteMethodID.sMassTransitSearch:
                handleMassTransitSearch(argumentsMap);
                break;
            case MethodID.RouteMethodID.sRidingSearch:
                handleRidingSearch(argumentsMap);
                break;
            case MethodID.RouteMethodID.sTransitSearch:
                handleTransitSearch(argumentsMap);
                break;
            case MethodID.RouteMethodID.sWalkingSearch:
                handleWalkingSearch(argumentsMap);
                break;
            default:
                break;
        }
    }

    @Override
    public void destroy() {
        if (null != mRouteSearch) {
            mRouteSearch.destroy();
        }
    }

    @Override
    public void sendSearchResult(Object value, int errorCode) {

    }

    private void handleDrivingSearch(HashMap<String, Object> argumentsMap) {

        HashMap<String, Object> optionMap = (HashMap<String, Object>) argumentsMap.get(
                "drivingRoutePlanOption");
        if (null == optionMap) {
            sendReturnResult(false);
            return;
        }

        String jsonStr = mGson.toJson(optionMap);
        if (null == jsonStr) {
            sendReturnResult(false);
            return;
        }

        DrivingRoutePlanOptionBean
                optionBean = mGson.fromJson(jsonStr, DrivingRoutePlanOptionBean.class);
        if (null == optionBean) {
            sendReturnResult(false);
            return;
        }

        DrivingRoutePlanOption option = optionBean.toOption();

        boolean ret = false;
        try {
            ret = mRouteSearch.drivingSearch(option);
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
        } catch (IllegalStateException e) {
            e.printStackTrace();
        }

        sendReturnResult(ret);
    }

    private void handleIndoorSearch(HashMap<String, Object> argumentsMap) {
        HashMap<String, Object> optionMap = (HashMap<String, Object>) argumentsMap.get(
                "indoorRoutePlanOption");
        if (null == optionMap) {
            sendReturnResult(false);
            return;
        }

        String jsonStr = mGson.toJson(optionMap);
        if (null == jsonStr) {
            sendReturnResult(false);
            return;
        }

        IndoorRoutePlanOptionBean optionBean =
                mGson.fromJson(jsonStr, IndoorRoutePlanOptionBean.class);
        if (null == optionBean) {
            sendReturnResult(false);
            return;
        }

        IndoorRoutePlanOption option = optionBean.toOption();

        boolean ret = false;
        try {
            ret = mRouteSearch.walkingIndoorSearch(option);
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
        } catch (IllegalStateException e) {
            e.printStackTrace();
        }


        sendReturnResult(ret);
    }

    private void handleMassTransitSearch(HashMap<String, Object> argumentsMap) {
        HashMap<String, Object> optionMap = (HashMap<String, Object>) argumentsMap.get(
                "massTransitRoutePlanOption");
        if (null == optionMap) {
            sendReturnResult(false);
            return;
        }

        String jsonStr = mGson.toJson(optionMap);
        if (null == jsonStr) {
            sendReturnResult(false);
            return;
        }

        MassTransitRoutePlanOptionBean optionBean = mGson.fromJson(jsonStr,
                MassTransitRoutePlanOptionBean.class);
        if (null == optionBean) {
            sendReturnResult(false);
            return;
        }

        MassTransitRoutePlanOption option = optionBean.toOption();

        boolean ret = false;
        try {
            ret = mRouteSearch.masstransitSearch(option);
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
        } catch (IllegalStateException e) {
            e.printStackTrace();
        }

        sendReturnResult(ret);
    }

    private void handleTransitSearch(HashMap<String, Object> argumentsMap) {
        HashMap<String, Object> optionMap = (HashMap<String, Object>) argumentsMap.get(
                "transitRoutePlanOption");
        if (null == optionMap) {
            sendReturnResult(false);
            return;
        }

        String jsonStr = mGson.toJson(optionMap);
        if (null == jsonStr) {
            sendReturnResult(false);
            return;
        }

        TransitRoutePlanOptionBean optionBean = mGson.fromJson(jsonStr,
                TransitRoutePlanOptionBean.class);
        if (null == optionBean) {
            sendReturnResult(false);
            return;
        }

        TransitRoutePlanOption option = optionBean.toOption();

        boolean ret = false;
        try {
            ret = mRouteSearch.transitSearch(option);
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
        } catch (IllegalStateException e) {
            e.printStackTrace();
        }

        sendReturnResult(ret);
    }

    private void handleRidingSearch(HashMap<String, Object> argumentsMap) {
        HashMap<String, Object> optionMap = (HashMap<String, Object>) argumentsMap.get(
                "ridingRoutePlanOption");
        if (null == optionMap) {
            sendReturnResult(false);
            return;
        }

        String jsonStr = mGson.toJson(optionMap);
        if (null == jsonStr) {
            sendReturnResult(false);
            return;
        }

        BikingRoutePlanOptionBean optionBean = mGson.fromJson(jsonStr,
                BikingRoutePlanOptionBean.class);
        if (null == optionBean) {
            sendReturnResult(false);
            return;
        }

        BikingRoutePlanOption option = optionBean.toOption();

        boolean ret = false;
        try {
            ret = mRouteSearch.bikingSearch(option);
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
        } catch (IllegalStateException e) {
            e.printStackTrace();
        }

        sendReturnResult(ret);
    }

    private void handleWalkingSearch(HashMap<String, Object> argumentsMap) {
        HashMap<String, Object> optionMap = (HashMap<String, Object>) argumentsMap.get(
                "walkingRoutePlanOption");
        if (null == optionMap) {
            sendReturnResult(false);
            return;
        }

        String jsonStr = mGson.toJson(optionMap);
        if (null == jsonStr) {
            sendReturnResult(false);
            return;
        }

        WalkingRoutePlanOptonBean optionBean = mGson.fromJson(jsonStr,
                WalkingRoutePlanOptonBean.class);
        if (null == optionBean) {
            sendReturnResult(false);
            return;
        }

        WalkingRoutePlanOption option = optionBean.toOption();

        if (null == option || null == option.mFrom || null == option.mTo) {
            sendReturnResult(false);
            return;
        }

        if (TextUtils.isEmpty(option.mFrom.getName()) && null == option.mFrom.getLocation()
                || TextUtils.isEmpty(option.mTo.getName()) && null == option.mTo.getLocation()) {
            sendReturnResult(false);
            return;
        }

        boolean ret = false;
        try {
            ret = mRouteSearch.walkingSearch(option);
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
        } catch (IllegalStateException e) {
            e.printStackTrace();
        }

        sendReturnResult(ret);
    }

    @Override
    public void onGetWalkingRouteResult(WalkingRouteResult walkingRouteResult) {
        if (null == walkingRouteResult || null == mMethodChannel) {
            sendSearchResult(MethodID.RouteMethodID.sWalkingSearch, null, -1);
            return;
        }

        WalkingRouteReusltBean walkingRouteReusltBean =
                new WalkingRouteReusltBean(walkingRouteResult);

        String resultJson = mGson.toJson(walkingRouteReusltBean);
        if (TextUtils.isEmpty(resultJson)) {
            sendSearchResult(MethodID.RouteMethodID.sWalkingSearch, null, -1);
            return;
        }

        try {
            final HashMap<String, Object> resultMap =
                    mGson.fromJson(resultJson, new TypeToken<HashMap<String, Object>>() {
                    }.getType());
            String errorStr = (String) resultMap.get("error");
            if (TextUtils.isEmpty(errorStr)) {
                sendSearchResult(MethodID.RouteMethodID.sWalkingSearch, null, -1);
                return;
            }

            int errorCode = ParseErrorCode.getInstance()
                    .getErrorCode(SearchResult.ERRORNO.valueOf(errorStr));

            sendSearchResult(MethodID.RouteMethodID.sWalkingSearch, resultMap, errorCode);
        } catch (JsonSyntaxException e) {
            Log.e(TAG, e.toString());
        }
    }

    @Override
    public void onGetTransitRouteResult(TransitRouteResult transitRouteResult) {
        if (null == transitRouteResult || null == mMethodChannel) {
            sendSearchResult(MethodID.RouteMethodID.sTransitSearch, null, -1);
            return;
        }

        BMFTransitRouteResult bmfTransitRouteResult =
                new BMFTransitRouteResult(transitRouteResult);

        String resultJson = mGson.toJson(bmfTransitRouteResult);
        if (TextUtils.isEmpty(resultJson)) {
            sendSearchResult(MethodID.RouteMethodID.sTransitSearch, null, -1);
            return;
        }

        try {
            final HashMap<String, Object> resultMap =
                    mGson.fromJson(resultJson, new TypeToken<HashMap<String, Object>>() {
                    }.getType());
            String errorStr = (String) resultMap.get("error");
            if (TextUtils.isEmpty(errorStr)) {
                sendSearchResult(MethodID.RouteMethodID.sTransitSearch, null, -1);
                return;
            }

            int errorCode = ParseErrorCode.getInstance()
                    .getErrorCode(SearchResult.ERRORNO.valueOf(errorStr));

            sendSearchResult(MethodID.RouteMethodID.sTransitSearch, resultMap, errorCode);
        } catch (JsonSyntaxException e) {
            Log.e(TAG, e.toString());
        }
    }

    @Override
    public void onGetMassTransitRouteResult(MassTransitRouteResult massTransitRouteResult) {
        if (null == massTransitRouteResult || null == mMethodChannel) {
            sendSearchResult(MethodID.RouteMethodID.sMassTransitSearch, null, -1);
            return;
        }

        BMFMassTransitRouteResult bmfMassTransitRouteResult =
                new BMFMassTransitRouteResult(massTransitRouteResult);

        String resultJson = mGson.toJson(bmfMassTransitRouteResult);
        if (TextUtils.isEmpty(resultJson)) {
            sendSearchResult(MethodID.RouteMethodID.sMassTransitSearch, null, -1);
            return;
        }

        try {
            final HashMap<String, Object> resultMap =
                    mGson.fromJson(resultJson, new TypeToken<HashMap<String, Object>>() {
                    }.getType());
            String errorStr = (String) resultMap.get("error");
            if (TextUtils.isEmpty(errorStr)) {
                sendSearchResult(MethodID.RouteMethodID.sMassTransitSearch, null, -1);
                return;
            }

            int errorCode = ParseErrorCode.getInstance()
                    .getErrorCode(SearchResult.ERRORNO.valueOf(errorStr));

            sendSearchResult(MethodID.RouteMethodID.sMassTransitSearch, resultMap, errorCode);
        } catch (JsonSyntaxException e) {
            Log.e(TAG, e.toString());
        }
    }

    @Override
    public void onGetDrivingRouteResult(DrivingRouteResult drivingRouteResult) {
        if (null == drivingRouteResult || null == mMethodChannel) {
            sendSearchResult(MethodID.RouteMethodID.sDrivingSearch, null, -1);
            return;
        }

        BMFDrivingRouteResultBean bmfDrivingRouteResultBean =
                new BMFDrivingRouteResultBean(drivingRouteResult);

        String resultJson = mGson.toJson(bmfDrivingRouteResultBean);
        if (TextUtils.isEmpty(resultJson)) {
            sendSearchResult(MethodID.RouteMethodID.sDrivingSearch, null, -1);
            return;
        }

        try {
            final HashMap<String, Object> resultMap =
                    mGson.fromJson(resultJson, new TypeToken<HashMap<String, Object>>() {
                    }.getType());
            String errorStr = (String) resultMap.get("error");
            if (TextUtils.isEmpty(errorStr)) {
                sendSearchResult(MethodID.RouteMethodID.sDrivingSearch, null, -1);
                return;
            }

            int errorCode = ParseErrorCode.getInstance()
                    .getErrorCode(SearchResult.ERRORNO.valueOf(errorStr));

            sendSearchResult(MethodID.RouteMethodID.sDrivingSearch, resultMap, errorCode);
        } catch (JsonSyntaxException e) {
            Log.e(TAG, e.toString());
        }
    }

    @Override
    public void onGetIndoorRouteResult(IndoorRouteResult indoorRouteResult) {
        if (null == indoorRouteResult || null == mMethodChannel) {
            sendSearchResult(MethodID.RouteMethodID.sIndoorRoutePlanSearch, null, -1);
            return;
        }

        BMFIndoorRouteResult bmfIndoorRouteResult =
                new BMFIndoorRouteResult(indoorRouteResult);

        String resultJson = mGson.toJson(bmfIndoorRouteResult);
        if (TextUtils.isEmpty(resultJson)) {
            sendSearchResult(MethodID.RouteMethodID.sIndoorRoutePlanSearch, null, -1);
            return;
        }

        try {
            final HashMap<String, Object> resultMap =
                    mGson.fromJson(resultJson, new TypeToken<HashMap<String, Object>>() {
                    }.getType());
            String errorStr = (String) resultMap.get("error");
            if (TextUtils.isEmpty(errorStr)) {
                sendSearchResult(MethodID.RouteMethodID.sIndoorRoutePlanSearch, null, -1);
                return;
            }

            int errorCode = ParseErrorCode.getInstance()
                    .getErrorCode(SearchResult.ERRORNO.valueOf(errorStr));

            sendSearchResult(MethodID.RouteMethodID.sIndoorRoutePlanSearch, resultMap, errorCode);
        } catch (JsonSyntaxException e) {
            Log.e(TAG, e.toString());
        }
    }

    @Override
    public void onGetBikingRouteResult(BikingRouteResult bikingRouteResult) {
        if (null == bikingRouteResult || null == mMethodChannel) {
            sendSearchResult(MethodID.RouteMethodID.sRidingSearch, null, -1);
            return;
        }

        BMFRidingRouteResultBean bmfRidingRouteResultBean =
                new BMFRidingRouteResultBean(bikingRouteResult);

        String resultJson = mGson.toJson(bmfRidingRouteResultBean);
        if (TextUtils.isEmpty(resultJson)) {
            sendSearchResult(MethodID.RouteMethodID.sRidingSearch, null, -1);
            return;
        }

        try {
            final HashMap<String, Object> resultMap =
                    mGson.fromJson(resultJson, new TypeToken<HashMap<String, Object>>() {
                    }.getType());
            String errorStr = (String) resultMap.get("error");
            if (TextUtils.isEmpty(errorStr)) {
                sendSearchResult(MethodID.RouteMethodID.sRidingSearch, null, -1);
                return;
            }

            final int errorCode = ParseErrorCode.getInstance()
                    .getErrorCode(SearchResult.ERRORNO.valueOf(errorStr));

            sendSearchResult(MethodID.RouteMethodID.sRidingSearch, resultMap, errorCode);
        } catch (JsonSyntaxException e) {
            Log.e(TAG, e.toString());
        }
    }
}
