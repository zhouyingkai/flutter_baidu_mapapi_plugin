package com.baidu.mapapi.search.handlers;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import com.baidu.mapapi.search.Constants;
import com.baidu.mapapi.search.MethodID;

import android.text.TextUtils;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * method handle 工厂类
 */
public class HandlersFactory {

    public static final String TAG = HandlersFactory.class.getSimpleName();
    private static volatile HandlersFactory sInstance;

    public Map<Integer, MethodChannelHandler> methodHandlerMap = new HashMap<>();

    private HandlersFactory() {
        methodHandlerMap
                .put(Constants.HandlerType.DISTRICT_SEARCH_TYPE, new DistrictSearchHandler());
        methodHandlerMap.put(Constants.HandlerType.GEO_CODER_AND_REVERSE_GEO_CODER_SEARCH_TYPE,
                new GeoCoderHandler());
        methodHandlerMap.put(Constants.HandlerType.BUSLINE_SEARCH_TYPE, new BusLineSearchHandler());
        methodHandlerMap.put(Constants.HandlerType.POI_SEARCH_TYPE, new PoiSearchHandler());
        methodHandlerMap.put(Constants.HandlerType.POI_BOUNDS_SEARCH, new PoiSearchHandler(
                Constants.HandlerType.POI_BOUNDS_SEARCH));
        methodHandlerMap.put(Constants.HandlerType.POI_NEARBY_SEARCH, new PoiSearchHandler(
                Constants.HandlerType.POI_NEARBY_SEARCH));
        methodHandlerMap
                .put(Constants.HandlerType.ROUTE_LINE_SEARCH_TYPE, new RouteLineSearchHandler());
        methodHandlerMap.put(Constants.HandlerType.SHARE_URL_TYPE, new ShareUrlHandler());
        methodHandlerMap
                .put(Constants.HandlerType.SUGGESTION_SEARCH_TYPE, new SuggestionSearchHandler());
        methodHandlerMap.put(Constants.HandlerType.RECOMMEND_STOP_TYPE, new RecommendStopHandler());
        methodHandlerMap.put(Constants.HandlerType.WEATHER_TYPE, new WeatherSearchHandler());
        methodHandlerMap.put(Constants.HandlerType.BUILDING_SEARCH_TYPE, new BuildingSearchHandler());
    }

    public static HandlersFactory getInstance() {

        if (null == sInstance) {
            synchronized (HandlersFactory.class) {
                if (null == sInstance) {
                    sInstance = new HandlersFactory();
                }
            }
        }

        return sInstance;
    }

    public void dispatchMethodHandler(MethodCall call, MethodChannel.Result result) {
        if (null == call || null == result) {
            return;
        }

        MethodChannelHandler methodChannelHandler = null;
        String method = call.method;
        if (TextUtils.isEmpty(method)) {
            return;
        }

        switch (method) {
            case MethodID.BMFRecommendStopSearchMethodID.RECOMMEND_STOP_SEARCH:
                methodChannelHandler =
                        methodHandlerMap.get(Constants.HandlerType.RECOMMEND_STOP_TYPE);
                break;
            case MethodID.BMFDistrictSearchMethodID.DISTRICT_SEARCH:
                methodChannelHandler =
                        methodHandlerMap.get(Constants.HandlerType.DISTRICT_SEARCH_TYPE);
                break;
            case MethodID.BMFGeoAndReverseGeoMethodID.GEO_CODE:
            case MethodID.BMFGeoAndReverseGeoMethodID.REVERSE_GEO_CODE:
                methodChannelHandler = methodHandlerMap
                        .get(Constants.HandlerType.GEO_CODER_AND_REVERSE_GEO_CODER_SEARCH_TYPE);
                break;
            case MethodID.BuslineSearchMethodID.BUSLINE_SEARCH:
                methodChannelHandler =
                        methodHandlerMap.get(Constants.HandlerType.BUSLINE_SEARCH_TYPE);
                break;
            case MethodID.BuildingSearchMethodID.BUILDING_SEARCH:
                methodChannelHandler =
                        methodHandlerMap.get(Constants.HandlerType.BUILDING_SEARCH_TYPE);
                break;
            case MethodID.ShareUrlMethodID.REQUEST_LOCATION_SHARE_URL:
            case MethodID.ShareUrlMethodID.REQUEST_POIDETAIL_SHARE_URL:
            case MethodID.ShareUrlMethodID.REQUEST_ROUTEPLAN_SHARE_URL:
                methodChannelHandler = methodHandlerMap.get(Constants.HandlerType.SHARE_URL_TYPE);
                break;
            case MethodID.SuggestionMethodID.SUGGESTION_METHOD_NAME:
                methodChannelHandler =
                        methodHandlerMap.get(Constants.HandlerType.SUGGESTION_SEARCH_TYPE);
                break;
            case MethodID.PoiMethodID.POI_DETAIL_SEARCH:
            case MethodID.PoiMethodID.POI_INDOOR_SEARCH:
            case MethodID.PoiMethodID.POI_SEARCHIN_CITY:
                methodChannelHandler = methodHandlerMap.get(Constants.HandlerType.POI_SEARCH_TYPE);
                break;
            case MethodID.PoiMethodID.POI_SEARCH_INBOUNDS:
                methodChannelHandler =
                        methodHandlerMap.get(Constants.HandlerType.POI_BOUNDS_SEARCH);
                break;
            case MethodID.PoiMethodID.POI_SEARCH_NEARBY:
                methodChannelHandler =
                        methodHandlerMap.get(Constants.HandlerType.POI_NEARBY_SEARCH);
                break;
            case MethodID.RouteMethodID.sDrivingSearch:
            case MethodID.RouteMethodID.sIndoorRoutePlanSearch:
            case MethodID.RouteMethodID.sMassTransitSearch:
            case MethodID.RouteMethodID.sRidingSearch:
            case MethodID.RouteMethodID.sTransitSearch:
            case MethodID.RouteMethodID.sWalkingSearch:
                methodChannelHandler =
                        methodHandlerMap.get(Constants.HandlerType.ROUTE_LINE_SEARCH_TYPE);
                break;
            case MethodID.BMFWeatherSearchMethodID.WEATHER_SEARCH:
                methodChannelHandler = methodHandlerMap.get(Constants.HandlerType.WEATHER_TYPE);
                break;
            default:
                break;
        }

        if (null != methodChannelHandler) {
            methodChannelHandler.handleMethodCallResult(call, result);
        }
    }

    public void destroy() {
        Iterator itr = methodHandlerMap.values().iterator();
        MethodChannelHandler methodChannelHandler;
        while (itr.hasNext()) {
            methodChannelHandler = (MethodChannelHandler) itr.next();
            if (null != methodChannelHandler) {
                methodChannelHandler.destroy();
            }
        }
    }
}