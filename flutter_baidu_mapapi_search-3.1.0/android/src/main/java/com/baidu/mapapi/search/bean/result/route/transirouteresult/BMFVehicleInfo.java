package com.baidu.mapapi.search.bean.result.route.transirouteresult;

import com.baidu.mapapi.search.core.VehicleInfo;

/**
 * 路线换乘方案里的交通工具信息
 */
public class BMFVehicleInfo {
    /**
     * 该交通路线的标识
     */
    String uid;

    /**
     * 该交通路线的名称
     */
    String title;

    /**
     * 该交通路线的所乘站数
     */
    int passStationNum;

    /**
     * 该交通路线的全程价格
     */
    int totalPrice;

    /**
     * 该交通路线的所乘区间的区间价格
     */
    int zonePrice;

    public BMFVehicleInfo(VehicleInfo vehicleInfo) {
        if (null == vehicleInfo) {
            return;
        }

        this.uid = vehicleInfo.getUid();
        this.title = vehicleInfo.getTitle();
        this.passStationNum = vehicleInfo.getPassStationNum();
        this.totalPrice = vehicleInfo.getTotalPrice();
        this.zonePrice = vehicleInfo.getZonePrice();
    }
}
