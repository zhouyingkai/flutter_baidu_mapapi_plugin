package com.baidu.mapapi.search.bean.option.route;

import com.baidu.mapapi.search.route.WalkingRoutePlanOption;

/**
 * 步骑行
 */
public class WalkingRoutePlanOptonBean extends BaseRoutePlanOptionBean{
    public WalkingRoutePlanOption toOption(){
        WalkingRoutePlanOption option = new WalkingRoutePlanOption();
        option.mFrom = null != from ? from.toPlanNode() : null;
        option.mTo = null != to ? to.toPlanNode() : null;
        return option;
    }
}
