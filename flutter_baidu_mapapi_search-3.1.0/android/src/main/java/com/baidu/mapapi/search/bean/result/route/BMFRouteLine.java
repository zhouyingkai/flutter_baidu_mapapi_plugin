/*
 * Copyright (C) 2020 Baidu, Inc. All Rights Reserved.
 */
package com.baidu.mapapi.search.bean.result.route;

import com.baidu.mapapi.search.core.RouteLine;
import com.baidu.mapapi.search.core.RouteStep;

/**
 * routeline基类
 */
public class BMFRouteLine {
    /**
     *  路线长度 单位： 米
     */
    public int distance;

    /**
     * 路线耗时 单位： 秒
     */
    public BMFTime duration;

    /**
     * 路线起点信息
     */
    public BMFRouteNode starting;

    /**
     * 路线终点信息
     */
    public BMFRouteNode terminal;

    /**
     *  路线名称(预留字段，现为空)
     */
    public String title;

    public BMFRouteLine(RouteLine<? extends RouteStep> walkingRouteLine) {
        if (null == walkingRouteLine) {
            return;
        }

        this.distance = walkingRouteLine.getDistance();
        this.duration = new BMFTime(walkingRouteLine.getDuration());

        this.starting = new BMFRouteNode(walkingRouteLine.getStarting());
        this.terminal = new BMFRouteNode(walkingRouteLine.getTerminal());
        this.title = walkingRouteLine.getTitle();
    }
}
