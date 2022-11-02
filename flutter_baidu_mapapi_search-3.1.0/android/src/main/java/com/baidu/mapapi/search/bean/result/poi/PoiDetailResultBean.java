/*
 * Copyright (C) 2020 Baidu, Inc. All Rights Reserved.
 */
package com.baidu.mapapi.search.bean.result.poi;

import com.baidu.mapapi.search.bean.option.LatLngBean;
import com.baidu.mapapi.search.bean.result.ResultBean;
import com.baidu.mapapi.search.core.PoiDetailInfo;
import com.baidu.mapapi.search.poi.PoiDetailResult;

public class PoiDetailResultBean extends ResultBean {
    /** POI名称 */
    public String name;

    /** POI坐标 */
    public LatLngBean pt;

    /** POI地址信息 */
    public String address;

    /** POI电话号码 */
    public String phone;

    /** POI唯一标识符uid */
    public String uid;

    /** POI所在省份 */
    public String province;

    /** POI所在城市 */
    public String city;

    /** POI所在行政区域 */
    public String area;

    /** POI对应的街景图ID */
    public String streetID;

    /** POI类别  注：逆地理编码检索会返回此值，其他检索可能返回为空，请参考detailInfo中的tag值。*/
    public String tag;

    /** POI是否有详情信息 */
    public boolean hasDetailInfo;

    /** POI详情信息 */
    PoiDetailDetailResultBean detailInfo;

    /** 和当前坐标点的方向，注：此字段只对逆地理检索有效 */
    String direction;

    /** 距离坐标点距离，注：此字段只对逆地理检索有效 */
    int distance;

    /** 邮编，注：此字段只对逆地理检索有效 */
    String zipCode;

    /** 该POI对应的父POI，注：此字段只对逆地理检索有效 */
    PoiDetailResultBean parentPOI;

    public PoiDetailResultBean(PoiDetailInfo poiDetailInfo) {
        if (null == poiDetailInfo) {
            return;
        }

        this.name = poiDetailInfo.getName();
        this.address = poiDetailInfo.getAddress();
        this.area = poiDetailInfo.getArea();
        this.distance = poiDetailInfo.getDistance();
        this.phone = poiDetailInfo.getTelephone();
        this.uid = poiDetailInfo.getUid();
        this.province = poiDetailInfo.getProvince();
        this.pt = new LatLngBean(poiDetailInfo.getLocation());
        this.city = poiDetailInfo.getCity();
        this.streetID = poiDetailInfo.getStreetId();
        this.tag = poiDetailInfo.getTag();
        this.detailInfo = new PoiDetailDetailResultBean(poiDetailInfo);
        this.hasDetailInfo = true;
    }

    public PoiDetailResultBean(PoiDetailResult poiDetailResult) {
        if (null == poiDetailResult) {
            return;
        }


        this.error = poiDetailResult.error;
        this.name = poiDetailResult.getName();
        this.address = poiDetailResult.getAddress();
        this.phone = poiDetailResult.getTelephone();
        this.pt = new LatLngBean(poiDetailResult.getLocation());
        this.uid = poiDetailResult.getUid();
        this.tag = poiDetailResult.getTag();
        this.detailInfo = new PoiDetailDetailResultBean(poiDetailResult);
        this.hasDetailInfo = true;

        this.detailInfo = new PoiDetailDetailResultBean(poiDetailResult);
    }
}
