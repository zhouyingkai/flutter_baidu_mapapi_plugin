package com.baidu.mapapi.search.bean.result.route.walkingrouteresult;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.baidu.mapapi.search.bean.result.ResultBean;
import com.baidu.mapapi.search.bean.result.route.BMFSuggestionAddrInfo;
import com.baidu.mapapi.search.bean.result.route.BMFTaxiInfo;
import com.baidu.mapapi.search.route.WalkingRouteLine;
import com.baidu.mapapi.search.route.WalkingRouteResult;

/**
 * 步行检索结果
 */
public class WalkingRouteReusltBean extends ResultBean {

    /**
     * 返回起点或终点的地址信息结果
     */
    BMFSuggestionAddrInfo suggestAddrResult;

    /**
     * 步行结果,现在只返回一条。成员类型为BMFWalkingRouteLine
     */
    List<BMFWalkingRouteLine> routes = new ArrayList<>();

    /**
     * 费用
     */
    BMFTaxiInfo taxiInfo;

    public WalkingRouteReusltBean(WalkingRouteResult walkingRouteResult) {
        if (null == walkingRouteResult) {
            return;
        }
        this.suggestAddrResult = new BMFSuggestionAddrInfo(walkingRouteResult.getSuggestAddrInfo());
        setRoutes(walkingRouteResult.getRouteLines());
        this.error = walkingRouteResult.error;
        this.taxiInfo = new BMFTaxiInfo(walkingRouteResult.getTaxiInfo());
    }

    private void setRoutes(List<WalkingRouteLine> walkingRouteLines) {
        if (null == walkingRouteLines || walkingRouteLines.size() <= 0) {
            return;
        }
        Iterator iterator = walkingRouteLines.iterator();
        while (iterator.hasNext()) {
            WalkingRouteLine walkingRouteLine = (WalkingRouteLine) iterator.next();
            if (null == walkingRouteLine) {
                continue;
            }
            BMFWalkingRouteLine bmfWalkingRouteLine = new BMFWalkingRouteLine(walkingRouteLine);
            routes.add(bmfWalkingRouteLine);
        }
    }
}
