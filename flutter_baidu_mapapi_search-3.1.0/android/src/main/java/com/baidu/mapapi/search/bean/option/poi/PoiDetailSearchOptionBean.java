package com.baidu.mapapi.search.bean.option.poi;

import java.util.List;

import com.baidu.mapapi.search.poi.PoiDetailSearchOption;

import android.text.TextUtils;

/**
 * poi详情检索
 */
public class PoiDetailSearchOptionBean {
    /**
     * POI的唯一标识符集合，必选 注：从POI检索的返回结果BMFPoiInfo里获取。
     */
    List<String> poiUIDs;

    /**
     * 检索结果详细程度 默认为BMFPoiSearchScopeType.BASIC_INFORMATION
     */
    PoiOptionType.PoiSearchScopeType scope;

    public PoiDetailSearchOption toPoiDetaioSearchOption() {
        PoiDetailSearchOption poiDetailSearchOption = new PoiDetailSearchOption();
        if (null == this.poiUIDs || this.poiUIDs.size() <= 0) {
            return null;
        }

        if (this.poiUIDs.size() == 1) {
            poiDetailSearchOption.poiUids(poiUIDs.get(0));
            return poiDetailSearchOption;
        }

        StringBuilder uids = new StringBuilder();
        int i = 1;
        for (String uid : poiUIDs) {
            i++;
            if (TextUtils.isEmpty(uid)) {
                continue;
            }
            uids.append(uid);
            if (i < poiUIDs.size()) {
                uids.append(',');
            }
        }

        poiDetailSearchOption.poiUids(uids.toString());

        return poiDetailSearchOption;
    }
}
