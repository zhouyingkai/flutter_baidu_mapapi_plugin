package com.baidu.mapapi.search.bean.result.route.walkingrouteresult;

import java.util.List;

import com.baidu.mapapi.model.LatLng;
import com.baidu.mapapi.search.bean.result.route.BMFRouteNode;
import com.baidu.mapapi.search.bean.result.route.BMFStep;
import com.baidu.mapapi.search.route.WalkingRouteLine.WalkingStep;

/**
 * 不行的一个路段
 */
public class BMFWalkingStep extends BMFStep {
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

    public BMFWalkingStep(WalkingStep walkingStep) {
        super(walkingStep);
        if (null == walkingStep) {
            return;
        }
        this.direction = walkingStep.getDirection();
        this.entrace = new BMFRouteNode(walkingStep.getEntrance());
        this.entraceInstruction = walkingStep.getEntranceInstructions();
        this.exit = new BMFRouteNode(walkingStep.getExit());
        this.exitInstruction = walkingStep.getExitInstructions();
        this.instruction = walkingStep.getInstructions();
    }
}
