package com.baidu.mapapi.search.bean.result;

import com.baidu.mapapi.search.bean.option.LatLngBean;

public class GeoCodeResultBean extends ResultBean{
    /**
     * 经纬度坐标
     */
    public LatLngBean location;

    /**
     * 地址信息
     * @deprecated
     * V5.2.0版本废弃该字段，为兼容旧版本仍旧有值返回，但是返回的是请求参数中的地址信息
     */
    public String address;

    /**
     * 位置的附加信息，是否精确查找
     * 1为精确查找，即准确打点；0为不精确，即模糊打点
     * （模糊打点无法保证准确度，不建议使用）
     */
    public int precise;

    /**
     * 可信度，描述打点准确度，大于80表示误差小于100m
     * 该字段仅作参考，返回结果准确度主要参考precise参数
     */
    public int confidence;

    /**
     * 能精确理解的地址类型
     * 包含：UNKNOWN、国家、省、城市、区县、乡镇、村庄、道路、地产小区、商务大厦、
     * 政府机构、交叉路口、商圈、生活服务、休闲娱乐、餐饮、宾馆、购物、金融、教育、
     * 医疗 、工业园区 、旅游景点 、汽车服务、火车站、长途汽车站、桥 、
     * 停车场/停车区、港口/码头、收费区/收费站、飞机场 、机场 、收费处/收费站 、加油站、绿地、门址
     */
    public String level;
}
