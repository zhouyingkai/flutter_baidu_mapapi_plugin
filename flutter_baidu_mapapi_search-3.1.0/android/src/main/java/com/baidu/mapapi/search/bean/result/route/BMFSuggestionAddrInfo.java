package com.baidu.mapapi.search.bean.result.route;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.baidu.mapapi.search.bean.PoiInfoBean;
import com.baidu.mapapi.search.core.CityInfo;
import com.baidu.mapapi.search.core.PoiInfo;
import com.baidu.mapapi.search.route.SuggestAddrInfo;

/**
 *  路线搜索地址结果类.当输入的起点或终点有多个地点选择时，
 *  或者选定的城市没有此地点，但其它城市有(驾乘或步行)，返回该类的实
 */
public class BMFSuggestionAddrInfo {
    /** 起点POI列表，成员类型为BMFPoiInfo */
    List<PoiInfoBean> startPoiList = new ArrayList<>();

    /** 起点城市列表，成员类型为BMFCityListInfo,
     * 如果输入的地点在本城市没有而在其它城市有，则返回其它城市的信息
     */
    List<BMFCityInfo> startCityList = new ArrayList<>();

    /** 终点POI列表，成员类型为BMFPoiInfo */
    List<PoiInfoBean> endPoiList = new ArrayList<>();

    /** 终点城市列表，成员类型为BMFCityListInfo,
     * 如果输入的地点在本城市没有而在其它城市有，否则返回其它城市的信息
     * */
    List<BMFCityInfo> endCityList = new ArrayList<>();

    /** 途经点POI列表，成员类型为NSArray<PoiInfo*> *、
    List<List<PoiInfo>> wayPointPoiList;

    /**
     *  途经点城市列表，成员类型为NSArray<BMFCityListInfo*>,
     *  如果输入的地点在本城市没有而在其它城市有，则返回其它城市的信息
     */
    List<List<BMFCityInfo>> wayPointCityList = new ArrayList<>();
    // To Do android这里是PoiInfo

    public BMFSuggestionAddrInfo(SuggestAddrInfo suggestAddrInfo) {
        if (null == suggestAddrInfo) {
            return;
        }
        setStartInfoList(suggestAddrInfo.getSuggestStartCity());
        setStartPoiList(suggestAddrInfo.getSuggestStartNode());
        setEndPoiList(suggestAddrInfo.getSuggestEndNode());
        setEndCityList(suggestAddrInfo.getSuggestEndCity());
        setWayPointCityList(suggestAddrInfo.getSuggestWpNode());
    }

    private void setStartPoiList( List<PoiInfo> poiList) {
        if (null == poiList || poiList.size() <= 0) {
            return;
        }

        Iterator itr = poiList.iterator();
        PoiInfo poiInfo;
        while (itr.hasNext()) {
            poiInfo = (PoiInfo)itr.next();
            if(null == poiInfo){
                continue;
            }
            PoiInfoBean poiInfoBean = new PoiInfoBean(poiInfo);
            this.startPoiList.add(poiInfoBean);
        }
    }

    private void setStartInfoList(List<CityInfo> cityInfos) {
        if (null == cityInfos || cityInfos.size() <= 0) {
            return;
        }

        Iterator itr = cityInfos.iterator();
        CityInfo cityInfo;
        while (itr.hasNext()) {
            cityInfo = (CityInfo)itr.next();
            if(null == cityInfo){
                continue;
            }

            BMFCityInfo bmfCityInfo = new BMFCityInfo(cityInfo);
            this.startCityList.add(bmfCityInfo);
        }
    }

    private void setEndPoiList(List<PoiInfo> poiList){
        if (null == poiList || poiList.size() <= 0) {
            return;
        }

        Iterator itr = poiList.iterator();
        PoiInfo poiInfo;
        while (itr.hasNext()) {
            poiInfo = (PoiInfo)itr.next();
            if(null == poiInfo){
                continue;
            }
            PoiInfoBean poiInfoBean = new PoiInfoBean(poiInfo);
            this.endPoiList.add(poiInfoBean);
        }
    }

    private void setEndCityList(List<CityInfo> cityInfos){
        if (null == cityInfos || cityInfos.size() <= 0) {
            return;
        }

        Iterator itr = cityInfos.iterator();
        CityInfo cityInfo;
        while (itr.hasNext()) {
            cityInfo = (CityInfo)itr.next();
            if(null == cityInfo){
                continue;
            }

            BMFCityInfo bmfCityInfo = new BMFCityInfo(cityInfo);
            this.endCityList.add(bmfCityInfo);
        }
    }

    private void setWayPointCityList(List<List<PoiInfo>> wayPointCityList ){
        if (null == wayPointCityList || wayPointCityList.size() <= 0) {
            return;
        }

        Iterator itr = wayPointCityList.iterator();
        while (itr.hasNext()) {
            List<CityInfo> cityInfoList = (List<CityInfo>)itr.next();
            if(null == cityInfoList){
                continue;
            }

            List<BMFCityInfo> bmfCityInfoList = new ArrayList<>();

            Iterator subItr = cityInfoList.iterator();
            while (subItr.hasNext()){
                PoiInfo poiInfo = (PoiInfo) subItr.next();
                BMFCityInfo bmfCityInfo = new BMFCityInfo(poiInfo);
                bmfCityInfoList.add(bmfCityInfo);
            }

            this.wayPointCityList.add(bmfCityInfoList);
        }
    }
}
