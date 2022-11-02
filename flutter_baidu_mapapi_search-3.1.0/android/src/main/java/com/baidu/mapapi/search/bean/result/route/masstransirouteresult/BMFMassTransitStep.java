package com.baidu.mapapi.search.bean.result.route.masstransirouteresult;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.baidu.mapapi.search.route.MassTransitRouteLine;

/**
 * 此类表示公共交通路线中的路
 */
public class BMFMassTransitStep {
    /**
     * steps中是方案还是子路段
     * ture:steps是BMFMassTransitStep的子路段（A到B需要经过多个steps）;
     * false:steps是多个方案（A到B有多个方案选择）
     */
    boolean isSubStep = true;

    /**
     * 本BMFMassTransitStep中的有几个方案或几个子路段，成员类型为BMFMassTransitSubStep
     */
    List<BMFMassTransitSubStep> steps = new ArrayList<>();

    public BMFMassTransitStep(List<MassTransitRouteLine.TransitStep> transitSteps,
                              boolean  isSameCity) {
        if (null == transitSteps || transitSteps.size() <= 0) {
            return;
        }

        // 同城时候，steps是多个方案
        // 不同城时，steps是多个子路段
        isSubStep = !isSameCity;

        Iterator itr = transitSteps.iterator();
        while (itr.hasNext()) {
            MassTransitRouteLine.TransitStep transitStep =
                    (MassTransitRouteLine.TransitStep) itr.next();
            BMFMassTransitSubStep bmfMassTransitSubStep = new BMFMassTransitSubStep(transitStep);
            steps.add(bmfMassTransitSubStep);
        }
    }
}
