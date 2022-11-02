package com.baidu.mapapi.search.bean.result.building;

import com.baidu.mapapi.search.core.BuildingInfo;

public class BuildingInfoBean {

    /**
     * 高度
     */
    public double height;

    /**
     * 加密后的面
     */
    public String paths;

    /**
     * 加密后的中心点
     */
    public String center;

    /**
     * 准确度
     */
    public double accuracy;

    public BuildingInfoBean (BuildingInfo buildingInfo) {
        if (null == buildingInfo) {
            return;
        }

        this.height = buildingInfo.getHeight();
        this.paths = buildingInfo.getGeom();
        this.center = buildingInfo.getCenter();
        this.accuracy = buildingInfo.getAccuracy();
    }
}
