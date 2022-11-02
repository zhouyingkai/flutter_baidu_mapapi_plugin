package com.baidu.mapapi.search.handlers;

import android.text.TextUtils;
import android.util.Log;

import com.baidu.mapapi.search.Constants;
import com.baidu.mapapi.search.MethodChannelManager;
import com.baidu.mapapi.search.MethodID;
import com.baidu.mapapi.search.bean.option.WeatherOptionBean;
import com.baidu.mapapi.search.bean.result.weather.WeatherResultBean;
import com.baidu.mapapi.search.core.SearchResult;
import com.baidu.mapapi.search.utils.GsonFactory;
import com.baidu.mapapi.search.utils.ParseErrorCode;
import com.baidu.mapapi.search.weather.OnGetWeatherResultListener;
import com.baidu.mapapi.search.weather.WeatherDataType;
import com.baidu.mapapi.search.weather.WeatherResult;
import com.baidu.mapapi.search.weather.WeatherSearch;
import com.baidu.mapapi.search.weather.WeatherSearchOption;
import com.baidu.mapapi.search.weather.WeatherServerType;
import com.google.gson.JsonSyntaxException;
import com.google.gson.reflect.TypeToken;

import java.util.HashMap;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class WeatherSearchHandler extends MethodChannelHandler implements OnGetWeatherResultListener {

    private static final String TAG = RecommendStopHandler.class.getSimpleName();

    private WeatherSearch mWeatherSearch;

    public WeatherSearchHandler() {
        mWeatherSearch = WeatherSearch.newInstance();
        mWeatherSearch.setWeatherSearchResultListener(this);
        mGson = GsonFactory.getInstance().getGson();
        mMethodChannel = MethodChannelManager.getInstance().getSearchChannel();
    }

    @Override
    public void handleMethodCallResult(MethodCall call, MethodChannel.Result result) {
        super.handleMethodCallResult(call, result);
        if (null == mGson || null == mWeatherSearch) {
            sendReturnResult(false);
            return;
        }

        HashMap<String, Object> argumentsMap = (HashMap<String, Object>) call.arguments;
        if (null == argumentsMap) {
            sendReturnResult(false);
            return;
        }

        HashMap<String, Object> weatherSearchMap =
                (HashMap<String, Object>) argumentsMap.get("weatherSearchOption");
        if (null == weatherSearchMap) {
            sendReturnResult(false);
            return;
        }

        String jsonStr = mGson.toJson(weatherSearchMap);
        if (null == jsonStr) {
            sendReturnResult(false);
            return;
        }

        WeatherOptionBean weatherOptionBean = mGson.fromJson(jsonStr, WeatherOptionBean.class);
        if (null == weatherOptionBean) {
            sendReturnResult(false);
            return;
        }

        // int转换为枚举
        WeatherSearchOption weatherOption = new WeatherSearchOption();
        WeatherDataType dataType = WeatherDataType.values()[weatherOptionBean.dataType];
        weatherOption.weatherDataType(dataType);
//        LanguageType languageType = LanguageType.values()[weatherOptionBean.languageType];
//        weatherOption.languageType(languageType);
        WeatherServerType weatherServerType = WeatherServerType.values()[weatherOptionBean.serverType];
        weatherOption.serverType(weatherServerType);

        if (!TextUtils.isEmpty(weatherOptionBean.districtID)) {
            weatherOption.districtID(weatherOptionBean.districtID.trim());
        }
        if (weatherOptionBean.location != null) {
            weatherOption.location(weatherOptionBean.location);
        }

        boolean ret = mWeatherSearch.request(weatherOption);

        sendReturnResult(ret);
    }

    @Override
    public void destroy() {
        if (mWeatherSearch != null) {
            mWeatherSearch.destroy();
        }
    }

    @Override
    public void sendSearchResult(final Object value, final int errorCode) {
        if (null == mMethodChannel) {
            return;
        }

        mMethodChannel.invokeMethod(MethodID.BMFWeatherSearchMethodID.WEATHER_SEARCH, new HashMap<String,
                Object>() {
            {
                put(Constants.RESULT_KEY, value);
                put(Constants.ERROR_KEY, errorCode);
            }
        });
    }

    @Override
    public void onGetWeatherResultListener(WeatherResult weatherResult) {
        if (null == mMethodChannel) {
            return;
        }

        if (null == weatherResult) {
            sendSearchResult(null, -1);
            return;
        }

        WeatherResultBean weatherResultBean = new WeatherResultBean(weatherResult);
        String weatherResultJson = mGson.toJson(weatherResultBean);
        if (TextUtils.isEmpty(weatherResultJson)) {
            sendSearchResult(null, -1);
            return;
        }

        try {
            final HashMap<String, Object> resultMap = mGson.fromJson(weatherResultJson,
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
