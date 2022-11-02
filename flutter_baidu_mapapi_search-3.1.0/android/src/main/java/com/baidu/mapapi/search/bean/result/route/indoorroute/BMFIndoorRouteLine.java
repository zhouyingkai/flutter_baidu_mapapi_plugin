package com.baidu.mapapi.search.bean.result.route.indoorroute;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.baidu.mapapi.search.bean.result.route.BMFRouteLine;
import com.baidu.mapapi.search.route.IndoorRouteLine;

/**
 * 表示一个室内路
 */
public class BMFIndoorRouteLine extends BMFRouteLine {
    /**
     * 路线中的所有路段
     */
    List<BMFIndoorRouteStep> steps = new ArrayList<>();

    public BMFIndoorRouteLine(IndoorRouteLine indoorRouteLine) {
        super(indoorRouteLine);
        if (null == indoorRouteLine) {
            return;
        }

        List<IndoorRouteLine.IndoorRouteStep> indoorRouteSteps = indoorRouteLine.getAllStep();
        if (null == indoorRouteSteps || indoorRouteSteps.size() <= 0) {
            return;
        }

        Iterator itr = indoorRouteSteps.iterator();
        while (itr.hasNext()) {
            IndoorRouteLine.IndoorRouteStep indoorRouteStep =
                    (IndoorRouteLine.IndoorRouteStep) itr.next();
            if (null == indoorRouteStep) {
                continue;
            }

            BMFIndoorRouteStep bmfIndoorRouteStep = new BMFIndoorRouteStep(indoorRouteStep);
            steps.add(bmfIndoorRouteStep);
        }
    }
}
