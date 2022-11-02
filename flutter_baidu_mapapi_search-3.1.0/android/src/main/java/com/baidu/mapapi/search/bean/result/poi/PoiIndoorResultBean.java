package com.baidu.mapapi.search.bean.result.poi;

import java.util.ArrayList;
import java.util.List;

import com.baidu.mapapi.search.bean.result.PoiIndoorInfoBean;
import com.baidu.mapapi.search.bean.result.ResultBean;
import com.baidu.mapapi.search.poi.PoiIndoorInfo;
import com.baidu.mapapi.search.poi.PoiIndoorResult;

/**
 * 室内poi检索结果
 */
public class PoiIndoorResultBean extends ResultBean {
    /**
     * 符合条件的检索结果总个数
     */
    public int totalPOINum;

    /**
     * 符合条件的检索结果总页数
     */
    public int totalPageNum;

    /**
     * 当前页的结果个数
     */
    public int curPOINum;

    /**
     * 当前页的页数索引
     */
    public int curPageIndex;

    /**
     * 室内POI列表，成员是BMFPoiIndoorInfo
     */
    List<PoiIndoorInfoBean> poiIndoorInfoList = new ArrayList<>();

    public PoiIndoorResultBean(PoiIndoorResult poiIndoorResult) {
        if (null == poiIndoorResult) {
            return;
        }

        this.totalPOINum = poiIndoorResult.getPoiNum();
        this.curPageIndex = poiIndoorResult.getPageNum();
        this.error = poiIndoorResult.error;
        List<PoiIndoorInfo> poiIndoorInfoList = poiIndoorResult.getArrayPoiInfo();
        if (null == poiIndoorInfoList || poiIndoorInfoList.size() <= 0) {
            return;
        }
        for (PoiIndoorInfo poiIndoorInfo : poiIndoorInfoList) {
            PoiIndoorInfoBean poiIndoorInfoBean = new PoiIndoorInfoBean(poiIndoorInfo);
            this.poiIndoorInfoList.add(poiIndoorInfoBean);
        }
    }
}
