package com.baidu.mapapi.search.bean.result.route.ridingrouteresult;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.baidu.mapapi.search.bean.result.ResultBean;
import com.baidu.mapapi.search.bean.result.route.BMFSuggestionAddrInfo;
import com.baidu.mapapi.search.route.BikingRouteLine;
import com.baidu.mapapi.search.route.BikingRouteResult;

public class BMFRidingRouteResultBean extends ResultBean {
    /**
     * 返回起点或终点的地址信息结果
     */
    BMFSuggestionAddrInfo suggestAddrResult;

    /**
     * 骑行路线结果,成员类型为BMFRidingRouteLine
     */
    List<BMFRidingRouteLine> routes = new ArrayList<>();

    public BMFRidingRouteResultBean(BikingRouteResult bikingRouteResult) {
        if (null == bikingRouteResult) {
            return;
        }

        this.suggestAddrResult = new BMFSuggestionAddrInfo(bikingRouteResult.getSuggestAddrInfo());

        this.error = bikingRouteResult.error;

        List<BikingRouteLine> bikingRouteLines = bikingRouteResult.getRouteLines();
        if (null == bikingRouteLines || bikingRouteLines.size() <= 0) {
            return;
        }

        Iterator itr = bikingRouteLines.iterator();
        while (itr.hasNext()) {
            BikingRouteLine bikingRouteLine = (BikingRouteLine) itr.next();
            if (null == bikingRouteLine) {
                continue;
            }

            BMFRidingRouteLine bmfRidingRouteLine = new BMFRidingRouteLine(bikingRouteLine);
            routes.add(bmfRidingRouteLine);
        }
    }
}
