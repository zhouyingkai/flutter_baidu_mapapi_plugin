package com.baidu.mapapi.search.bean.result.building;

import com.baidu.mapapi.search.bean.result.ResultBean;
import com.baidu.mapapi.search.building.BuildingResult;
import com.baidu.mapapi.search.core.BuildingInfo;

import java.util.ArrayList;
import java.util.List;

public class BuildingResultBean extends ResultBean {

    /**
     * 地图建筑物列表
     */
    public List<BuildingInfoBean> buildingList = new ArrayList<>();

    public BuildingResultBean(BuildingResult buildingResult) {
        List<BuildingInfo> tmpBuildingList = buildingResult.getBuildingList();
        if (null != tmpBuildingList && tmpBuildingList.size() > 0) {
            for (BuildingInfo buildingInfo : tmpBuildingList) {
                this.buildingList.add(new BuildingInfoBean(buildingInfo));
            }
        }
        this.error = buildingResult.error;
    }
}
