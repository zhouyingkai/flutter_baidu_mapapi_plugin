package com.baidu.mapapi.search.bean.option.route;

import com.baidu.mapapi.search.route.MassTransitRoutePlanOption;
import com.baidu.mapapi.search.route.MassTransitRoutePlanOption.TacticsIncity;
import com.baidu.mapapi.search.route.MassTransitRoutePlanOption.TacticsIntercity;
import com.baidu.mapapi.search.route.MassTransitRoutePlanOption.TransTypeIntercity;

/**
 * 公共交通路线查询基础信息类（支持市内和跨城）(注：起终点城市不支持cityId)
 */
public class MassTransitRoutePlanOptionBean extends BaseRoutePlanOptionBean{

    /** 公共交通：市内公交换乘策略 */
    enum BMFMassTransitIncityPolicy {
        /** 推荐 */
        RECOMMEND,

        /** 少换乘 */
        TRANSFER_FIRST,

        /** 少步行 */
        WALK_FIRST,

        /** 不坐地铁 */
        NO_SUBWAY,

        /** 较快捷 */
        TIME_FIRST,

        /** 地铁优先 */
        SUBWAY_FIRST,
    }

    /** 公共交通：跨城公交换乘策略 */
    enum BMFMassTransitIntercityPolicy {
        /** 较快捷 */
        TIME_FIRST,

        /** 出发早 */
        START_EARLY,

        /** 价格低 */
        PRICE_FIRST,
    }

    /** 公共交通：跨城交通方式策略 */
    enum BMFMassTransitIntercityTransPolicy {
        /** 火车优先 */
        TRAIN_FIRST,

        /** 飞机优先 */
        PLANE_FIRST,

        /** 大巴优先 */
        BUS_FIRST,
    }

    /**
     * 分页索引，可选，
     * 默认为0(从0开始)
     */
    int pageIndex;

    /**
     * 分页数量，可选，
     * 默认为10，取值范围 1~10
     */
    int pageCapacity;

    /**
     * 市内公交换乘策略策略，可选，
     * 默认使用BMFMassTransitIncityPolicy.RECOMMEND
     */
    int incityPolicy;

    /**
     * 跨城公交换乘策略，可选，
     * 默认使用BMFMassTransitIntercityPolicy.TIME_FIRST
     */
    int intercityPolicy;

    /**
     * 跨城交通方式策略，可选，
     * 默认使用BMK_MASS_TRANSIT_INTERCITY_TRANS_TRAIN_FIRST
     */
    int intercityTransPolicy;

    public MassTransitRoutePlanOption toOption(){
        MassTransitRoutePlanOption massTransitRoutePlanOption = new MassTransitRoutePlanOption();


        massTransitRoutePlanOption.mFrom = null != from ? from.toPlanNode():null;
        massTransitRoutePlanOption.mTo = null != to? to.toPlanNode():null;
        massTransitRoutePlanOption.pageIndex(pageIndex);
        massTransitRoutePlanOption.pageSize(pageCapacity);
        if (incityPolicy >= 0 && incityPolicy < TacticsIncity.values().length) {
            massTransitRoutePlanOption.mTacticsIncity = TacticsIncity.values()[incityPolicy];
        }

        if (intercityPolicy >= 0 && intercityPolicy <  TacticsIntercity.values().length) {
            massTransitRoutePlanOption.mTacticsIntercity = TacticsIntercity.values()[intercityPolicy];
        }

        if (intercityTransPolicy >= 0 && intercityTransPolicy < TransTypeIntercity.values().length) {
            massTransitRoutePlanOption.mTransTypeIntercity = TransTypeIntercity.values()[intercityTransPolicy];
        }

        return  massTransitRoutePlanOption;
    }
}
