package com.baidu.mapapi.search.bean.result.weather;

import com.baidu.mapapi.search.weather.WeatherSearchLocation;

/**
 * 地理位置信息
 */
public class WeatherSearchLocationBean {

    /**
     * 国家名称
     */
    private String country;

    /**
     * 省份名称
     */
    private String province;

    /**
     * 城市名称
     */
    private String city;

    /**
     * 区县名称
     */
    private String districtName;

    /**
     * 区县id
     */
    private String districtID;

    public WeatherSearchLocationBean(WeatherSearchLocation locationBean) {
        if (locationBean == null) {
            return;
        }
        this.country = locationBean.getCountry();
        this.province = locationBean.getProvince();
        this.city = locationBean.getCity();
        this.districtName = locationBean.getDistrictName();
        this.districtID = locationBean.getDistrictID();
    }
}
