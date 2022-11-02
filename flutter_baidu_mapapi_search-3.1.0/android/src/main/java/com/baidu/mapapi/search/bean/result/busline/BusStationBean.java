package com.baidu.mapapi.search.bean.result.busline;

import com.baidu.mapapi.model.LatLng;
import com.baidu.mapapi.search.busline.BusLineResult;

/**
 * 公交站bean
 */
public class BusStationBean {
    /**
     * 该节点uid
     */
    public String uid;

    /**
     * 该节点的名称
     */
    public String title;

    /**
     * 该节点的坐标
     */
    public LatLng location;

    public BusStationBean(BusLineResult.BusStation busStation) {
        if (null == busStation) {
            return;
        }

        this.uid = busStation.getUid();
        this.title = busStation.getTitle();
        this.location = busStation.getLocation();
    }
}
