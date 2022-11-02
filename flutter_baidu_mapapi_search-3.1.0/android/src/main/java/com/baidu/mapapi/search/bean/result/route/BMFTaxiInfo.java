package com.baidu.mapapi.search.bean.result.route;

import com.baidu.mapapi.search.core.TaxiInfo;

/**
 * 打车信息类
 */
public class BMFTaxiInfo {
    /** 路线打车描述信息 */
    String desc;

    /** 总路程，单位： 米 */
    int distance;

    /** 总耗时，单位： 秒 */
    int duration;

    /** 每千米单价(白天)，单位 元 */
    double perKMPrice;

    /** 起步价(白天)，单位 元 */
    double startPrice;

    /** 总价(预估) , 单位： 元 */
    float totalPrice;

    public BMFTaxiInfo(TaxiInfo taxiInfo){
        if(null == taxiInfo){
            return;
        }
        this.desc = taxiInfo.getDesc();
        this.distance = taxiInfo.getDistance();
        this.duration = taxiInfo.getDuration();
        this.perKMPrice = taxiInfo.getPerKMPrice();
        if (Double.isNaN(this.perKMPrice)) {
            this.perKMPrice = -1.0;
        }

        this.startPrice = taxiInfo.getStartPrice();
        if (Double.isNaN(this.startPrice)) {
            this.startPrice = -1.0;
        }

        this.totalPrice = taxiInfo.getTotalPrice();
        if (Float.isNaN(this.totalPrice)) {
            this.totalPrice = -1.0f;
        }
    }
}
