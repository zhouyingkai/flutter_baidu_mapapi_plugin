package com.baidu.mapapi.search.bean.result.busline;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.baidu.mapapi.search.bean.result.ResultBean;
import com.baidu.mapapi.search.busline.BusLineResult;
import com.baidu.mapapi.search.busline.BusLineResult.BusStation;
import com.baidu.mapapi.search.busline.BusLineResult.BusStep;

/**
 * 公交检索结果bean
 */
public class BusLineResultBean extends ResultBean {
    /**
     * 公交线路名称
     */
    public String busLineName;

    /**
     * 公交线路方向
     */
    public String busLineDirection;

    /**
     * 公交线路uid
     */
    public String uid;

    /**
     * 公交路线首班车时间
     */
    public String startTime;

    /**
     * 公交路线末班车时间
     */
    public String endTime;

    /**
     * 公交路线是否有月票
     */
    public boolean isMonTicket;

    /**
     * 起步票价
     */
    public double basicPrice;

    /**
     * 全程票价
     */
    public double totalPrice;

    /**
     * 所有公交站点信息,成员类型为BMKBusStation
     */
    public List<BusStationBean> busStations = new ArrayList<>();

    /**
     * 公交路线分段信息，成员类型为BMKBusStep
     */
    public List<BusStepBean> busSteps = new ArrayList<>();

    public BusLineResultBean(BusLineResult busLineResult) {
        if (null == busLineResult) {
            return;
        }

        this.basicPrice = busLineResult.getBasePrice();
        this.totalPrice = busLineResult.getMaxPrice();
        this.busLineDirection = busLineResult.getLineDirection();
        this.busLineName = busLineResult.getBusLineName();
        Date startTime = busLineResult.getStartTime();
        if (startTime != null) {
            this.startTime = startTime.toString();
        }
        Date endTime = busLineResult.getEndTime();
        if (endTime != null) {
            this.endTime = endTime.toString();
        }
        this.isMonTicket = busLineResult.isMonthTicket();
        this.uid = busLineResult.getUid();
        this.error = busLineResult.error;

        List<BusStation> tmpBusStations = busLineResult.getStations();
        if (null != tmpBusStations && tmpBusStations.size() > 0) {
            for (BusStation busStation : tmpBusStations) {
                this.busStations.add(new BusStationBean(busStation));
            }
        }

        List<BusStep> tmpBusSteps = busLineResult.getSteps();
        if (null != tmpBusSteps && tmpBusSteps.size() > 0) {
            for (BusStep busStep : tmpBusSteps) {
                this.busSteps.add(new BusStepBean(busStep));
            }
        }
    }
}
