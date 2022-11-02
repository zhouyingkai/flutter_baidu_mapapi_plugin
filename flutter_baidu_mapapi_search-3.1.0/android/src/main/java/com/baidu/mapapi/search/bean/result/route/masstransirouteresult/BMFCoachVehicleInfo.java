package com.baidu.mapapi.search.bean.result.route.masstransirouteresult;

import com.baidu.mapapi.search.core.CoachInfo;

/**
 * 公共交通方案里的交通工具信息类 - 大巴
 */
public class BMFCoachVehicleInfo extends BMFMassBaseVehicleInfo {
    /**
     * 价格（单位：元）
     */
    double price;

    /**
     * 订票网址
     */
    String bookingUrl;

    /**
     * 合作方名称
     */
    String providerName;

    /**
     * 合作方官网
     */
    String providerUrl;

    public BMFCoachVehicleInfo(CoachInfo coachInfo) {
        super(coachInfo);
        if (null == coachInfo) {
            return;
        }

        this.price = coachInfo.getPrice();
        this.bookingUrl = coachInfo.getBooking();
        this.providerName = coachInfo.getProviderName();
        this.providerUrl = coachInfo.getProviderUrl();
    }
}
