package com.baidu.mapapi.search.bean.result.weather;

import com.baidu.mapapi.search.weather.WeatherSearchAlerts;

/**
 * 气象预警数据，高级字段
 */
public class WeatherSearchAlertsBean {
    /**
     * 预警事件类型，高级字段
     */
    private String type;

    /**
     * 预警事件等级，高级字段
     */
    private String level;

    /**
     * 预警标题，高级字段
     */
    private String title;

    /**
     * 预警详细提示信息，高级字段
     */
    private String desc;

    public WeatherSearchAlertsBean(WeatherSearchAlerts searchAlerts) {
        if (searchAlerts == null) {
            return;
        }

        this.type = searchAlerts.getType();
        this.level = searchAlerts.getLevel();
        this.title = searchAlerts.getTitle();
        this.desc = searchAlerts.getDesc();
    }
}
