package com.baidu.mapapi.search.bean.result.poi;


import com.baidu.mapapi.search.bean.result.ResultBean;
import com.baidu.mapapi.search.core.PoiDetailInfo;
import com.baidu.mapapi.search.poi.PoiDetailSearchResult;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * poi详情检索结果
 */
public class PoiDetailSearchResultBean extends ResultBean {
    /** 符合条件的检索结果总个数 */
    public int totalPOINum;

    /** POI列表，成员是BMFPoiInfo */
    public List<PoiDetailResultBean> poiInfoList = new ArrayList<>();

    public PoiDetailSearchResultBean() {

    }

    public PoiDetailSearchResultBean(PoiDetailSearchResult poiDetailResult) {
        if (null == poiDetailResult) {
            return;
        }

        this.error = poiDetailResult.error;
        List<PoiDetailInfo> poiDetailInfos = poiDetailResult.getPoiDetailInfoList();
        if (null == poiDetailInfos || poiDetailInfos.size() <= 0) {
            this.totalPOINum = 0;
            return;
        }

        this.totalPOINum = poiDetailInfos.size();

        Iterator itr = poiDetailInfos.iterator();
        while (itr.hasNext()) {
            PoiDetailInfo poiDetailInfo = (PoiDetailInfo) itr.next();
            if (null == poiDetailInfo) {
                continue;
            }

            PoiDetailResultBean poiDetailSearchResultBean = new PoiDetailResultBean(poiDetailInfo);
            poiInfoList.add(poiDetailSearchResultBean);
        }
    }
}
