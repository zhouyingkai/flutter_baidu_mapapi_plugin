package com.baidu.mapapi.search.bean.result.route.masstransirouteresult;

import com.baidu.mapapi.search.core.TransitBaseInfo;

/**
 * 公共交通方案里的交通工具信息基类
 */
public class BMFMassBaseVehicleInfo {
    /**
     * 该交通路线的名称
     */
    String name;

    /**
     * 出发站
     */
    String departureStation;

    /**
     * 到达站
     */
    String arriveStation;

    /**
     * 出发时间(BMFBusVehicleInfo时departureTime为空)
     */
    String departureTime;

    /**
     * 到达时间(BMFBusVehicleInfo时arriveTime为空)
     */
    String arriveTime;

    public BMFMassBaseVehicleInfo(TransitBaseInfo transitBaseInfo) {
        if (null == transitBaseInfo) {
            return;
        }

        this.name = transitBaseInfo.getName();
        this.departureStation = transitBaseInfo.getDepartureStation();
        this.arriveStation = transitBaseInfo.getArriveStation();
        this.departureTime = transitBaseInfo.getDepartureTime();
        this.arriveTime = transitBaseInfo.getArriveTime();
    }
}
