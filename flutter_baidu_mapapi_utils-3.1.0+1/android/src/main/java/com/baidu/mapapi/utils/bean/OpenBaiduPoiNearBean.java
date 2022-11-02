package com.baidu.mapapi.utils.bean;

import com.baidu.mapapi.model.LatLng;

/**
 * 附近poi
 */
public class OpenBaiduPoiNearBean {
    /**
     * 中心点（经纬度）
     */
    public LatLng location;

    /**
     * 半径
     */
    public int radius;

    /**
     * 关键词
     */
    public String keyword;

    /**
     * 调起百度地图客户端失败后，是否支持调起web地图
     */
    public boolean isSupportWeb;
}
