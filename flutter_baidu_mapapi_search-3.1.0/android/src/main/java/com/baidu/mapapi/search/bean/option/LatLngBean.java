package com.baidu.mapapi.search.bean.option;

import com.baidu.mapapi.model.LatLng;

public class LatLngBean {
    /**
     * 纬度
     */
    private double latitude;

    /**
     * 经度
     */
    private double longitude;

    public LatLngBean(double latitude, double longitude) {
        this.latitude = latitude;
        this.longitude = longitude;
    }

    public LatLngBean(LatLng latLng) {
        if (null  == latLng) {
            return;
        }

        this.latitude = latLng.latitude;
        this.longitude =  latLng.longitude;
    }
}
