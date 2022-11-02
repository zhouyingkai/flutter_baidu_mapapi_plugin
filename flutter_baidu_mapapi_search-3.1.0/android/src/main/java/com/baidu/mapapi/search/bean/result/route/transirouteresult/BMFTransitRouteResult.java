package com.baidu.mapapi.search.bean.result.route.transirouteresult;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.baidu.mapapi.search.bean.result.ResultBean;
import com.baidu.mapapi.search.bean.result.route.BMFSuggestionAddrInfo;
import com.baidu.mapapi.search.bean.result.route.BMFTaxiInfo;
import com.baidu.mapapi.search.route.TransitRouteLine;
import com.baidu.mapapi.search.route.TransitRouteResult;

/**
 * 公交路线规划结果
 */
public class BMFTransitRouteResult extends ResultBean {

    /**
     * 该路线打车信
     */
    BMFTaxiInfo taxiInfo;

    /**
     * 返回起点或终点的地址信息结
     */
    BMFSuggestionAddrInfo suggestAddrResult;

    /**
     * 方案数组,成员类型为BMFTransitRouteLine
     */
    List<BMFTransitRouteLine> routes = new ArrayList<>();

    public BMFTransitRouteResult(TransitRouteResult transitRouteResult) {
        if (null == transitRouteResult) {
            return;
        }

        this.taxiInfo = new BMFTaxiInfo(transitRouteResult.getTaxiInfo());

        this.suggestAddrResult = new BMFSuggestionAddrInfo(transitRouteResult.getSuggestAddrInfo());
        this.error = transitRouteResult.error;

        List<TransitRouteLine> transitRouteLines = transitRouteResult.getRouteLines();
        if (null == transitRouteLines || transitRouteLines.size() <= 0) {
            return;
        }

        Iterator iterator = transitRouteLines.iterator();
        while (iterator.hasNext()) {
            TransitRouteLine transitRouteLine = (TransitRouteLine) iterator.next();
            if (null == transitRouteLine) {
                continue;
            }

            BMFTransitRouteLine bmfTransitRouteLine = new BMFTransitRouteLine(transitRouteLine);
            routes.add(bmfTransitRouteLine);
        }
    }
}
