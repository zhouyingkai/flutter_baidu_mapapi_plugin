package com.baidu.mapapi.search.bean.result.route.indoorroute;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.baidu.mapapi.search.bean.result.ResultBean;
import com.baidu.mapapi.search.route.IndoorRouteLine;
import com.baidu.mapapi.search.route.IndoorRouteResult;

/**
 * 室内路线规划结果
 */
public class BMFIndoorRouteResult extends ResultBean {
    /**
     * 方案数组,成员类型为BMFIndoorRouteLine
     */
    List<BMFIndoorRouteLine> routes = new ArrayList<>();

    public BMFIndoorRouteResult(IndoorRouteResult indoorRouteResult) {
        if (null == indoorRouteResult) {
            return;
        }

        this.error = indoorRouteResult.error;

        List<IndoorRouteLine> indoorRouteLines = indoorRouteResult.getRouteLines();
        if (null == indoorRouteLines || indoorRouteLines.size() <= 0) {
            return;
        }

        Iterator itr = indoorRouteLines.iterator();
        while (itr.hasNext()) {
            IndoorRouteLine indoorRouteLine = (IndoorRouteLine) itr.next();
            if (null == indoorRouteLine) {
                continue;
            }

            BMFIndoorRouteLine bmfIndoorRouteLine = new BMFIndoorRouteLine(indoorRouteLine);
            routes.add(bmfIndoorRouteLine);
        }
    }
}
