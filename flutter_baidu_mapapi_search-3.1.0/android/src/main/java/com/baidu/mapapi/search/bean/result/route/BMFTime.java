/*
 * Copyright (C) 2020 Baidu, Inc. All Rights Reserved.
 */
package com.baidu.mapapi.search.bean.result.route;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *  此类代表一个时间段，每个属性都是一个时间段。
 */
public class BMFTime {
    private static final SimpleDateFormat format =  new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss" );
    /**
     * 时间段，单位（天）
      */
    public int dates;

    /**
     * 时间段，单位（小时）
     */
    public int hours;

    /**
     * 时间段，单位（分）
     */
    public int minutes;

    /**
     * 时间段，单位（秒）
     */
    public int seconds;

    public BMFTime(int duration) {
        this.dates = duration / (60 * 60 * 24);
        duration -= this.dates * 60  * 60  * 24;
        this.hours = duration / (60 * 60);
        duration -= this.hours * 60 * 60;
        this.minutes = duration / 60;
        duration -= this.minutes * 60;
        this.seconds = duration;
    }
}
