package com.baidu.mapapi.search.bean;

import com.baidu.mapapi.search.geocode.ReverseGeoCodeResult;

public class AddressComponentBean {
    /**
     * 门牌号码
     */
    public String streetNumber;

    /**
     * 街道名称（行政区划中的街道层级）
     */
    public String streetName;

    /**
     * 乡镇名称
     */
    public String town;

    /**
     * 区县名称
     */
    public String district;
    /**
     * 城市名称
     */
    public String city;

    /**
     * 省份名称
     */
    public String province;

    /**
     * 国家名称
     */
    public String country;

    /**
     * 国家号码
     */
    public String countryCode;

    /**
     * 行政区域编码
     */
    public String adCode;

    /**
     * 相对当前坐标点的方向，当有门牌号的时候返回数据
     */
    public String direction;

    /**
     * 相对当前坐标点的距离，当有门牌号的时候返回数据
     */
    public String distance;

    public AddressComponentBean(ReverseGeoCodeResult.AddressComponent addressComponent) {
        this.streetNumber = addressComponent.streetNumber;
        this.streetName = addressComponent.street;
        this.town = addressComponent.town;
        this.district = addressComponent.district;
        this.city = addressComponent.city;
        this.province = addressComponent.province;
        this.country = addressComponent.countryName;
        this.countryCode = String.valueOf(addressComponent.countryCode);
        this.adCode = String.valueOf(addressComponent.adcode);
        this.direction = addressComponent.direction;
        this.distance = addressComponent.distance;
    }
}
