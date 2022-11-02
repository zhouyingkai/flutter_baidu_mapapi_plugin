package com.baidu.mapapi.utils;

public class Constants {

    public static final String COMMON_METHOD_CHANNEL = "flutter_bmfutils";

    public static final String OPEN_METHOD_CHANNEL = "flutter_bmfutils/open";

    public static final String CONVERTER_METHOD_CHANNEL = "flutter_bmfutils/calculate";

    /**
     * 打开地图客户端handler类型
     */
    public static class HandlerType {

        /**
         * 打开导航
         */
        public static final int OPEN_NAVI_TYPE = 0;

        /**
         * 打开路径规划
         */
        public static final int OPEN_ROUTE_TYPE = 1;

        /**
         * 打开全景
         */
        public static final int OPEN_PANO_TYPE = 2;

        /**
         * 打开poi详情
         */
        public static final int OPEN_POI_DETAIL_TYPE = 3;

        /**
         * 打开附近poi
         */
        public static final int OPEN_POI_NEAR_TYPE = 4;

        /**
         * 计算工具
         */
        public static final int CALCULATE_TYPE = 5;

        /**
         * 获取版本号
         */
        public static final int GET_VERSION_TYPE = 6;
    }

    /**
     * 调起客户端的导航类
     */
    public static class NaviType {
        /**
         * 调起百度地图客户端驾车导航页面(不支持调起web地图)
         */
        public static final int sDriveNavi = 0;

        /**
         * 调起百度地图客户端步行导航页面(不支持调起web地图)`
         * 客户端v8.8以后支持
         */
        public static final int sWalkNavi = 1;

        /**
         * 调起百度地图客户端骑行导航页面(不支持调起web地图)
         * 客户端v8.8以后支持
         */
        public static final int sRideNavi = 2;

        /**
         * 调起百度地图AR步行导航
         * 百度地图客户端v9.7.5以后支持AR步行导航，低于此版本，默认调用步行导航；注：客户端版本低于8.6.9，不支持步行导航。
         */
        public static final int sARWalkNavi = 3;
    }

    /**
     * 调起路径规划类型
     */
    public static class RouteType {
        /**
         * 调起百度地图步行路线
         */
        public static final int sWalkingRoute = 0;

        /**
         * 调起百度地图驾车路线
         */
        public static final int sDrivingRoute = 1;

        /**
         * 调起百度地图公共交通路线
         */
        public static final int sTransitRoute = 2;
    }

    /**
     * 错误码定义
     */
    public static class ErrorCode {
        /**
         * 正常
         */
        public static final int OPEN_NO_ERROR = 0;

        /**
         * 打开的是web地图
         */
        public static final int OPEN_WEB_MAP = 1;

        /**
         * 传入的参数为空
         */
        public static final int OPEN_OPTION_NULL = 2;

        /**
         * 没有安装百度地图，或者版本太低
         */
        public static final int OPEN_NOT_SUPPORT = 3;

        /**
         * poi详情 poiUid为空
         */
        public static final int OPEN_POI_DETAIL_UID_NULL = 4;

        /**
         * poi周边 keyWord为空
         */
        public static final int OPEN_POI_NEARBY_KEYWORD_NULL = 5;

        /**
         * 路线起点有误
         */
        public static final int OPEN_ROUTE_START_ERROR = 6;

        /**
         * 路线终点有误
         */
        public static final int OPEN_ROUTE_END_ERROR = 7;

        /**
         * 调起全景 poiUid不正确
         */
        public static final int OPEN_PANORAMA_UID_ERROR = 8;

        /**
         * 调起全景 此处不支持全景
         */
        public static final int OPEN_PANORAMA_ABSENT = 9;

        /**
         * 还未完成鉴权，请在鉴权通过后重试
         */
        public static final int OPEN_PERMISSION_UNFINISHED = 10;

        /**
         * app key错误
         */
        public static final int OPEN_KEY_ERROR = 11;

        /**
         * 网络连接错误
         */
        public static final int OPEN_NETWOKR_ERROR = 12;

        /**
         * 其它错误
         */
        public static final int OPEN_OTHER_ERROR = 13;

        /**
         * 参数错误
         */
        public static final int OPTION_ERROR = 14;
    }
}
