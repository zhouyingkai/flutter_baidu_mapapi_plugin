package com.baidu.mapapi.search.bean.option;

import com.baidu.mapapi.model.LatLng;
//import com.baidu.mapapi.search.base.LanguageType;
import com.baidu.mapapi.search.weather.WeatherDataType;
import com.baidu.mapapi.search.weather.WeatherServerType;

public class WeatherOptionBean {

    /**
     * 天气服务类型，默认国内
     */
    public int serverType = WeatherServerType.WEATHER_SERVER_TYPE_DEFAULT.ordinal();

    /**
     * 区县的行政区划编码，和location二选一
     */
    public String districtID;

    /**
     * 经纬度，高级字段，需要申请高级权限
     */
    public LatLng location;

    /**
     * 请求数据类型，默认：WEATHER_DATA_TYPE_REAL_TIME
     */
    public int dataType = WeatherDataType.WEATHER_DATA_TYPE_REAL_TIME.ordinal();

    /**
     * 语言类型，默认中文。目前仅支持海外天气服务行政区划显示英文。
     */
//    public int languageType = LanguageType.LanguageTypeChinese.ordinal();

}
