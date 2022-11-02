/*
 * Copyright (C) 2020 Baidu, Inc. All Rights Reserved.
 */
package com.baidu.mapapi.search.bean.result.route;

import com.baidu.mapapi.model.LatLng;
import com.baidu.mapapi.search.core.TransitResultNode;

public class BMFTransitResultNode {
    /**
     * 城市ID
     */
    public int cityId;

    /**
     * 城市名
     */
    public String cityName;

    /**
     * 坐标点
     */
    public LatLng location;

    /**
     * 检索关键字
     */
    public String searchWord;

    public BMFTransitResultNode(TransitResultNode transitResultNode) {
        if (null == transitResultNode) {
            return;
        }

        this.cityId = transitResultNode.getCityId();
        this.cityName = transitResultNode.getCityName();
        this.location = transitResultNode.getLocation();
        this.searchWord = transitResultNode.getSearchWord();
    }
}
