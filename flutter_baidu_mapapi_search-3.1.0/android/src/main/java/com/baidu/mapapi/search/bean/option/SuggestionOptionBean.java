package com.baidu.mapapi.search.bean.option;

import com.baidu.mapapi.model.LatLng;

/**
 * 建议
 */
public class SuggestionOptionBean {
    /** 搜索关键字，必选 */
    public String keyword;

    /** 城市名，参数也可以传入citycode，必选 */
    public String cityname;

    /** 指定位置，可选，注：会影响关键字不在设置城市范围内时的检索结果，故不建议使用。*/
    public LatLng location;

    /** 是否只返回指定城市检索结果（默认：false）（提示：海外区域暂不支持设置cityLimit）*/
    public boolean cityLimit;
}
