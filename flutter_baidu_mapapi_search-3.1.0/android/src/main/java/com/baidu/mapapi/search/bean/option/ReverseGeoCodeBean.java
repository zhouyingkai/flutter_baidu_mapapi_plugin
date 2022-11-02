package com.baidu.mapapi.search.bean.option;

import com.baidu.mapapi.model.LatLng;

public class ReverseGeoCodeBean {
    /**
     * 单页展示POI数量，默认为10条记录，最大返回100条。
     */
    public int pageSize = 10;

    /**
     * 分页页码
     * 默认为0,0代表第一页，1代表第二页，以此类推
     */
    public int pageNum = 0;

    /**
     * 反地理编码位置坐标
     */
    public LatLng location = null;

    /**
     * 是否获取最新版行政区划数据（仅对中国数据生效），1（访问），0（不访问）
     */
    public boolean isLatestAdmin = true;

    /**
     * poi召回半径，允许设置区间为0-1000米，超过1000米按1000米召回
     * 默认值为1000
     */
    public int radius = 1000;
}
