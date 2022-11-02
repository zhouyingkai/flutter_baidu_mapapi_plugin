package com.baidu.mapapi.search.bean.result.route.drivingroute;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.baidu.mapapi.search.bean.option.route.BMFRoutePlanNode;
import com.baidu.mapapi.search.bean.result.route.BMFRouteLine;
import com.baidu.mapapi.search.core.RouteNode;
import com.baidu.mapapi.search.route.DrivingRouteLine;

/**
 * 此类表示一条驾车路
 */
public class BMFDrivingRouteLine extends BMFRouteLine {
    // 路线中的所有路段
    List<BMFDrivingStep> steps = new ArrayList<>();

    // 路线途经点列表，成员类型为BMFPlanNode
    List<BMFRoutePlanNode> wayPoints = new ArrayList<>();

    // 路线红绿灯个数
    int lightNum;

    // 路线拥堵米数，发起请求时需设置参数 drivingRequestTrafficType = BMF_DRIVING_REQUEST_TRAFFICE_TYPE_PATH_AND_TRAFFICE 才有值
    int congestionMetres;

    public BMFDrivingRouteLine(DrivingRouteLine drivingRouteLine) {
        super(drivingRouteLine);
        if (null == drivingRouteLine) {
            return;
        }

        this.lightNum = drivingRouteLine.getLightNum();
        this.congestionMetres = drivingRouteLine.getCongestionDistance();

        List<DrivingRouteLine.DrivingStep> drivingSteps = drivingRouteLine.getAllStep();
        if (null != drivingSteps && drivingSteps.size() > 0) {
            Iterator itr = drivingSteps.iterator();
            while (itr.hasNext()) {
                DrivingRouteLine.DrivingStep drivingStep =
                        (DrivingRouteLine.DrivingStep) itr.next();
                if (null == drivingStep) {
                    continue;
                }

                BMFDrivingStep bmfDrivingStep = new BMFDrivingStep(drivingStep);
                steps.add(bmfDrivingStep);
            }
        }

        List<RouteNode> routeNodes = drivingRouteLine.getWayPoints();
        if (null != routeNodes && routeNodes.size() > 0) {
            Iterator itr = routeNodes.iterator();
            while (itr.hasNext()) {
                RouteNode routeNode = (RouteNode) itr.next();
                if (null == routeNode) {
                    continue;
                }

                BMFRoutePlanNode bmfRouteNode = new BMFRoutePlanNode(routeNode);
                wayPoints.add(bmfRouteNode);
            }
        }
    }
}
