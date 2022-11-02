package com.baidu.mapapi.search.bean.option.poi;

import com.baidu.mapapi.search.poi.PoiIndoorOption;

/**
 * 室内POI检索
 */
public class PoiIndoorSearchOptionBean {
    /**
     * 室内检索唯一标识符，必选 注：从进入/移出室内图的回调方法中获取。
     */
    String indoorID;

    /**
     * 室内检索关键字，必选
     */
    String keyword;

    /**
     * 楼层（可选），设置后，会优先获取该楼层的室内POI，然后是其它楼层的。如“F3”,"B3"等
     */
    String floor;

    /**
     * 分页页码，默认为0,0代表第一页，1代表第二页，以此类推
     */
    int pageIndex;

    /**
     * 单次召回POI数量，默认为10条记录，最大返回20条。
     */
    int pageSize;

    public PoiIndoorOption toPoiIndoorSearchOption() {
        PoiIndoorOption poiIndoorOption = new PoiIndoorOption();
        poiIndoorOption.bid = indoorID;
        poiIndoorOption.wd = keyword;
        poiIndoorOption.floor = floor;
        poiIndoorOption.currentPage = pageIndex;
        poiIndoorOption.pageSize = pageSize;

        return poiIndoorOption;
    }
}
