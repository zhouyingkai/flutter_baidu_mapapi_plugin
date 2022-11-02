package com.baidu.mapapi.search.bean.option.poi;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.baidu.mapapi.model.LatLng;
import com.baidu.mapapi.model.LatLngBounds;
import com.baidu.mapapi.search.poi.PoiBoundSearchOption;

import android.text.TextUtils;

/**
 * POI矩形区域检索
 */
public class PoiBoundSearchOptionBean {
    /**
     * 在矩形检索中关键字为数组类型，可以支持多个关键字并集检索，如银行和酒店。每个关键字对应数组一个元素。
     * 最多支持10个关键字。
     */
    List<String> keywords;

    /**
     * 该字段与keywords字段组合进行检索。
     * 支持多个分类，如美食和酒店。每个分类对应数组中一个元素
     */
    List<String> tags;

    /**
     * 矩形检索区域的左下角经纬度坐标，必选
     */
    LatLng leftBottom;

    /**
     * 矩形检索区域的右上角经纬度坐标，必选
     */
    LatLng rightTop;

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

    public PoiBoundSearchOption toPoiBoundsSeatchOption() {
        PoiBoundSearchOption poiBoundSearchOption = new PoiBoundSearchOption();

        List<LatLng> latLngList = new ArrayList<>();
        latLngList.add(leftBottom);
        latLngList.add(rightTop);
        poiBoundSearchOption.mBound = new LatLngBounds.Builder().include(latLngList).build();
        poiBoundSearchOption.mPageCapacity = pageSize;
        poiBoundSearchOption.mPageNum = pageIndex;

        // flutter端的scope与android差了一个1
        poiBoundSearchOption.mScope = scope + 1;

        poiBoundSearchOption.keyword(getKeywords());
        poiBoundSearchOption.tag(getTags());

        if (null != filter) {
            poiBoundSearchOption.mPoiFilter = filter.toPoiFilter();
        }

        return poiBoundSearchOption;
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
