package com.baidu.mapapi.search.bean.result.route.transirouteresult;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.baidu.mapapi.search.bean.result.route.BMFRouteLine;
import com.baidu.mapapi.search.route.TransitRouteLine;
import com.baidu.mapapi.search.route.TransitRouteLine.TransitStep;

/**
 * 此类表示一个换乘路线，换乘路线将根据既定策略调配多种交通工
 */
public class BMFTransitRouteLine extends BMFRouteLine {
    /**
     * 路线中的所有路段
     */
    List<BMFTransitStep> steps = new ArrayList<>();

    // To Do 缺少属性

    public BMFTransitRouteLine(TransitRouteLine transitRouteLine) {
        super(transitRouteLine);
        if (null == transitRouteLine) {
            return;
        }

        List<TransitStep> transitSteps = transitRouteLine.getAllStep();
        if (null == transitSteps || transitSteps.size() <= 0) {
            return;
        }

        Iterator itr = transitSteps.iterator();
        while (itr.hasNext()) {
            TransitStep transitStep = (TransitStep) itr.next();
            BMFTransitStep bmfTransitStep = new BMFTransitStep(transitStep);
            steps.add(bmfTransitStep);
        }
    }
}
