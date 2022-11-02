package com.baidu.mapapi.search.bean.option;

import com.baidu.mapapi.model.LatLng;

/**
 * 地理位置分享
 */
public class LocationShareUrlOptionBean {
    /** 名称 */
    public String name;

    /** 通过短URL调起客户端时作为附加信息显示在名称下面 */
    public String snippet;

    /** 经纬度 */
    public LatLng location;
}
