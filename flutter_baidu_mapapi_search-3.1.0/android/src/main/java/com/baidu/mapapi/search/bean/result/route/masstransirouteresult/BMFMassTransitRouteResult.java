package com.baidu.mapapi.search.bean.result.route.masstransirouteresult;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.baidu.mapapi.search.bean.option.route.BMFRoutePlanNode;
import com.baidu.mapapi.search.bean.result.ResultBean;
import com.baidu.mapapi.search.bean.result.route.BMFSuggestionAddrInfo;
import com.baidu.mapapi.search.bean.result.route.BMFTaxiInfo;
import com.baidu.mapapi.search.bean.result.route.BMFTransitResultNode;
import com.baidu.mapapi.search.route.MassTransitRouteLine;
import com.baidu.mapapi.search.route.MassTransitRouteResult;

/**
 * 跨城路线规划结果
 */
public class BMFMassTransitRouteResult extends ResultBean {
    /**
     * 返回起点或终点的地址信息结果
     */
    public BMFSuggestionAddrInfo suggestAddrResult;

    /**
     * 方案数组,成员类型为BMKMassTransitRouteLine
     */
    public List<BMFMassTransitRouteLine> routes = new ArrayList<>();

    /**
     * 总方案数
     */
    public int totalRoutes;

    /**
     * 该路线打车信息(只有起终点是大陆地区且是同城的请求时才返回此字段, 否则此字段为nil)
     */
    BMFTaxiInfo taxiInfo;

    /**
     * 起点
     */
    BMFRoutePlanNode origin;

    /**
     * 终点
     */
    BMFRoutePlanNode destination;

    public BMFMassTransitRouteResult(MassTransitRouteResult massTransitRouteResult) {
        if (null == massTransitRouteResult) {
            return;
        }

        this.suggestAddrResult =
                new BMFSuggestionAddrInfo(massTransitRouteResult.getSuggestAddrInfo());

        this.totalRoutes = massTransitRouteResult.getTotal();
        this.taxiInfo = new BMFTaxiInfo(massTransitRouteResult.getTaxiInfo());
        this.error = massTransitRouteResult.error;
        this.origin = new BMFRoutePlanNode(massTransitRouteResult.getOrigin());
        this.destination = new BMFRoutePlanNode(massTransitRouteResult.getDestination());
        boolean isSameCity = false;
        if (null != this.origin && null != this.destination) {
            if (this.origin.cityID == this.destination.cityID) {
                isSameCity = true;
            }
        }

        List<MassTransitRouteLine> routeLines = massTransitRouteResult.getRouteLines();
        if (null != routeLines && routeLines.size() > 0) {
            Iterator itr = routeLines.iterator();
            while (itr.hasNext()) {
                MassTransitRouteLine massTransitRouteLine = (MassTransitRouteLine) itr.next();

                if (null == massTransitRouteLine) {
                    continue;
                }

                BMFMassTransitRouteLine bmfMassTransitRouteLine =
                        new BMFMassTransitRouteLine(massTransitRouteLine, isSameCity);
                routes.add(bmfMassTransitRouteLine);
            }
        }
    }
}
