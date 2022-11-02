package com.baidu.mapapi.search.bean.option.route;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.baidu.mapapi.search.route.DrivingRoutePlanOption;
import com.baidu.mapapi.search.route.DrivingRoutePlanOption.DrivingTrafficPolicy;
import com.baidu.mapapi.search.route.DrivingRoutePlanOption.DrivingPolicy;
import com.baidu.mapapi.search.route.PlanNode;

/**
 * 驾驶路线检索属性
 */
public class DrivingRoutePlanOptionBean extends BaseRoutePlanOptionBean{

    /** 驾车策略 */
    enum BMFDrivingPolicy {
        /** 躲避拥堵(自驾) */
        BLK_FIRST,

        /** 最短时间(自驾) */
        TIME_FIRST,

        /** 最短路程(自驾) */
        DIS_FIRST,

        /** 少走高速(自驾) */
        FEE_FIRST,
    }

    enum BMFDrivingRequestTrafficType {
        /** 不带路况 */
        NONE,

        /** 道路和路况 */
        PATH_AND_TRAFFICE,
    }

    /**
     * 驾车途径点
     */
    List<BMFRoutePlanNode> wayPointsArray;

    /**
     * 驾车策略
     */
    int drivingPolicy;

    /**
     * 路况类型
     */
    int drivingRequestTrafficType;

    public DrivingRoutePlanOption toOption(){
        DrivingRoutePlanOption drivingRoutePlanOption = new DrivingRoutePlanOption();
        drivingRoutePlanOption.mCityName = null != from ? from.cityName : "";
        drivingRoutePlanOption.mPolicy = policyConvert();

        if (drivingRequestTrafficType >= 0 && drivingRequestTrafficType < DrivingTrafficPolicy.values().length) {
            drivingRoutePlanOption.mtrafficPolicy = DrivingTrafficPolicy.values()[drivingRequestTrafficType];
        }
        drivingRoutePlanOption.mWayPoints = wayPointsConvert();
        drivingRoutePlanOption.mFrom = null != from ? from.toPlanNode():null;
        drivingRoutePlanOption.mTo = null != to ? to.toPlanNode():null;

        return drivingRoutePlanOption;
    }

    private DrivingRoutePlanOption.DrivingPolicy policyConvert(){
        DrivingPolicy tmpDrivingPolicy = DrivingPolicy.ECAR_TIME_FIRST;
        if ( drivingPolicy < 0 || drivingPolicy > BMFDrivingPolicy.values().length) {
            return tmpDrivingPolicy;
        }

        BMFDrivingPolicy bmfDrivingPolicy  = BMFDrivingPolicy.values()[drivingPolicy];

        switch (bmfDrivingPolicy) {
            case BLK_FIRST:
                tmpDrivingPolicy = DrivingPolicy.ECAR_AVOID_JAM;
                break;
            case TIME_FIRST:
                tmpDrivingPolicy = DrivingPolicy.ECAR_TIME_FIRST;
                break;
            case DIS_FIRST:
                tmpDrivingPolicy = DrivingPolicy.ECAR_DIS_FIRST;
                break;
            case FEE_FIRST:
                tmpDrivingPolicy = DrivingPolicy.ECAR_FEE_FIRST;
                break;
            default:
                break;
        }

        return tmpDrivingPolicy;
    }

    private List<PlanNode> wayPointsConvert(){
        if(null == wayPointsArray){
            return null;
        }

        List<PlanNode> wayPoints = new ArrayList<>();
        Iterator itr = wayPointsArray.listIterator();

        BMFRoutePlanNode bmfRoutePlanNode;
        while (itr.hasNext()){
            bmfRoutePlanNode = (BMFRoutePlanNode) itr.next();
            PlanNode planNode = bmfRoutePlanNode.toPlanNode();
            wayPoints.add(planNode);
        }

        return wayPoints;
    }
}
