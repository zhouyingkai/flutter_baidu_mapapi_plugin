package com.baidu.mapapi.search.bean.result;

import com.baidu.mapapi.model.LatLng;
import com.baidu.mapapi.search.poi.PoiIndoorInfo;

/**
 * 室内poi信息
 */
public class PoiIndoorInfoBean {
    /** POI名称 */
    public String name;

    /** POI唯一标识符 */
    public String uid;

    /** 该室内POI所在 室内ID */
    public String indoorID;

    /** 该室内POI所在楼层 */
    public String floor;

    /** POI地址 */
    public String address;

    /** POI所在城市 */
    public String city;

    /** POI电话号码 */
    public String phone;

    /** POI坐标 */
    public LatLng pt;

    /** POI标签 */
    public String tag;

    /** 价格 */
    public double price;

    /** 星级（0-50），50表示五星 */
    public int starLevel;

    /** 是否有团购 */
    public boolean grouponFlag;

    /** 是否有外卖 */
    public boolean takeoutFlag;

    /** 是否排队 */
    public boolean waitedFlag;

    /** 团购数,-1表示没有团购信息 */
    public int grouponNum;

    /** 折扣信息FIXME */
    public int discount;

    public PoiIndoorInfoBean(PoiIndoorInfo poiIndoorInfo){
        if(null == poiIndoorInfo){
            return;
        }

        this.address = poiIndoorInfo.address;
        this.city = String.valueOf(poiIndoorInfo.cid);
        this.discount = poiIndoorInfo.discount;
        this.floor = poiIndoorInfo.floor;
        this.grouponFlag = poiIndoorInfo.isGroup;
        this.grouponNum = poiIndoorInfo.groupNum;
        this.indoorID = poiIndoorInfo.bid;
        this.name = poiIndoorInfo.name;
        this.phone = poiIndoorInfo.phone;
        this.price = poiIndoorInfo.price;
        this.pt = poiIndoorInfo.latLng;
        this.starLevel = poiIndoorInfo.starLevel;
        this.tag = poiIndoorInfo.tag;
        this.takeoutFlag = poiIndoorInfo.isTakeOut;
        this.waitedFlag = poiIndoorInfo.isWaited;
        this.uid = poiIndoorInfo.uid;
    }
}
