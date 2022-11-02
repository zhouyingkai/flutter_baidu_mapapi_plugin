package com.baidu.mapapi.search.bean.result;

import com.baidu.mapapi.model.LatLng;
import com.baidu.mapapi.search.district.DistrictResult;

import java.util.List;

/**
 * 街区检索结果bean
 */
public class DisrictResultBean extends ResultBean{
    /** 中心点 */
    public LatLng center;

    /** 行政区域编码 */
    public int code;

    /** 行政区边界坐标点数据 */
    List<List<LatLng>> paths;

    /** 行政区域名称 */
    String name;

    public DisrictResultBean(DistrictResult districtResult){
        if(null == districtResult){
            return;
        }

        this.center = districtResult.centerPt;
        this.code = districtResult.cityCode;
        this.name = districtResult.cityName;
        this.paths = districtResult.polylines;
        this.error = districtResult.error;
    }
}
