package com.baidu.mapapi.search;


import com.baidu.mapapi.search.Constants.MethodChannelName;

public class MethodID {

    // 天气检索id
    public static class BMFWeatherSearchMethodID {
        public static final String WEATHER_SEARCH = MethodChannelName.SEARCH_CHANNEL +
                "/weatherSearch/weatherSearch";
    }

    // 推荐上车点检索方法id
    public static class BMFRecommendStopSearchMethodID {
        public static final String RECOMMEND_STOP_SEARCH = MethodChannelName.SEARCH_CHANNEL +
                "/recommendStopSearch/recommendStopSearch";
    }

    // 行政区域搜索服务方法id
    public static class BMFDistrictSearchMethodID {
        public static final String DISTRICT_SEARCH = MethodChannelName.SEARCH_CHANNEL +
                "/districtSearch/districtSearch";
    }

    // 地理编码方法id
    public static class BMFGeoAndReverseGeoMethodID {
        // 地理编码： 根据地址名称获取地理信息
        public static final String GEO_CODE = MethodChannelName.SEARCH_CHANNEL + "/geoSearch"
                + "/geoCode";

        // 反编码：根据地理坐标获取地址信息
        public static final String REVERSE_GEO_CODE = MethodChannelName.SEARCH_CHANNEL +
                "/geoSearch/reverseGeoCode";
    }

    /**
     * 公交线路检索方法id
     */
    public static class BuslineSearchMethodID {
        public static final String BUSLINE_SEARCH = MethodChannelName.SEARCH_CHANNEL +
                "/busLineSearch/busLineSearch";
    }

    /**
     * 建筑物检索方法id
     */
    public static class BuildingSearchMethodID {
        public static final String BUILDING_SEARCH = MethodChannelName.SEARCH_CHANNEL +
                "/buildingSearch/buildingSearch";
    }

    /**
     * 短串分享方法id
     */
    public static class ShareUrlMethodID {
        /**
         * 获取poi详情短串分享url
         */
        public static final String REQUEST_POIDETAIL_SHARE_URL = MethodChannelName.SEARCH_CHANNEL
                + "/shareURL/requestPoiDetailShareURL";


        /**
         * 获取路线规划短串分享url
         */
        public static final String REQUEST_ROUTEPLAN_SHARE_URL = MethodChannelName.SEARCH_CHANNEL
                + "/shareURL/requestRoutePlanShareURL";

        /**
         * 获取location短串分享url
         */
        public static final String REQUEST_LOCATION_SHARE_URL = MethodChannelName.SEARCH_CHANNEL
                + "/shareURL/requestLocationShareURL";
    }

    /**
     * suggest方法id
     */
    public static class SuggestionMethodID {
        public static final String SUGGESTION_METHOD_NAME = MethodChannelName.SEARCH_CHANNEL
                + "/suggestionSearch/suggestionSearch";
    }

    /**
     * poi检索方法id
     */
    public static class PoiMethodID {
        /**
         * 城市POI检索
         */
        public static final String POI_SEARCHIN_CITY = MethodChannelName.SEARCH_CHANNEL
                + "/poiSearch/poiSearchInCity";

        /**
         * 根据范围和检索词发起范围检索
         */
        public static final String POI_SEARCH_INBOUNDS = MethodChannelName.SEARCH_CHANNEL
                + "/poiSearch/poiSearchInbounds";

        /**
         * 根据中心点、半径和检索词发起周边检索
         */
        public static final String POI_SEARCH_NEARBY = MethodChannelName.SEARCH_CHANNEL
                + "/poiSearch/poiSearchNearBy";

        /**
         * 根据poi uid 发起poi详情检索
         */
        public static final String POI_DETAIL_SEARCH = MethodChannelName.SEARCH_CHANNEL
                + "/poiSearch/poiDetailSearch";

        /**
         * poi室内检索
         */
        public static final String POI_INDOOR_SEARCH = MethodChannelName.SEARCH_CHANNEL
                + "/poiSearch/poiIndoorSearch";
    }

    /**
     * route检索方法
     */
    public static class RouteMethodID {
        /**
         * 公交路线检索（仅支持市内）
         */
        public static final String sTransitSearch =
                MethodChannelName.SEARCH_CHANNEL + "/routeSearch/transitSearch";

        /**
         * 公共交通路线检索（new）（支持市内和跨城）
         */
        public static final String sMassTransitSearch =
                MethodChannelName.SEARCH_CHANNEL + "/routeSearch/massTransitSearch";

        /**
         * 驾乘路线检索
         */
        public static final String sDrivingSearch =
                MethodChannelName.SEARCH_CHANNEL + "/routeSearch/drivingSearch";

        /**
         * 步行路线检索
         */
        public static final String sWalkingSearch =
                MethodChannelName.SEARCH_CHANNEL + "/routeSearch/walkingSearch";

        /**
         * 骑行路线检索
         */
        public static final String sRidingSearch =
                MethodChannelName.SEARCH_CHANNEL + "/routeSearch/ridingSearch";

        /**
         * 室内路线检索
         */
        public static final String sIndoorRoutePlanSearch =
                MethodChannelName.SEARCH_CHANNEL + "/routeSearch/indoorRoutePlanSearch";
    }
}
