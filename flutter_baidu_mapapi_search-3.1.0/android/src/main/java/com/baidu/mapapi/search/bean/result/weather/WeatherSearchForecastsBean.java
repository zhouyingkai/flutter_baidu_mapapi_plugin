package com.baidu.mapapi.search.bean.result.weather;

import com.baidu.mapapi.search.weather.WeatherSearchForecasts;

/**
 * 未来若干天天预报数据
 */
public class WeatherSearchForecastsBean {

    /**
     * 日期，北京时区
     */
    private String date;

    /**
     * 星期，北京时区
     */
    private String week;

    /**
     * 最低温度(℃)
     */
    private int lowestTemp;

    /**
     * 最高温度(℃)
     */
    private int highestTemp;

    /**
     * 白天风力
     */
    private String windPowerDay;

    /**
     * 晚上风力
     */
    private String windPowerNight;

    /**
     * 白天风向
     */
    private String windDirectionDay;

    /**
     * 晚上风向
     */
    private String windDirectionNight;

    /**
     * 白天天气现象
     */
    private String phenomenonDay;

    /**
     * 晚上天气现象
     */
    private String phenomenonNight;

    /**
     * 空气质量指数数值，高级字段
     */
    private int airQualityIndex;

    public WeatherSearchForecastsBean(WeatherSearchForecasts forecastsBean) {
        if (forecastsBean == null) {
            return;
        }

        this.date = forecastsBean.getDate();
        this.week = forecastsBean.getWeek();
        this.lowestTemp = forecastsBean.getLowestTemp();
        this.highestTemp = forecastsBean.getHighestTemp();
        this.windPowerDay = forecastsBean.getWindPowerDay();
        this.windPowerNight = forecastsBean.getWindPowerNight();
        this.windDirectionDay = forecastsBean.getWindDirectionDay();
        this.windDirectionNight = forecastsBean.getWindDirectionNight();
        this.phenomenonDay = forecastsBean.getPhenomenonDay();
        this.phenomenonNight = forecastsBean.getPhenomenonNight();
        this.airQualityIndex = forecastsBean.getAirQualityIndex();
    }
}
