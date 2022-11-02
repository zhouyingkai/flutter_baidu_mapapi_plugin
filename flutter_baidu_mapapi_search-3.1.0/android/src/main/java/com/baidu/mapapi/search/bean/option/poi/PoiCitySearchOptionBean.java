package com.baidu.mapapi.search.bean.option.poi;

import java.util.Iterator;
import java.util.List;

import com.baidu.mapapi.search.poi.PoiCitySearchOption;

import android.text.TextUtils;

/**
 * 城市检索
 */
public class PoiCitySearchOptionBean {
    /**
     * 检索关键字，必选。举例：天安门
     */
    String keyword;

    /**
     * 检索分类，与keyword字段组合进行检索，多个分类以","分隔。举例：美食,酒店
     */
    List<String> tags;

    /**
     * 区域名称(市或区的名字，如北京市，海淀区)或区域编码，必选
     */
    String city;

    /**
     * 区域数据返回限制，可选，为true时，仅返回city对应区域内数据
     */
    boolean isCityLimit;

    /**
     * 检索结果详细程度 默认为BMFPoiSearchScopeType.BASIC_INFORMATION
     */
    int scope;

    /**
     * 检索过滤条件。scope字段为BMFPoiSearchScopeType.DETAIL_INFORMATION时，filter字段才有效
     */
    PoiSearchFilter filter;

    /**
     * 分页页码，默认为0,0代表第一页，1代表第二页，以此类推
     */
    int pageIndex;

    /**
     * 单次召回POI数量，默认为10条记录，最大返回20条。
     */
    int pageSize;

    public PoiCitySearchOption toPoiCitySearchOption() {
        PoiCitySearchOption poiCitySearchOption = new PoiCitySearchOption();
        poiCitySearchOption.mCity = city;
        poiCitySearchOption.mIsCityLimit = isCityLimit;
        poiCitySearchOption.mKeyword = keyword;
        poiCitySearchOption.mPageCapacity = pageSize;
        poiCitySearchOption.tag(getTags());

        if (null != filter) {
            poiCitySearchOption.mPoiFilter = filter.toPoiFilter();
        }

        // flutter端的scope与android差了一个1
        poiCitySearchOption.scope(scope + 1);

        poiCitySearchOption.pageNum(pageIndex);

        return poiCitySearchOption;
    }

    private String getTags() {
        if (null == tags || tags.size() == 0) {
            return "";
        }

        StringBuilder sbTags = new StringBuilder();

        Iterator iterator = tags.iterator();
        String tag;
        while (iterator.hasNext()) {
            tag = (String) iterator.next();
            if (TextUtils.isEmpty(tag)) {
                continue;
            }

            sbTags.append(tag);

            if (iterator.hasNext()) {
                sbTags.append(',');
            }
        }

        return sbTags.toString();
    }
}
