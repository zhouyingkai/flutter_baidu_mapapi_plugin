package com.baidu.mapapi.search.bean.result.route;

import com.baidu.mapapi.model.LatLng;
import com.baidu.mapapi.search.core.RouteNode;

/**
 * 此类表示路线中的一节点，节点包括：路线起终点，公交站点
 */
public class BMFRouteNode {
    /** 该节点uid */
    String uid;

    /** 该节点的名称 */
    String title;

    /** 该节点的坐标 */
    LatLng location;

    public BMFRouteNode(RouteNode routeNode){
        if(null == routeNode){
            return;
        }

        this.uid = routeNode.getUid();
        this.location = routeNode.getLocation();
        this.title = routeNode.getTitle();
    }
}
