package com.baidu.mapapi.search.bean.option.poi;

/**
 * POI检索结果详细程度
 */
public class PoiOptionType {

    /**
     * 检索信息详细程度
     */
    public static enum PoiSearchScopeType {
        /**
         * 基本信息
         */
        BASIC_INFORMATION,

        /**
         * 详细信息
         */
        DETAIL_INFORMATION,
    }
}
