package com.baidu.mapapi.search.bean.result.route.ridingrouteresult;

import java.util.List;

import com.baidu.mapapi.model.LatLng;
import com.baidu.mapapi.search.bean.result.route.BMFRouteNode;
import com.baidu.mapapi.search.bean.result.route.BMFStep;
import com.baidu.mapapi.search.route.BikingRouteLine;

public class BMFRidingStep extends BMFStep {
    /**
     * 该路段起点方向值
     */
    int direction;

    /**
     * 路段入口信息
     */
    BMFRouteNode entrace;

    /**
     * 获取该路段入口指示信息
     */
    String entraceInstruction;

    /**
     * 路段出口信息
     */
    BMFRouteNode exit;

    /**
     * 获取该路段出口指示信息
     */
    String exitInstruction;

    /**
     * 获取该路段指示信息
     */
    String instruction;


    public BMFRidingStep(BikingRouteLine.BikingStep bikingStep) {
        super(bikingStep);
        if (null == bikingStep) {
            return;
        }

        this.direction = bikingStep.getDirection();
        this.entrace = new BMFRouteNode(bikingStep.getEntrance());
        this.entraceInstruction = bikingStep.getEntranceInstructions();
        this.exit = new BMFRouteNode(bikingStep.getExit());
        this.exitInstruction = bikingStep.getExitInstructions();
        this.instruction = bikingStep.getInstructions();
    }
}
