package com.baidu.mapapi.search.bean.result.busline;

import java.util.List;

import com.baidu.mapapi.model.LatLng;
import com.baidu.mapapi.search.busline.BusLineResult;

/**
 * 公交步进bean
 */
public class BusStepBean {
    /**
     * 路段长度 单位： 米
     */
    public int distance;

    /**
     * 路段耗时 单位： 秒
     */
    public int duration;

    /**
     * 路段道路名称
     */
    public String name;

    /**
     * 途经点
     */
    List<LatLng> points;

    public BusStepBean(BusLineResult.BusStep busStep) {
        if (null == busStep) {
            return;
        }

        this.distance = busStep.getDistance();
        this.duration = busStep.getDuration();
        this.name = busStep.getName();
        this.points = busStep.getWayPoints();
    }
}
