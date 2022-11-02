package com.baidu.mapapi.utils;

/**
 * 与flutter通信的methodID
 */
public class MethodID {

    /**
     * 公共的methodID
     */
    public static class CommonMethodID {
        /**
         * 获取util版本号
         */
        public static final String kGetVersion = Constants.COMMON_METHOD_CHANNEL + "/utils"
                + "/getNativeUtilsVersion";
    }

    /**
     * SDK调起百度地图客户端功能methodID
     */
    public static class OpenMethodID {
        /**
         * 调起客户端 -- 导航
         */
        public static final String kOpenBaiduMapNavi =
                Constants.OPEN_METHOD_CHANNEL + "/openBaiduMapNavi";

        /**
         * 调起百度地图 -- 路线
         */
        public static final String kOpenBaiduMapRoute =
                Constants.OPEN_METHOD_CHANNEL + "/openBaiduMapRoute";

        /**
         * 调起百度地图 -- poi详情
         */
        public static final String kOpenBaiduMapPoiDetail =
                Constants.OPEN_METHOD_CHANNEL + "/openBaiduMapPoiDetail";

        /**
         * 调起百度地图 -- poi周边
         */
        public static final String kOpenBaiduMapPoiNear =
                Constants.OPEN_METHOD_CHANNEL + "/openBaiduMapPoiNear";

        /**
         * 调起百度地图 -- 全景
         */
        public static final String kOpenBaiduMapPanorama =
                Constants.OPEN_METHOD_CHANNEL + "/openBaiduMapPanorama";
    }

    /**
     * 计算methodID
     */
    public static class CalcMethodID {
        /**
         * 坐标转换
         */
        public static final String kCoordTypeConvert =
                Constants.CONVERTER_METHOD_CHANNEL + "/coordTransType";

        /**
         * 计算矩形面积
         */
        public static final String kCalculateRectArea =
                Constants.CONVERTER_METHOD_CHANNEL + "/areaBetweenCoordinates";

        /**
         * 计算多边形面积
         */
        public static final String kCalculatePolygonArea =
                Constants.CONVERTER_METHOD_CHANNEL + "/calculatePolygonArea";

        /**
         * 坐标是否在polygon内
         */
        public static final String kPolygonContainsCoord =
                Constants.CONVERTER_METHOD_CHANNEL + "/polygonContainsCoord";

        /**
         * 坐标是否在cirlce内
         */
        public static final String kCircleContainsCoord =
                Constants.CONVERTER_METHOD_CHANNEL + "/circleContainsCoord";

        /**
         * 计算两点之间的距离
         */
        public static final String kLocationDistance =
                Constants.CONVERTER_METHOD_CHANNEL + "/locationDistance";

        /**
         * 获取点到折线最近的点
         */
        public static final String kNearestPointToLine =
                Constants.CONVERTER_METHOD_CHANNEL + "/nearestPointToLine";
    }
}