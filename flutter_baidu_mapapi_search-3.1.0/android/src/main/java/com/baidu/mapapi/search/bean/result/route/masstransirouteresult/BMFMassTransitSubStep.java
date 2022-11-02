package com.baidu.mapapi.search.bean.result.route.masstransirouteresult;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.baidu.mapapi.model.LatLng;
import com.baidu.mapapi.search.bean.result.route.BMFStep;
import com.baidu.mapapi.search.bean.result.route.BMFTrafficCondition;
import com.baidu.mapapi.search.route.MassTransitRouteLine;
import static com.baidu.mapapi.search.route.MassTransitRouteLine.TransitStep.TrafficCondition;

/**
 * 此类表示公共交通路线中的一个路
 */
public class BMFMassTransitSubStep extends BMFStep {

    /**
     * 交通方式枚举
     */
    enum BMFMassTransitType {
        /**
         * 地铁
         */
        SUBWAY,

        /**
         * 火车
         */
        TRAIN,

        /**
         * 飞机
         */
        PLANE,

        /**
         * 公交
         */
        BUSLINE,

        /**
         * 驾车
         */
        DRIVING,

        /**
         * 步行
         */
        WAKLING,

        /**
         * 大巴
         */
        COACH,
    }

    /**
     * 路段入口经纬度
     */
    LatLng entraceCoor;

    /**
     * 路段出口经纬度
     */
    LatLng exitCoor;

    /**
     * 路段说明
     */
    String instructions;

    /**
     * 路段类型
     */
    int stepType;

    /**
     * 大巴
     */
    BMFCoachVehicleInfo coachVehicleInfo;

    /**
     * 公交和地铁
     */
    BMFBusVehicleInfo busAndSubwayVehicleInfo;

    /**
     * 飞机
     */
    BMFPlaneVehicleInfo planeVehicleInfo;

    /**
     * 火车
     */
    BMFTrainVehicleInfo trainVehicleInfo;

    /**
     * 路况
     */
    List<BMFTrafficCondition> trafficConditions = new ArrayList<>();

    public BMFMassTransitSubStep(MassTransitRouteLine.TransitStep transitStep) {
        super(transitStep);
        if (null == transitStep) {
            return;
        }

        this.entraceCoor = transitStep.getStartLocation();
        this.exitCoor = transitStep.getEndLocation();
        this.instructions = transitStep.getInstructions();

        MassTransitRouteLine.TransitStep.StepVehicleInfoType stepVehicleInfoType = transitStep.getVehileType();
        if (null != stepVehicleInfoType) {
            this.stepType = stepVehicleInfoType.getInt();
        }

        getVehicleInfo(transitStep, stepType);

        getTrafficCondition(transitStep);
    }

    private void getVehicleInfo(MassTransitRouteLine.TransitStep transitStep,
                                                  int stepType) {
        if (stepType < 0 || stepType > BMFMassTransitType.values().length) {
            return;
        }

        BMFMassTransitType transitType = BMFMassTransitType.values()[stepType];

        switch (transitType) {
            case COACH:
                this.coachVehicleInfo = new BMFCoachVehicleInfo(transitStep.getCoachInfo());
                break;
            case PLANE:
                this.planeVehicleInfo = new BMFPlaneVehicleInfo(transitStep.getPlaneInfo());
                break;
            case TRAIN:
                this.trainVehicleInfo = new BMFTrainVehicleInfo(transitStep.getTrainInfo());
                break;
            case SUBWAY:
            case BUSLINE:
                this.busAndSubwayVehicleInfo = new BMFBusVehicleInfo(transitStep.getBusInfo());
                break;
            default:
                break;
        }
    }

    private void getTrafficCondition(MassTransitRouteLine.TransitStep transitStep) {
        if (null == transitStep) {
            return;
        }


        List<TrafficCondition> tmpTrafficConditions = transitStep.getTrafficConditions();

        if (null == tmpTrafficConditions || tmpTrafficConditions.size() <= 0) {
            return;
        }

        Iterator itr = tmpTrafficConditions.iterator();
        while (itr.hasNext()) {
            TrafficCondition  trafficCondition = (TrafficCondition) itr.next();
            if (null == trafficCondition) {
                continue;
            }

            BMFTrafficCondition bmfTrafficCondition = new BMFTrafficCondition(trafficCondition);
            trafficConditions.add(bmfTrafficCondition);
        }
    }
}
