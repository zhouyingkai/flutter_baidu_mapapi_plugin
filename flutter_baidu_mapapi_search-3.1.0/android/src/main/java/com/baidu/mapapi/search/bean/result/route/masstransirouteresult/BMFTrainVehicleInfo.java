package com.baidu.mapapi.search.bean.result.route.masstransirouteresult;

import com.baidu.mapapi.search.core.TrainInfo;

/**
 * 公共交通方案里的交通工具信息类 - 火
 */
public class BMFTrainVehicleInfo extends BMFMassBaseVehicleInfo {
    /**
     * 价格（单位：元）
     */
    double price;

    /**
     * 订票电话
     */
    String booking;

    /**
     * sdk trainInfo有问题
     *
     * @param trainInfo
     */
    public BMFTrainVehicleInfo(TrainInfo trainInfo) {
        super(trainInfo);
        this.price = trainInfo.getPrice();
        this.booking = trainInfo.getBooking();
    }
}
