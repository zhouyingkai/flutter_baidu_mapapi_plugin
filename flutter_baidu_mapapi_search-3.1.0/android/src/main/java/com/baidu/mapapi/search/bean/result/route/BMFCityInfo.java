package com.baidu.mapapi.search.bean.result.route;

import com.baidu.mapapi.search.core.CityInfo;
import com.baidu.mapapi.search.core.PoiInfo;

/**
 * 城市列表信息
 */
public class BMFCityInfo {
    /** 城市名称 */
    String city;

    /** 该城市所含搜索结果数目 */
    int count;

    public BMFCityInfo(CityInfo cityInfo){
        this.city = cityInfo.city;
        this.count = cityInfo.num;
    }

    public BMFCityInfo(PoiInfo poiInfo) {
        this.city = poiInfo.city;
        this.count = 1;
    }
}
