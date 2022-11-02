package com.baidu.mapapi.search.bean.option.route;

import com.baidu.mapapi.search.route.BikingRoutePlanOption;

/**
 * 骑行检索属性
 */
public class BikingRoutePlanOptionBean extends BaseRoutePlanOptionBean{
    /** 骑行类型 */
    int ridingType;

    public BikingRoutePlanOption toOption(){
        BikingRoutePlanOption bikingRoutePlanOption = new BikingRoutePlanOption();
        bikingRoutePlanOption.mFrom = null != from ? from.toPlanNode() : null;
        bikingRoutePlanOption.mTo = null != to ? to.toPlanNode() : null;
        bikingRoutePlanOption.mRidingType = ridingType;
        return bikingRoutePlanOption;
    }
}
