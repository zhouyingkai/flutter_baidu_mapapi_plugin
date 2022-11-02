package com.baidu.mapapi.search.bean.option.route;

import com.baidu.mapapi.model.LatLng;
import com.baidu.mapapi.search.route.IndoorPlanNode;
import com.baidu.mapapi.search.route.IndoorRouteLine;
import com.baidu.mapapi.search.route.IndoorRouteLine.IndoorRouteStep.IndoorStepNode;

/**
 * 室内路线检索节点信
 */
public class BMFIndoorPlanNode {
    /** 节点所在楼层 */
    String floor;

    /** 节点坐标 */
    LatLng pt;

    public IndoorPlanNode toIndoorPlanNode(){
        return new IndoorPlanNode(pt, floor);
    }
}
