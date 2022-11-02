package com.baidu.mapapi.search.bean.result.route.masstransirouteresult;

import com.baidu.mapapi.search.core.PlaneInfo;

/**
 * 公共交通方案里的交通工具信息类 - 飞
 */
public class BMFPlaneVehicleInfo extends BMFMassBaseVehicleInfo {
    /**
     * 价格（单位：元）
     */
    double price;

    /**
     * 折扣
     */
    double discount;

    /**
     * 航空公司
     */
    String airlines;

    /**
     * 订票网址
     */
    String bookingUrl;

    public BMFPlaneVehicleInfo(PlaneInfo planeInfo) {
        super(planeInfo);

        if (null == planeInfo) {
            return;
        }

        this.price = planeInfo.getPrice();
        this.discount = planeInfo.getDiscount();
        this.airlines = planeInfo.getAirlines();
        this.bookingUrl = planeInfo.getBooking();
    }
}
