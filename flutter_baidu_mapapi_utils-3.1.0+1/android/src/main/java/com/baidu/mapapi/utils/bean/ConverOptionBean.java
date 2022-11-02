package com.baidu.mapapi.utils.bean;

import com.baidu.mapapi.model.LatLng;

/**
 * 坐标转换
 */
public class ConverOptionBean {

    /**
     * 待转换坐标
     */
    public LatLng coordinate;

    /**
     * 待转换坐标类型
     */
    public int fromType;

    /**
     * 目标转换坐标类型
     */
    public int toType;
}
