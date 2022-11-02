package com.baidu.mapapi.search.bean.option.route;

import com.baidu.mapapi.search.route.TransitRoutePlanOption;
import com.baidu.mapapi.search.route.TransitRoutePlanOption.TransitPolicy;

/**
 * 基础公交检索属性
 */
public class TransitRoutePlanOptionBean extends BaseRoutePlanOptionBean {

    /** 公交策略 */
    enum BMFTransitPolicy {
        /** 较快捷(公交) */
        TIME_FIRST,

        /** 少换乘(公交) */
        TRANSFER_FIRST,

        /** 少步行(公交) */
        WALK_FIRST,

        /** 不坐地铁 */
        NO_SUBWAY,
    }

    /** 城市名，用于在哪个城市内进行检索 */
    String city;

    /** 公交检索策略 */
    int transitPolicy;

    public TransitRoutePlanOption toOption(){
        TransitRoutePlanOption transitRoutePlanOption = new TransitRoutePlanOption();
        transitRoutePlanOption.mCityName = city;
        transitRoutePlanOption.mFrom = null != from ? from.toPlanNode():null;
        transitRoutePlanOption.mTo = null != to ? to.toPlanNode():null;

        if (transitPolicy >= 0 && transitPolicy < TransitPolicy.values().length) {
            transitRoutePlanOption.mPolicy =
                    TransitRoutePlanOption.TransitPolicy.values()[transitPolicy];
        }

        return transitRoutePlanOption;
    }
}
