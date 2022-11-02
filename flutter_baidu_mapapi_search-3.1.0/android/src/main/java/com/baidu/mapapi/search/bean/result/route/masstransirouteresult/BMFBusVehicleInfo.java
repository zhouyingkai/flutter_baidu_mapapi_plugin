package com.baidu.mapapi.search.bean.result.route.masstransirouteresult;

import com.baidu.mapapi.search.core.BusInfo;

/**
 * 公共交通方案里的交通工具信息类- 公交车、地
 */
public class BMFBusVehicleInfo extends BMFMassBaseVehicleInfo {
    /**
     * 该交通路线的所乘站数
     */
    public int passStationNum;

    /**
     * 市内公交的具体类型
     * Android独有
     */
    public int type;

    /**
     * 始发车发车时间
     * iOS独有
     */
    public String firstTime;

    /**
     * 末班车发车时间
     * iOS独有
     */
    public String lastTime;


    public BMFBusVehicleInfo(BusInfo busInfo) {
        super(busInfo);
        this.type = busInfo.getType();
        this.passStationNum = busInfo.getStopNum();
    }
}
