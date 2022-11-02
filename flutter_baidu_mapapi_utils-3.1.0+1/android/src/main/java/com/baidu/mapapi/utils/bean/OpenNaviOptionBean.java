package com.baidu.mapapi.utils.bean;

import com.baidu.mapapi.model.LatLng;

public class OpenNaviOptionBean {
    /**
     * 导航起点， 经纬度坐标
     */
    public LatLng startCoord;

    /**
     * 导航起点名称
     */
    public String startName;

    /**
     * 导航终点， 经纬度坐标
     */
    public LatLng endCoord;

    /**
     * 导航终点名称
     */
    public String endName;

    /**
     * 调起导航类型
     */
    public int naviType;

    /**
     * 调起百度地图客户端失败后，打开网页版百度地图
     */
    public boolean isSupportWeb;
}
