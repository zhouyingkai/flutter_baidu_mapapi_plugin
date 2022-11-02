package com.baidu.mapapi.search.bean.option.poi;

import java.util.Iterator;
import java.util.List;

import com.baidu.mapapi.model.LatLng;
import com.baidu.mapapi.search.poi.PoiNearbySearchOption;

import android.text.TextUtils;

/**
 * 附近检索
 */
public class PoiNearbySearchOptionBean {
    /**
     * 在周边检索中关键字为数组类型，可以支持多个关键字并集检索，如银行和酒店。每个关键字对应数组一个元素。
     * 最多支持10个关键字。
     */
    public List<String> keywords;

    /**
     * 该字段与keywords字段组合进行检索。
     * 支持多个分类，如美食和酒店。每个分类对应数组中一个元素
     */
    public List<String> tags;

    /**
     * 检索中心点的经纬度，必选
     */
    public LatLng location;

    /**
     * 当半径过大，超过中心点所在城市边界时，会变为城市范围检索，检索范围为中心点所在城市
     */
    public int radius;

    /**
     * 是否严格限定召回结果在设置检索半径范围内。默认值为false。
     * <p>
     * 值为true代表检索结果严格限定在半径范围内；值为false时不严格限定。
     * 注意：值为true时会影响返回结果中total准确性及每页召回poi数量，我们会逐步解决此类问题。
     */
    public boolean isRadiusLimit;

    /**
     * 检索结果详细程度 默认为BMFPoiSearchScopeType.BASIC_INFORMATION
     */
    int scope;

    /**
     * 检索过滤条件。scope字段为BMFPoiSearchScopeType.DETAIL_INFORMATION时，filter字段才有效
     */
    public PoiSearchFilter filter;

    /**
     * 分页页码，默认为0,0代表第一页，1代表第二页，以此类推
     */
    public int pageIndex;

    /**
     * 单次召回POI数量，默认为10条记录，最大返回20条。
     */
    public int pageSize;

    public PoiNearbySearchOption toPoiNearbySearchOption() {
        PoiNearbySearchOption poiNearbySearchOption = new PoiNearbySearchOption();
        poiNearbySearchOption.mKeyword = getKeywords();
        poiNearbySearchOption.mLocation = location;
        poiNearbySearchOption.mPageCapacity = pageSize;
        poiNearbySearchOption.mPageNum = pageIndex;

        if (null != filter) {
            poiNearbySearchOption.mPoiFilter = filter.toPoiFilter();
        }

        poiNearbySearchOption.mRadius = radius;
        poiNearbySearchOption.mRadiusLimit = isRadiusLimit;

        // flutter端的scope与android差了一个1
        poiNearbySearchOption.mScope = scope + 1;

        poiNearbySearchOption.mTag = getTags();
        //poiNearbySearchOption.sortType =

        return poiNearbySearchOption;
    }

    private String getKeywords() {
        if (null == keywords || keywords.size() == 0) {
            return "";
        }

        StringBuilder sbKeyWords = new StringBuilder();

        Iterator iterator = keywords.iterator();
        String keyWord;
        while (iterator.hasNext()) {
            keyWord = (String) iterator.next();
            if (TextUtils.isEmpty(keyWord)) {
                continue;
            }

            sbKeyWords.append(keyWord);
            if (iterator.hasNext()) {
                sbKeyWords.append('$');
            }
        }

        return sbKeyWords.toString();
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
