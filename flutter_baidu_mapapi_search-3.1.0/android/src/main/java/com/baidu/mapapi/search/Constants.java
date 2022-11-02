package com.baidu.mapapi.search;

public class Constants {

    public static final String RESULT_KEY = "result";
    public static final String ERROR_KEY = "errorCode";

    /**
     * channel名
     */
    public static class MethodChannelName{

        /** 检索channel */
        public static final String SEARCH_CHANNEL = "flutter_bmfsearch";

    }

    /**
     * handler类型
     */
    public static class HandlerType {
        public static final int INVALID_HANDLE_TYPE = -1;
        public static final int DISTRICT_SEARCH_TYPE = 0;
        public static final int GEO_CODER_AND_REVERSE_GEO_CODER_SEARCH_TYPE = 1;
        public static final int BUSLINE_SEARCH_TYPE = 2;
        public static final int POI_SEARCH_TYPE =  3;
        public static final int ROUTE_LINE_SEARCH_TYPE = 4;
        public static final int SHARE_URL_TYPE = 5;
        public static final int SUGGESTION_SEARCH_TYPE = 6;
        public static final int POI_CITY_SEARCH = 7;
        public static final int POI_BOUNDS_SEARCH = 8;
        public static final int POI_NEARBY_SEARCH = 9;
        public static final int RECOMMEND_STOP_TYPE = 10;
        public static final int WEATHER_TYPE = 11;
        public static final int BUILDING_SEARCH_TYPE = 12;
    }

    public static enum ErrorCode{
        /** 检索结果正常返回 */
        NO_ERROR,

        /**检索词有岐义*/
        AMBIGUOUS_KEYWORD,

        /**检索地址有岐义*/
        AMBIGUOUS_ROURE_ADDR,

        /**该城市不支持公交搜索*/
        NOT_SUPPORT_BUS,

        /**不支持跨城市公交*/
        NOT_SUPPORT_BUS_2CITY,

        /**没有找到检索结果*/
        RESULT_NOT_FOUND,

        /**起终点太近*/
        ST_EN_TOO_NEAR,

        /**key错误*/
        KEY_ERROR,

        /**网络连接错误*/
        NETWOKR_ERROR,

        /**网络连接超时*/
        NETWOKR_TIMEOUT,

        /**还未完成鉴权，请在鉴权通过后重试*/
        PERMISSION_UNFINISHED,

        /**室内图ID错误*/
        INDOOR_ID_ERROR,

        /**室内图检索楼层错误*/
        FLOOR_ERROR,

        /**起终点不在支持室内路线的室内图内*/
        INDOOR_ROUTE_NO_IN_BUILDING,

        /**起终点不在同一个室内*/
        INDOOR_ROUTE_NO_IN_SAME_BUILDING,

        /**参数错误*/
        PARAMETER_ERROR,

        /**服务器错误*/
        SERVER_ERROR,
    }
}
