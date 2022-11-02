package com.baidu.mapapi.search.bean.option;

/**
 * 路径规划短串分享bean
 */
public class RoutePlanShareUrlOptionBean {
    /// 路线规划短串分享类型
    public int routePlanType;

    /** 起点，可通过关键字、坐标两种方式指定，使用关键字时必须指定from.cityID*/
    public PlanNodeBean from;

    /** 终点，可通过关键字、坐标两种方式指定，使用关键字时必须指定to.cityID */
    public PlanNodeBean to;

    /** cityID，当进行公交路线规划短串分享且起终点通过关键字指定时，必须指定 */
    public int cityID;

    /** 公交路线规划短串分享时使用，分享的是第几条线路 */
    public int routeIndex;
}
