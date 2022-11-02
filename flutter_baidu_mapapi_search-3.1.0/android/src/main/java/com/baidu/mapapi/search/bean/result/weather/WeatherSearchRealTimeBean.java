package com.baidu.mapapi.search.bean.result.weather;

import com.baidu.mapapi.search.weather.WeatherSearchRealTime;

/**
 * 实时天气预报
 */
public class WeatherSearchRealTimeBean {

    /**
     * 相对湿度(%)
     */
    private int relativeHumidity;

    /**
     * 体感温度(℃)
     */
    private int sensoryTemp;

    /**
     * 天气现象
     */
    private String phenomenon;

    /**
     * 风向描述
     */
    private String windDirection;

    /**
     * 数据更新时间，北京时间
     */
    private String updateTime;

    /**
     * 温度（℃）
     */
    private int temperature;

    /**
     * 风力等级
     */
    private String windPower;

    /**
     * 云量(%)，高级字段
     */
    private int clouds;

    /**
     * 1小时累计降水量(mm)，高级字段
     */
    private float hourlyPrecipitation;

    /**
     * 能见度(m)，高级字段
     */
    private int visibility;

    /**
     * 臭氧浓度(μg/m3)，高级字段，仅国内支持
     */
    private int O3;

    /**
     * pm2.5浓度(μg/m3)，高级字段，仅国内支持
     */
    private int PM2_5;

    /**
     * 二氧化氮浓度(μg/m3)，高级字段，仅国内支持
     */
    private int NO2;

    /**
     * 二氧化硫浓度(μg/m3)，高级字段，仅国内支持
     */
    private int SO2;

    /**
     * 空气质量指数数值，高级字段，仅国内支持
     */
    private int airQualityIndex;

    /**
     * pm10浓度(μg/m3)，高级字段，仅国内支持
     */
    private int PM10;

    /**
     * 一氧化碳浓度(mg/m3)，高级字段，仅国内支持
     */
    private float CO;

    public WeatherSearchRealTimeBean(WeatherSearchRealTime realTime) {
        if (realTime == null) {
            return;
        }
        this.relativeHumidity = realTime.getRelativeHumidity();
        this.sensoryTemp = realTime.getSensoryTemp();
        this.phenomenon = realTime.getPhenomenon();
        this.windDirection = realTime.getWindDirection();
        this.updateTime = realTime.getUpdateTime();
        this.temperature = realTime.getTemperature();
        this.windPower = realTime.getWindPower();
        this.clouds = realTime.getClouds();
        this.hourlyPrecipitation = realTime.getHourlyPrecipitation();
        this.visibility = realTime.getVisibility();
        this.O3 = realTime.getO3();
        this.PM2_5 = realTime.getPM2_5();
        this.NO2 = realTime.getNO2();
        this.SO2 = realTime.getSO2();
        this.airQualityIndex = realTime.getAirQualityIndex();
        this.PM10 = realTime.getPM10();
        if (Float.isNaN(realTime.getCO())) {
            this.CO = 0;
        } else {
            this.CO = realTime.getCO();
        }
    }
}
