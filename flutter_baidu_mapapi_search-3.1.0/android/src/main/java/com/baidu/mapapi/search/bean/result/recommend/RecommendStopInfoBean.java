package com.baidu.mapapi.search.bean.result.recommend;

import com.baidu.mapapi.model.LatLng;
import com.baidu.mapapi.search.core.RecommendStopInfo;

public class RecommendStopInfoBean {

    /**
     * 推荐上车点名称
     */
    public String name;

    /**
     * 该推荐上车点对应的经纬度坐标
     */
    public LatLng location;

    /**
     * 该推荐上车点距离查找点的距离
     */
    public float distance;

    /**
     * 该推荐上车点的poi的uid
     */
    public String uid;

    /**
     * 该推荐上车点对应的详细地址信息
     */
    public String address;


    public RecommendStopInfoBean(RecommendStopInfo recommendStopInfo) {
        if (recommendStopInfo == null) {
            return;
        }
        this.name = recommendStopInfo.getName();
        this.location = recommendStopInfo.getLocation();
        this.distance = recommendStopInfo.getDistance();
        this.uid = recommendStopInfo.getId();
        this.address = recommendStopInfo.getAddress();
    }
}
