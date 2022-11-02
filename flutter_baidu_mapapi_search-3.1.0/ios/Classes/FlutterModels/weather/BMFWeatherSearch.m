//
//  BMFWeatherSearch.m
//  flutter_baidu_mapapi_search
//
//  Created by Zhang,Baojin on 2020/11/13.
//

#import "BMFWeatherSearch.h"
#import <BaiduMapAPI_Search/BMKWeatherSearchOption.h>
#import <BaiduMapAPI_Search/BMKWeatherSearchResult.h>
#import <flutter_baidu_mapapi_base/BMFMapModels.h>

@implementation BMFWeatherSearchOption

- (BMKWeatherSearchOption *)toBMKWeatherSearchOption {
    BMKWeatherSearchOption *option = [BMKWeatherSearchOption new];
    /// 必选。区县的行政区划编码，和location二选一
    if (self.districtID) {
        option.districtID = self.districtID;
    };
    /// 必选。经纬度，高级字段，需要申请高级权限
    if (self.location) {
        option.location = [self.location toCLLocationCoordinate2D];
    }
    /// 可选。天气服务类型，默认国内
    option.serverType = (int)self.serverType;
    /// 可选。请求数据类型，默认：BMFWeatherDataTypeNow
    option.dataType = (int)self.dataType;
    /// 可选。语言类型，默认中文。目前仅支持海外天气服务行政区划显示英文。
    option.languageType = (int)self.languageType;
    return option;
}

@end


@implementation BMFWeatherSearchNow

+ (instancetype)fromBMKWeatherSearchNow:(BMKWeatherSearchNow *)result {
    BMFWeatherSearchNow *res = [BMFWeatherSearchNow new];
    /// 相对湿度(%)
    res.relativeHumidity = result.relativeHumidity;
    /// 体感温度(℃)
    res.sensoryTemp = result.sensoryTemp;
    /// 天气现象
    res.phenomenon = result.phenomenon;
    /// 风向描述
    res.windDirection = result.windDirection;
    /// 数据更新时间，北京时间
    res.updateTime = result.updateTime;
    /// 温度（℃）
    res.temperature = result.temperature;
    /// 风力等级
    res.windPower = result.windPower;
    /// 云量(%)，高级字段
    res.clouds = result.clouds;
    /// 1小时累计降水量(mm)，高级字段
    res.hourlyPrecipitation = result.hourlyPrecipitation;
    /// 能见度(m)，高级字段
    res.visibility = result.visibility;
    /// 臭氧浓度(μg/m3)，高级字段，仅国内支持
    res.O3 = result.O3;
    /// pm2.5浓度(μg/m3)，高级字段，仅国内支持
    res.PM2_5 = result.PM2_5;
    /// 二氧化氮浓度(μg/m3)，高级字段，仅国内支持
    res.NO2 = result.NO2;
    /// 二氧化硫浓度(μg/m3)，高级字段，仅国内支持
    res.SO2 = result.SO2;
    /// 空气质量指数数值，高级字段，仅国内支持
    res.airQualityIndex = result.airQualityIndex;
    /// pm10浓度(μg/m3)，高级字段，仅国内支持
    res.PM10 = result.PM10;
    /// 一氧化碳浓度(mg/m3)，高级字段，仅国内支持
    res.CO = result.CO;
    return res;
}

@end


@implementation BMFWeatherSearchLocation

+ (instancetype)fromBMKWeatherSearchLocation:(BMKWeatherSearchLocation *)result {
    BMFWeatherSearchLocation *res = [BMFWeatherSearchLocation new];
    /// 国家名称
    res.country = result.country;
    /// 省份名称
    res.province = result.province;
    /// 城市名称
    res.city = result.city;
    /// 区县名称
    res.districtName = result.districtName;
    /// 区县id
    res.districtID = result.districtID;
    return res;
}

@end


@implementation BMFWeatherSearchForecasts

+ (instancetype)fromBMKWeatherSearchForecasts:(BMKWeatherSearchForecasts *)result {
    BMFWeatherSearchForecasts *res = [BMFWeatherSearchForecasts new];
    /// 日期，北京时区
    res.date = result.date;
    /// 星期，北京时区
    res.week = result.week;
    /// 最低温度(℃)
    res.lowestTemp = result.lowestTemp;
    /// 最高温度(℃)
    res.highestTemp = result.highestTemp;
    /// 白天风力
    res.windPowerDay = result.windPowerDay;
    /// 晚上风力
    res.windPowerNight = result.windPowerNight;
    /// 白天风向
    res.windDirectionDay = result.windDirectionDay;
    /// 晚上风向
    res.windDirectionrNight = result.windDirectionrNight;
    /// 白天天气现象
    res.phenomenonDay = result.phenomenonDay;
    /// 晚上天气现象
    res.phenomenonNight = result.phenomenonNight;
    /// 空气质量指数数值，高级字段
    res.airQualityIndex = result.airQualityIndex;
    return res;
}

@end


@implementation BMFWeatherSearchIndexes

+ (instancetype)fromBMKWeatherSearchIndexes:(BMKWeatherSearchIndexes *)result {
    BMFWeatherSearchIndexes *res = [BMFWeatherSearchIndexes new];
    /// 生活指数中文名称，高级字段
    res.name = result.name;
    /// 生活指数概要说明，高级字段
    res.brief = result.brief;
    /// 生活指数详细说明，高级字段
    res.detail = result.detail;
    return res;
}

@end


@implementation BMFWeatherSearchForecastForHours

+ (instancetype)fromBMKWeatherSearchForecastForHours:(BMKWeatherSearchForecastForHours *)result {
    BMFWeatherSearchForecastForHours *res =[BMFWeatherSearchForecastForHours new];
    /// 相对湿度(%)，高级字段
    res.relativeHumidity = result.relativeHumidity;
    /// 数据时间，高级字段
    res.dataTime = result.dataTime;
    /// 风向描述，高级字段
    res.windDirection = result.windDirection;
    /// 风力等级，高级字段
    res.windPower = result.windPower;
    /// 温度(℃)，高级字段
    res.temperature = result.temperature;
    /// 云量(%)，高级字段
    res.clouds = result.clouds;
    /// 天气现象，高级字段
    res.phenomenon = result.phenomenon;
    /// 1小时累计降水量(mm)，高级字段
    res.hourlyPrecipitation = result.hourlyPrecipitation;
    return res;
}

@end


@implementation BMFWeatherSearchAlerts

+ (instancetype)fromBMKWeatherSearchAlerts:(BMKWeatherSearchAlerts *)result {
    BMFWeatherSearchAlerts *res = [BMFWeatherSearchAlerts new];
    /// 预警事件类型，高级字段
    res.type = result.type;
    /// 预警事件等级，高级字段
    res.level = result.level;
    /// 预警标题，高级字段
    res.title = result.title;
    /// 预警详细提示信息，高级字段
    res.desc = result.desc;
    return res;
}

@end


@implementation BMFWeatherSearchResult

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"forecasts" : @"BMFWeatherSearchForecasts",
             @"forecastHours" : @"BMFWeatherSearchForecastForHours",
             @"lifeIndexes" : @"BMFWeatherSearchIndexes",
             @"weatherAlerts" : @"BMFWeatherSearchAlerts"
    };
}

+ (instancetype)fromBMKWeatherSearchResult:(BMKWeatherSearchResult *)result {
    BMFWeatherSearchResult *res = [BMFWeatherSearchResult new];
    /// 天气实况数据
    if (result.realTimeWeather) {
        res.realTimeWeather = [BMFWeatherSearchNow fromBMKWeatherSearchNow:result.realTimeWeather];
    }
    
    /// 地理位置信息
    if (result.location) {
        res.location = [BMFWeatherSearchLocation fromBMKWeatherSearchLocation:result.location];
    }
    /// 未来5天预报数据
    if (result.forecasts && result.forecasts.count > 0) {
        NSMutableArray<BMFWeatherSearchForecasts *> *mut = [NSMutableArray array];
        for (BMKWeatherSearchForecasts *info in result.forecasts) {
            [mut addObject:[BMFWeatherSearchForecasts fromBMKWeatherSearchForecasts:info]];
        }
        res.forecasts = [mut copy];
    }
    /// 未来24小时逐小时预报，高级字段
    if (result.forecastHours && result.forecastHours.count > 0) {
        NSMutableArray<BMFWeatherSearchForecastForHours *> *mut = [NSMutableArray array];

        for (BMKWeatherSearchForecastForHours *info in result.forecastHours) {
            [mut addObject:[BMFWeatherSearchForecastForHours fromBMKWeatherSearchForecastForHours:info]];
        }
        res.forecastHours = [mut copy];
    }
    /// 生活指数数据，高级字段
    if (result.lifeIndexes && result.lifeIndexes.count > 0) {
        NSMutableArray<BMFWeatherSearchIndexes *> *mut = [NSMutableArray array];
        for (BMKWeatherSearchIndexes *info in result.lifeIndexes) {
            [mut addObject:[BMFWeatherSearchIndexes fromBMKWeatherSearchIndexes:info]];
        }
        res.lifeIndexes = [mut copy];
    }
    /// 气象预警数据，高级字段
    if (result.weatherAlerts && result.weatherAlerts.count > 0) {
        NSMutableArray<BMFWeatherSearchAlerts *> *mut =[NSMutableArray array];
        for (BMKWeatherSearchAlerts *info in result.weatherAlerts) {
            [mut addObject:[BMFWeatherSearchAlerts fromBMKWeatherSearchAlerts:info]];
        }
        res.weatherAlerts = [mut copy];
    }
    return res;
}

@end
