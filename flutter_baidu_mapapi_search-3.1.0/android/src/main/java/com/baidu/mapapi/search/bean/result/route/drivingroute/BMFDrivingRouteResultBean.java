package com.baidu.mapapi.search.bean.result.route.drivingroute;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.baidu.mapapi.search.bean.result.ResultBean;
import com.baidu.mapapi.search.bean.result.route.BMFSuggestionAddrInfo;
import com.baidu.mapapi.search.bean.result.route.BMFTaxiInfo;
import com.baidu.mapapi.search.core.TaxiInfo;
import com.baidu.mapapi.search.route.DrivingRouteLine;
import com.baidu.mapapi.search.route.DrivingRouteResult;

/**
 * 驾车路线检索结果
 */
public class BMFDrivingRouteResultBean extends ResultBean {
    /**
     * 返回起点或终点的地址信息结果
     */
    BMFSuggestionAddrInfo suggestAddrResult;

    /**
     * 驾车结果,支持多路线。成员类型为BMFDrivingRouteLine
     */
    List<BMFDrivingRouteLine> routes = new ArrayList<>();

    /**
     * 费用
     */
    private List<BMFTaxiInfo> taxiInfos = new ArrayList<>();


    public BMFDrivingRouteResultBean(DrivingRouteResult drivingRouteResult) {
        if (null == drivingRouteResult) {
            return;
        }

        this.suggestAddrResult = new BMFSuggestionAddrInfo(drivingRouteResult.getSuggestAddrInfo());
        this.error = drivingRouteResult.error;

        List<DrivingRouteLine> routeLines = drivingRouteResult.getRouteLines();
        if (null == routeLines || routeLines.size() <= 0) {
            return;
        }

        Iterator itr = routeLines.iterator();
        while (itr.hasNext()) {
            DrivingRouteLine drivingRouteLine = (DrivingRouteLine) itr.next();
            if (null == drivingRouteLine) {
                continue;
            }

            BMFDrivingRouteLine bmfDrivingRouteLine = new BMFDrivingRouteLine(drivingRouteLine);
            routes.add(bmfDrivingRouteLine);
        }

        List<TaxiInfo> taxiInfos = drivingRouteResult.getTaxiInfos();
        if (null == taxiInfos || taxiInfos.size() <= 0) {
            return;
        }

        itr = taxiInfos.iterator();
        while (itr.hasNext()) {
            TaxiInfo taxiInfo = (TaxiInfo) itr.next();
            if (null == taxiInfo) {
                continue;
            }

            BMFTaxiInfo bmfTaxiInfo = new BMFTaxiInfo(taxiInfo);
            this.taxiInfos.add(bmfTaxiInfo);
        }
    }
}
