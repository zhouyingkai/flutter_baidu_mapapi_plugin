package com.baidu.mapapi.search.bean.result.route.transirouteresult;

import java.util.List;

import com.baidu.mapapi.model.LatLng;
import com.baidu.mapapi.search.bean.result.route.BMFRouteNode;
import com.baidu.mapapi.search.bean.result.route.BMFStep;
import com.baidu.mapapi.search.route.TransitRouteLine;

public class BMFTransitStep extends BMFStep {

    /**
     * 路段类型枚举
     */
    enum BMFTransitStepType {
        /**
         * 公交
         */
        BUSLINE,

        /**
         * 地铁
         */
        SUBWAY,

        /**
         * 步行
         */
        WAKLING,
    }

    /**
     * 路段入口信息
     */
    BMFRouteNode entrace;

    /**
     * 路段出口信息
     */
    BMFRouteNode exit;

    /**
     * 路段换乘说明
     */
    String instruction;

    /**
     * 路段类型
     */
    int stepType;

    /**
     * 当路段为公交路段或地铁路段时，可以获取交通工具信息
     */
    BMFVehicleInfo vehicleInfo;


    public BMFTransitStep(TransitRouteLine.TransitStep transitStep) {
        super(transitStep);
        if (null == transitStep) {
            return;
        }

        this.entrace = new BMFRouteNode(transitStep.getEntrance());
        this.exit = new BMFRouteNode(transitStep.getExit());
        this.instruction = transitStep.getInstructions();
        TransitRouteLine.TransitStep.TransitRouteStepType stepType = transitStep.getStepType();
        if (null != stepType) {
            this.stepType = stepType.ordinal();
        }
        this.vehicleInfo = new BMFVehicleInfo(transitStep.getVehicleInfo());
    }
}
