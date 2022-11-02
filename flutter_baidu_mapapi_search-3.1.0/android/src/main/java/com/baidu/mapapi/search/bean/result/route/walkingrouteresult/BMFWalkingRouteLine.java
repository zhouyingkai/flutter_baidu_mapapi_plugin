package com.baidu.mapapi.search.bean.result.route.walkingrouteresult;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.baidu.mapapi.search.bean.result.route.BMFRouteLine;
import com.baidu.mapapi.search.route.WalkingRouteLine;
import com.baidu.mapapi.search.route.WalkingRouteLine.WalkingStep;

/**
 * 此类表示一条步行路线
 */
public class BMFWalkingRouteLine extends BMFRouteLine {

    /**
     * 路线中的所有路
     */
    List<BMFWalkingStep> steps = new ArrayList<>();

    public BMFWalkingRouteLine(WalkingRouteLine walkingRouteLine) {
        super(walkingRouteLine);
        if (null == walkingRouteLine) {
            return;
        }
        List<WalkingStep> walkingSteps = walkingRouteLine.getAllStep();
        if (null == walkingSteps || walkingSteps.size() <= 0) {
            return;
        }

        Iterator iterator = walkingSteps.iterator();
        while (iterator.hasNext()) {
            WalkingStep walkingStep = (WalkingStep) iterator.next();
            BMFWalkingStep bmfWalkingStep = new BMFWalkingStep(walkingStep);
            steps.add(bmfWalkingStep);
        }
    }
}
