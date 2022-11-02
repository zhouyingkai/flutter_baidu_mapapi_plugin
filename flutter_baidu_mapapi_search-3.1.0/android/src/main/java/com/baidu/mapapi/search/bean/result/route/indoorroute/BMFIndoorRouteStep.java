package com.baidu.mapapi.search.bean.result.route.indoorroute;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.baidu.mapapi.model.LatLng;
import com.baidu.mapapi.search.bean.result.route.BMFRouteNode;
import com.baidu.mapapi.search.bean.result.route.BMFStep;
import com.baidu.mapapi.search.route.IndoorRouteLine.IndoorRouteStep;
import com.baidu.mapapi.search.route.IndoorRouteLine.IndoorRouteStep.IndoorStepNode;

/**
 * 此类表示室内路线的一个路
 */
public class BMFIndoorRouteStep extends BMFStep {
    /**
     * 入口信息
     */
    BMFRouteNode entrace;

    /**
     * 出口信息
     */
    BMFRouteNode exit;

    /**
     * 路段指示信息
     */
    String instructions;

    /**
     * 建筑物id
     */
    String buildingid;

    /**
     * 室内楼层id
     */
    String floorid;

    /**
     * 结点数组，成员类型为：BMFIndoorStepNode
     */
    List<BMFIndoorStepNode> indoorStepNodes = new ArrayList<>();

    public BMFIndoorRouteStep(IndoorRouteStep indoorRouteStep) {
        super(indoorRouteStep);
        if (null == indoorRouteStep) {
            return;
        }

        this.entrace = new BMFRouteNode(indoorRouteStep.getEntrace());
        this.buildingid = indoorRouteStep.getBuildingId();
        this.exit = new BMFRouteNode(indoorRouteStep.getExit());
        this.instructions = indoorRouteStep.getInstructions();
        this.floorid = indoorRouteStep.getFloorId();

        List<IndoorStepNode> stepNodes =
                indoorRouteStep.getStepNodes();

        if (null == stepNodes || stepNodes.size() <= 0) {
            return;
        }

        Iterator itr = stepNodes.iterator();
        while (itr.hasNext()) {
            IndoorStepNode indoorStepNode = (IndoorStepNode) itr.next();
            if (null == indoorStepNode) {
                continue;
            }

            BMFIndoorStepNode bmfIndoorPlanNode = new BMFIndoorStepNode(indoorStepNode);
            indoorStepNodes.add(bmfIndoorPlanNode);
        }
    }
}
