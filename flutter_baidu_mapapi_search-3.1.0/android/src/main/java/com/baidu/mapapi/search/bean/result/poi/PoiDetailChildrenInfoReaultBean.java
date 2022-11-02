/*
 * Copyright (C) 2020 Baidu, Inc. All Rights Reserved.
 */
package com.baidu.mapapi.search.bean.result.poi;

import com.baidu.mapapi.search.bean.option.LatLngBean;
import com.baidu.mapapi.search.core.PoiChildrenInfo;

/**
 * POI详情子节点信息类，需要权限（使用带有此权限的AK
 */
public class PoiDetailChildrenInfoReaultBean {
    /** poi子点uid */
    public String uid;

    /** poi子点名称 */
    String name;

    /** poi子点简称 */
    public String showName;

    /** poi子点类别 */
    public String tag;

    /** poi子节点经纬度 */
    public LatLngBean pt;

    /** poi子点地址 */
    String address;

    public PoiDetailChildrenInfoReaultBean(PoiChildrenInfo poiChildrenInfo) {
        if (null == poiChildrenInfo) {
            return;
        }

        this.address = poiChildrenInfo.getAddress();
        this.name = poiChildrenInfo.getName();
        this.pt = new LatLngBean(poiChildrenInfo.getLocation());
        this.showName = poiChildrenInfo.getShowName();
        this.tag = poiChildrenInfo.getTag();
        this.uid = poiChildrenInfo.getUid();
    }
}
