package com.baidu.mapapi.search.bean.result.weather;

import com.baidu.mapapi.search.weather.WeatherLifeIndexes;

/**
 * 生活指数数据，高级字段
 */
public class WeatherLifeIndexesBean {
    /**
     * 生活指数中文名称，高级字段
     */
    private String name;

    /**
     * 生活指数概要说明，高级字段
     */
    private String brief;

    /**
     * 生活指数详细说明，高级字段
     */
    private String detail;

    public WeatherLifeIndexesBean(WeatherLifeIndexes lifeIndexes) {
        if (lifeIndexes == null) {
            return;
        }

        this.name = lifeIndexes.getName();
        this.brief = lifeIndexes.getBrief();
        this.detail = lifeIndexes.getDetail();
    }
}
