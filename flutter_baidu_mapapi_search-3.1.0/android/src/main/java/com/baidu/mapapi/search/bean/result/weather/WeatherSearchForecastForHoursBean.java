package com.baidu.mapapi.search.bean.result.weather;

import com.baidu.mapapi.search.weather.WeatherSearchForecastForHours;

/**
 * 未来24小时逐小时预报，高级字段
 */
public class WeatherSearchForecastForHoursBean {
    /**
     * 相对湿度(%)，高级字段
     */
    private int relativeHumidity;

    /**
     * 数据时间，高级字段
     */
    private String dataTime;

    /**
     * 风向描述，高级字段
     */
    private String windDirection;

    /**
     * 风力等级，高级字段
     */
    private String windPower;

    /**
     * 温度(℃)，高级字段
     */
    private int temperature;

    /**
     * 云量(%)，高级字段
     */
    private int clouds;

    /**
     * 天气现象，高级字段
     */
    private String phenomenon;

    /**
     * 1小时累计降水量(mm)，高级字段
     */
    private int hourlyPrecipitation;

    public WeatherSearchForecastForHoursBean(WeatherSearchForecastForHours forecastForHoursBean) {
        if (forecastForHoursBean == null) {
            return;
        }

        this.relativeHumidity = forecastForHoursBean.getRelativeHumidity();
        this.dataTime = forecastForHoursBean.getDataTime();
        this.windDirection = forecastForHoursBean.getWindDirection();
        this.windPower = forecastForHoursBean.getWindPower();
        this.temperature = forecastForHoursBean.getTemperature();
        this.clouds = forecastForHoursBean.getClouds();
        this.phenomenon = forecastForHoursBean.getPhenomenon();
        this.hourlyPrecipitation = forecastForHoursBean.getHourlyPrecipitation();
    }
}
