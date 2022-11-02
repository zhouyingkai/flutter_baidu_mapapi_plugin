package com.baidu.mapapi.search.bean.result.route.masstransirouteresult;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.baidu.mapapi.search.bean.result.route.BMFRouteLine;
import com.baidu.mapapi.search.core.PriceInfo;
import com.baidu.mapapi.search.route.MassTransitRouteLine;

/**
 * 此类表示一条公共交通路线
 */
public class BMFMassTransitRouteLine extends BMFRouteLine {

    /**
     * 路线中的所有路段
     */
    List<BMFMassTransitStep> steps = new ArrayList<>();

    /**
     * 路线花费
     */
    double price;

    List<PriceInfo> priceInfo;

    public BMFMassTransitRouteLine(MassTransitRouteLine massTransitRouteLine, boolean isSameCity) {
        super(massTransitRouteLine);
        this.price = massTransitRouteLine.getPrice();

        List<List<MassTransitRouteLine.TransitStep>> transitSteps =
                massTransitRouteLine.getNewSteps();

        if (null == transitSteps || transitSteps.size() <= 0) {
            return;
        }

        Iterator itr = transitSteps.iterator();
        while (itr.hasNext()) {
            List<MassTransitRouteLine.TransitStep> subSteps =
                    (List<MassTransitRouteLine.TransitStep>) itr.next();
            if (null == subSteps) {
                continue;
            }

            BMFMassTransitStep bmfMassTransitStep = new BMFMassTransitStep(subSteps, isSameCity);
            steps.add(bmfMassTransitStep);
        }

        priceInfo = massTransitRouteLine.getPriceInfo();
    }
}
