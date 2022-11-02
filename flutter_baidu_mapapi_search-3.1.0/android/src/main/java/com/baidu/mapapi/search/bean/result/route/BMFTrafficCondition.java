/*
 * Copyright (C) 2020 Baidu, Inc. All Rights Reserved.
 */
package com.baidu.mapapi.search.bean.result.route;

import static com.baidu.mapapi.search.route.MassTransitRouteLine.TransitStep.TrafficCondition;

/**
 * 路况
 */
public class BMFTrafficCondition {
    int trafficStatus;
    int trafficGeoCnt;

    public BMFTrafficCondition(TrafficCondition trafficCondition) {
        if (null == trafficCondition) {
            return;
        }

        this.trafficStatus = trafficCondition.getTrafficStatus();
        this.trafficGeoCnt = trafficCondition.getTrafficGeoCnt();
    }
}
