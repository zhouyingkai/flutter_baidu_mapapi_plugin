package com.baidu.mapapi.search.bean.option.route;

import com.baidu.mapapi.search.route.IndoorRoutePlanOption;
import com.baidu.mapapi.search.route.PlanNode;

public class IndoorRoutePlanOptionBean {
    BMFIndoorPlanNode from;
    BMFIndoorPlanNode to;

    public IndoorRoutePlanOption toOption(){
        IndoorRoutePlanOption indoorRoutePlanOption = new IndoorRoutePlanOption();
        indoorRoutePlanOption.mFrom = null != from ? from.toIndoorPlanNode():null;
        indoorRoutePlanOption.mTo = null != to ? to.toIndoorPlanNode(): null;
        return indoorRoutePlanOption;
    }
}
