package com.baidu.mapapi.search.bean.result.weather;

import com.baidu.mapapi.search.bean.result.ResultBean;
import com.baidu.mapapi.search.weather.WeatherLifeIndexes;
import com.baidu.mapapi.search.weather.WeatherResult;
import com.baidu.mapapi.search.weather.WeatherSearchAlerts;
import com.baidu.mapapi.search.weather.WeatherSearchForecastForHours;
import com.baidu.mapapi.search.weather.WeatherSearchForecasts;

import java.util.ArrayList;
import java.util.List;

/**
 * 天气检索结果
 */
public class WeatherResultBean extends ResultBean {

    /**
     * 天气实况数据
     */
    private WeatherSearchRealTimeBean realTimeWeather;

    /**
     * 地理位置信息
     */
    private WeatherSearchLocationBean location;

    /**
     * 未来若干天天预报数据
     */
    private List<WeatherSearchForecastsBean> forecasts = new ArrayList<>();

    /**
     * 未来24小时逐小时预报，高级字段
     */
    private List<WeatherSearchForecastForHoursBean> forecastHours = new ArrayList<>();

    /**
     * 生活指数数据，高级字段
     */
    private List<WeatherLifeIndexesBean> lifeIndexes = new ArrayList<>();

    /**
     * 气象预警数据，高级字段
     */
    private List<WeatherSearchAlertsBean> weatherAlerts = new ArrayList<>();

    public WeatherResultBean(WeatherResult weatherResult) {
        if (weatherResult == null) {
            return;
        }
        this.error = weatherResult.error;
        if (weatherResult.getRealTimeWeather() != null) {
            this.realTimeWeather = new WeatherSearchRealTimeBean(weatherResult.getRealTimeWeather());
        }

        if (weatherResult.getLocation() != null) {
            this.location = new WeatherSearchLocationBean(weatherResult.getLocation());
        }

        List<WeatherSearchForecasts> forecastsList = weatherResult.getForecasts();
        if (forecastsList != null && forecastsList.size() > 0) {
            for (WeatherSearchForecasts forecast : forecastsList) {
                WeatherSearchForecastsBean forecastsBean = new WeatherSearchForecastsBean(forecast);
                this.forecasts.add(forecastsBean);
            }
        }
        List<WeatherSearchForecastForHours> forecastHoursList = weatherResult.getForecastHours();
        if (forecastHoursList != null && forecastHoursList.size() > 0) {
            for (WeatherSearchForecastForHours forHours : forecastHoursList) {
                WeatherSearchForecastForHoursBean forecastsBean = new WeatherSearchForecastForHoursBean(forHours);
                this.forecastHours.add(forecastsBean);
            }
        }
        List<WeatherLifeIndexes> lifeIndexesList = weatherResult.getLifeIndexes();
        if (lifeIndexesList != null && lifeIndexesList.size() > 0) {
            for (WeatherLifeIndexes indexes : lifeIndexesList) {
                WeatherLifeIndexesBean forecastsBean = new WeatherLifeIndexesBean(indexes);
                this.lifeIndexes.add(forecastsBean);
            }
        }
        List<WeatherSearchAlerts> weatherAlertsList = weatherResult.getWeatherAlerts();
        if (weatherAlertsList != null && weatherAlertsList.size() > 0) {
            for (WeatherSearchAlerts alertsBean : weatherAlertsList) {
                WeatherSearchAlertsBean forecastsBean = new WeatherSearchAlertsBean(alertsBean);
                this.weatherAlerts.add(forecastsBean);
            }
        }
    }
}
