package com.baidu.mapapi.search.bean.result.route.indoorroute;

import com.baidu.mapapi.model.LatLng;
import com.baidu.mapapi.search.route.IndoorRouteLine.IndoorRouteStep.IndoorStepNode;

/**
 * 室内路线结
 */
public class BMFIndoorStepNode {
    /**
     * 室内路线结点类型
     */
    enum BMFIndoorStepNodeType {
        /**
         * 直梯
         */
        ELEVATOR,

        /**
         * 扶梯
         */
        ESCALATOR,

        /**
         * 楼梯
         */
        STAIR,

        /**
         * 安检
         */
        SECURITY_CHECK,
    }

    /**
     * 坐标
     */
    LatLng coordinate;

    /**
     * 类型,取值为BMFIndoorStepNodeType
     */
    int type;

    /**
     * 描述
     */
    String desc;

    public BMFIndoorStepNode(IndoorStepNode indoorStepNode) {
        if (null == indoorStepNode) {
            return;
        }

        this.coordinate = indoorStepNode.getLocation();
        this.desc = indoorStepNode.getDetail();
        this.type = indoorStepNode.getType();
    }
}
