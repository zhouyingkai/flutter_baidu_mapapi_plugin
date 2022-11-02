package com.baidu.mapapi.search.bean;

import com.baidu.mapapi.search.geocode.ReverseGeoCodeResult;

public class PoiRegionsInfoBean {
    /**
     * 请求中的坐标与所归属区域面的相对位置关系
     */
    public String regionDescription;

    /**
     * 归属区域面名称
     */
    public String regionName;

    /**
     * 归属区域面类型
     */
    public String regionTag;

    public PoiRegionsInfoBean(ReverseGeoCodeResult.PoiRegionsInfo poiRegionsInfo) {
        this.regionDescription = poiRegionsInfo.directionDesc;
        this.regionName =  poiRegionsInfo.regionName;
        this.regionTag =  poiRegionsInfo.regionTag;
    }
}
