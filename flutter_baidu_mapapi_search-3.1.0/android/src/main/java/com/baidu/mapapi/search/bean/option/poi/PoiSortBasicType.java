package com.baidu.mapapi.search.bean.option.poi;

public enum PoiSortBasicType {
    /**
     * 宾馆行业，默认排序
     */
    HOTEL_DEFAULT,

    /**
     * 宾馆行业，按价格排序
     */
    HOTEL_PRICE,

    /**
     * 宾馆行业，按距离排序（只对周边检索有效）
     */
    HOTEL_DISTANCE,

    /**
     * 宾馆行业，按好评排序
     */
    HOTEL_TOTAL_SCORE,

    /**
     * 宾馆行业，按星级排序
     */
    HOTEL_LEVEL,

    /**
     * 宾馆行业，按卫生排序
     */
    HOTEL_HEALTH_SCORE,

    /**
     * 餐饮行业，默认排序
     */
    CATER_DEFAULT,

    /**
     * 餐饮行业，按价格排序
     */
    CATER_PRICE,

    /**
     * 餐饮行业，按距离排序（只对周边检索有效）
     */
    CATER_DISTANCE,

    /**
     * <餐饮行业，按口味排序
     */
    CATER_TASTE_RATING,

    /**
     * 餐饮行业，按好评排序
     */
    CATER_OVERALL_RATING,

    /**
     * 餐饮行业，按服务排序
     */
    CATER_SERVICE_RATING,

    /**
     * 生活娱乐行业，默认排序
     */
    LIFE_DEFAULT,

    /**
     * 生活娱乐行业，按价格排序
     */
    LIFE_PRICE,

    /**
     * 生活娱乐行业，按距离排序（只对周边检索有效）
     */
    LIFE_DISTANCE,

    /**
     * 生活娱乐行业，按好评排序
     */
    LIFE_OVERALL_RATING,

    /**
     * 生活娱乐行业，按服务排序
     */
    LIFE_COMMENT_NUMBER,
}
