package com.baidu.mapapi.search.bean.result.poi;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.baidu.mapapi.search.bean.PoiInfoBean;
import com.baidu.mapapi.search.bean.result.ResultBean;
import com.baidu.mapapi.search.core.PoiInfo;
import com.baidu.mapapi.search.poi.PoiResult;

/**
 * 普通poi检索结果
 */
public class PoiResultBean extends ResultBean {

    /**
     * 符合条件的检索结果总页数
     */
    public int totalPageNum;

    /**
     * 当前页的页数索引
     */
    public int curPageIndex;

    /**
     * 符合条件的检索结果总个数
     */
    public int totalPOINum;

    /**
     * 当前页的结果个数
     */
    public int curPOINum;

    // Todo 缺少PoiAddr

    /**
     * POI列表，成员是BMFPoiInfo
     */
    public List<PoiInfoBean> poiInfoList = new ArrayList<>();

    public PoiResultBean(PoiResult poiResult) {
        if (null == poiResult) {
            return;
        }

        this.totalPOINum = poiResult.getTotalPoiNum();
        this.totalPageNum = poiResult.getTotalPageNum();
        this.curPOINum = poiResult.getCurrentPageCapacity();
        this.curPageIndex = poiResult.getCurrentPageNum();

        this.error = poiResult.error;

        List<PoiInfo> poiInfos = poiResult.getAllPoi();

        if (null == poiInfos || poiInfos.size() <= 0) {
            return;
        }

        Iterator itr = poiInfos.iterator();
        PoiInfo poiInfo;
        while (itr.hasNext()) {
            poiInfo = (PoiInfo) itr.next();
            if (null == poiInfo) {
                continue;
            }
            PoiInfoBean poiInfoBean = new PoiInfoBean(poiInfo);
            poiInfoList.add(poiInfoBean);
        }
    }
}
