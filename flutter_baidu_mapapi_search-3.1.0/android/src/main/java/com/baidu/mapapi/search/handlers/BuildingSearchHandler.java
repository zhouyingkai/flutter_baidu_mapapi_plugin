package com.baidu.mapapi.search.handlers;

import android.text.TextUtils;
import android.util.Log;

import com.baidu.mapapi.search.Constants;
import com.baidu.mapapi.search.MethodChannelManager;
import com.baidu.mapapi.search.MethodID;
import com.baidu.mapapi.search.bean.option.BuildingOptionBean;
import com.baidu.mapapi.search.bean.result.building.BuildingResultBean;
import com.baidu.mapapi.search.building.BuildingResult;
import com.baidu.mapapi.search.building.BuildingSearch;
import com.baidu.mapapi.search.building.BuildingSearchOption;
import com.baidu.mapapi.search.building.OnGetBuildingSearchResultListener;
import com.baidu.mapapi.search.core.SearchResult;
import com.baidu.mapapi.search.utils.GsonFactory;
import com.baidu.mapapi.search.utils.ParseErrorCode;
import com.google.gson.JsonSyntaxException;
import com.google.gson.reflect.TypeToken;

import java.util.HashMap;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class BuildingSearchHandler extends MethodChannelHandler
            implements OnGetBuildingSearchResultListener {

    private static final String TAG = BuildingSearchHandler.class.getSimpleName();

    private BuildingSearch mBuildingSearch;

    public BuildingSearchHandler() {
        mBuildingSearch = BuildingSearch.newInstance();
        mGson = GsonFactory.getInstance().getGson();
        mMethodChannel = MethodChannelManager.getInstance().getSearchChannel();
    }

    @Override
    public void handleMethodCallResult(MethodCall call, MethodChannel.Result result) {
        super.handleMethodCallResult(call, result);
        if (null == mGson || null == mBuildingSearch) {
            sendReturnResult(false);
            return;
        }

        HashMap<String, Object> argumentsMap = (HashMap<String, Object>) call.arguments;
        if (null == argumentsMap) {
            sendReturnResult(false);
            return;
        }

        HashMap<String, Object> buslineOptionMap =
                (HashMap<String, Object>) argumentsMap.get("buildingSearchOption");
        if (null == buslineOptionMap) {
            sendReturnResult(false);
            return;
        }

        String jsonStr = mGson.toJson(buslineOptionMap);
        if (null == jsonStr) {
            sendReturnResult(false);
            return;
        }

        BuildingOptionBean buildingOptionBean = mGson.fromJson(jsonStr, BuildingOptionBean.class);
        if (null == buildingOptionBean) {
            sendReturnResult(false);
            return;
        }

        if (buildingOptionBean.location == null) {
            sendReturnResult(false);
            return;
        }

        BuildingSearchOption buildingSearchOption = new BuildingSearchOption();
        buildingSearchOption.setLatLng(buildingOptionBean.location);

        mBuildingSearch.setOnGetBuildingSearchResultListener(this);
        boolean ret = mBuildingSearch.requestBuilding(buildingSearchOption);

        sendReturnResult(ret);
    }

    @Override
    public void onGetBuildingResult(BuildingResult buildingResult) {
        if (null == buildingResult) {
            sendSearchResult(null, -1);
            return;
        }

        BuildingResultBean buildingResultBean = new BuildingResultBean(buildingResult);

        String buildingResultJson = mGson.toJson(buildingResultBean);
        if (TextUtils.isEmpty(buildingResultJson)) {
            sendSearchResult(null, -1);
            return;
        }

        try {
            final HashMap<String, Object> resultMap =
                    mGson.fromJson(buildingResultJson, new TypeToken<HashMap<String, Object>>() {
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

    @Override
    public void destroy() {
        if (null != mBuildingSearch) {
            mBuildingSearch.destroy();
        }
    }

    @Override
    public void sendSearchResult(final Object value, final int errorCode) {
        if (null == mMethodChannel) {
            return;
        }

        mMethodChannel
                .invokeMethod(MethodID.BuildingSearchMethodID.BUILDING_SEARCH, new HashMap<String,
                        Object>() {
                    {
                        put(Constants.RESULT_KEY, value);
                        put(Constants.ERROR_KEY, errorCode);
                    }
                });


    }
}
