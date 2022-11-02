/*
 * Copyright (C) 2020 Baidu, Inc. All Rights Reserved.
 */
package com.baidu.mapapi.search.bean.result.route;

import java.util.List;

import com.baidu.mapapi.model.LatLng;
import com.baidu.mapapi.search.core.RouteStep;

/**
 * 路线中的一个路段（基类）
 */
public class BMFStep {
    /**
     *  路段长度 单位： 米
     */
    public int distance;

    /**
     * 路段耗时 单位： 秒
     */
    public int duration;

    /**
     * 路段所经过的坐标集合
     */
    List<LatLng> points;

    /**
     * 路段所经过的地理坐标集合内点的个数
     *
     * Android 不支持
     */
    public int pointsCount;

    /**
     * 路段道路名称
     * iOS 不支持
     */
    public String name;

    public BMFStep(RouteStep routeStep) {
        if (null == routeStep) {
            return;
        }

        this.distance = routeStep.getDistance();
        this.duration = routeStep.getDuration();
        this.points = routeStep.getWayPoints();
        this.name = routeStep.getName();
    }
}
