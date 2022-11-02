package com.baidu.mapapi.search.bean.result.route.ridingrouteresult;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.baidu.mapapi.search.bean.result.route.BMFRouteLine;
import com.baidu.mapapi.search.route.BikingRouteLine;

/**
 * 此类表示一条骑行路
 */
public class BMFRidingRouteLine extends BMFRouteLine {
    /**
     * 路线中的所有路段
     */
    List<BMFRidingStep> steps = new ArrayList<>();

    public BMFRidingRouteLine(BikingRouteLine bikingRouteLine) {
        super(bikingRouteLine);
        if (null == bikingRouteLine) {
            return;
        }

        List<BikingRouteLine.BikingStep> allSteps = bikingRouteLine.getAllStep();
        if (null == allSteps || allSteps.size() <= 0) {
            return;
        }

        Iterator itr = allSteps.iterator();
        while (itr.hasNext()) {
            BikingRouteLine.BikingStep bikingStep = (BikingRouteLine.BikingStep) itr.next();
            if (null == bikingStep) {
                continue;
            }

            BMFRidingStep bmfRidingStep = new BMFRidingStep(bikingStep);
            steps.add(bmfRidingStep);
        }
    }
}
