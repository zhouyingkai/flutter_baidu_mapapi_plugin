//
//  BMFWeatherSearch.h
//  flutter_baidu_mapapi_search
//
//  Created by Zhang,Baojin on 2020/11/13.
//

#import <flutter_baidu_mapapi_base/BMFModel.h>

@class BMFCoordinate;
@class BMKWeatherSearchOption;
@class BMKWeatherSearchNow;
@class BMKWeatherSearchLocation;
@class BMKWeatherSearchForecasts;
@class BMKWeatherSearchIndexes;
@class BMKWeatherSearchForecastForHours;
@class BMKWeatherSearchAlerts;
@class BMKWeatherSearchResult;

/// 天气服务类型枚举
typedef enum {
    BMFWeatherServerTypeDefault = 0,   // 国内
    BMFLanguageServerTypeAbroad // 海外
} BMFWeatherServerType;
/// 天气数据类型枚举
typedef enum {
    BMFWeatherDataTypeNow = 0,   // 实时天气预报
    BMFWeatherDataTypeForecasts, // 未来五天天气预报
    BMFWeatherDataTypeForecastsForHour, // 按小时天气预报，高级字段
    BMFWeatherDataTypeLifeIndex, // 生活指数，仅支持国内，高级字段
    BMFWeatherDataTypeAlert, // 天气事件预警，仅支持国内，高级字段
    BMFWeatherDataTypeAll // 以上全部，高级字段获取对应权限后可返回
} BMFWeatherDataType;
/// 语言类型枚举
typedef enum {
    BMFLanguageTypeChinese = 0,   // 中文
    BMFLanguageTypeEnglish       // 英文
} BMFLanguageType;
NS_ASSUME_NONNULL_BEGIN

@interface BMFWeatherSearchOption : BMFModel

/// 必选。区县的行政区划编码，和location二选一
@property (nonatomic, copy) NSString *districtID;

/// 必选。经纬度，高级字段，需要申请高级权限
@property (nonatomic, assign) BMFCoordinate *location;

/// 可选。天气服务类型，默认国内
@property (nonatomic, assign) BMFWeatherServerType serverType;

/// 可选。请求数据类型，默认：BMFWeatherDataTypeNow
@property (nonatomic, assign) BMFWeatherDataType dataType;

/// 可选。语言类型，默认中文。目前仅支持海外天气服务行政区划显示英文。
@property (nonatomic, assign) BMFLanguageType languageType;

- (BMKWeatherSearchOption *)toBMKWeatherSearchOption;

@end


//#param mark - result

@interface BMFWeatherSearchNow : BMFModel

/// 相对湿度(%)
@property (nonatomic, assign) NSInteger relativeHumidity;

/// 体感温度(℃)
@property (nonatomic, assign) NSInteger sensoryTemp;

/// 天气现象
@property (nonatomic, copy) NSString *phenomenon;

/// 风向描述
@property (nonatomic, copy) NSString *windDirection;

/// 数据更新时间，北京时间
@property (nonatomic, copy) NSString *updateTime;

/// 温度（℃）
@property (nonatomic, assign) NSInteger temperature;

/// 风力等级
@property (nonatomic, copy) NSString *windPower;

/// 云量(%)，高级字段
@property (nonatomic, assign) NSInteger clouds;

/// 1小时累计降水量(mm)，高级字段
@property (nonatomic, assign) float hourlyPrecipitation;

/// 能见度(m)，高级字段
@property (nonatomic, assign) NSInteger visibility;

/// 臭氧浓度(μg/m3)，高级字段，仅国内支持
@property (nonatomic, assign) NSInteger O3;

/// pm2.5浓度(μg/m3)，高级字段，仅国内支持
@property (nonatomic, assign) NSInteger PM2_5;

/// 二氧化氮浓度(μg/m3)，高级字段，仅国内支持
@property (nonatomic, assign) NSInteger NO2;

/// 二氧化硫浓度(μg/m3)，高级字段，仅国内支持
@property (nonatomic, assign) NSInteger SO2;

/// 空气质量指数数值，高级字段，仅国内支持
@property (nonatomic, assign) NSInteger airQualityIndex;

/// pm10浓度(μg/m3)，高级字段，仅国内支持
@property (nonatomic, assign) NSInteger PM10;

/// 一氧化碳浓度(mg/m3)，高级字段，仅国内支持
@property (nonatomic, assign) float CO;

+ (instancetype)fromBMKWeatherSearchNow:(BMKWeatherSearchNow *)result;

@end

@interface BMFWeatherSearchLocation : BMFModel

/// 国家名称
@property (nonatomic, copy) NSString *country;

/// 省份名称
@property (nonatomic, copy) NSString *province;

/// 城市名称
@property (nonatomic, copy) NSString *city;

/// 区县名称
@property (nonatomic, copy) NSString *districtName;

/// 区县id
@property (nonatomic, copy) NSString *districtID;

+ (instancetype)fromBMKWeatherSearchLocation:(BMKWeatherSearchLocation *)result;

@end

@interface BMFWeatherSearchForecasts : BMFModel

/// 日期，北京时区
@property (nonatomic, copy) NSString *date;

/// 星期，北京时区
@property (nonatomic, copy) NSString *week;

/// 最低温度(℃)
@property (nonatomic, assign) NSInteger lowestTemp;

/// 最高温度(℃)
@property (nonatomic, assign) NSInteger highestTemp;

/// 白天风力
@property (nonatomic, copy) NSString *windPowerDay;

/// 晚上风力
@property (nonatomic, copy) NSString *windPowerNight;

/// 白天风向
@property (nonatomic, copy) NSString *windDirectionDay;

/// 晚上风向
@property (nonatomic, copy) NSString *windDirectionrNight;

/// 白天天气现象
@property (nonatomic, copy) NSString *phenomenonDay;

/// 晚上天气现象
@property (nonatomic, copy) NSString *phenomenonNight;

/// 空气质量指数数值，高级字段
@property (nonatomic, assign) NSInteger airQualityIndex;

+ (instancetype)fromBMKWeatherSearchForecasts:(BMKWeatherSearchForecasts *)result;

@end

@interface BMFWeatherSearchIndexes : BMFModel

/// 生活指数中文名称，高级字段
@property (nonatomic, copy) NSString *name;

/// 生活指数概要说明，高级字段
@property (nonatomic, copy) NSString *brief;

/// 生活指数详细说明，高级字段
@property (nonatomic, copy) NSString *detail;

+ (instancetype)fromBMKWeatherSearchIndexes:(BMKWeatherSearchIndexes *)result;

@end

@interface BMFWeatherSearchForecastForHours : BMFModel

/// 相对湿度(%)，高级字段
@property (nonatomic, assign) NSInteger relativeHumidity;

/// 数据时间，高级字段
@property (nonatomic, copy) NSString *dataTime;

/// 风向描述，高级字段
@property (nonatomic, copy) NSString *windDirection;

/// 风力等级，高级字段
@property (nonatomic, copy) NSString *windPower;

/// 温度(℃)，高级字段
@property (nonatomic, assign) NSInteger temperature;

/// 云量(%)，高级字段
@property (nonatomic, assign) NSInteger clouds;

/// 天气现象，高级字段
@property (nonatomic, copy) NSString *phenomenon;

/// 1小时累计降水量(mm)，高级字段
@property (nonatomic, assign) NSInteger hourlyPrecipitation;

+ (instancetype)fromBMKWeatherSearchForecastForHours:(BMKWeatherSearchForecastForHours *)result;

@end

@interface BMFWeatherSearchAlerts : BMFModel

/// 预警事件类型，高级字段
@property (nonatomic, copy) NSString *type;

/// 预警事件等级，高级字段
@property (nonatomic, copy) NSString *level;

/// 预警标题，高级字段
@property (nonatomic, copy) NSString *title;

/// 预警详细提示信息，高级字段
@property (nonatomic, copy) NSString *desc;

+ (instancetype)fromBMKWeatherSearchAlerts:(BMKWeatherSearchAlerts *)result;

@end


/// 注意：天气服务高级字段，需要申请高级权限
@interface BMFWeatherSearchResult : BMFModel

/// 天气实况数据
@property (nonatomic, strong) BMFWeatherSearchNow *realTimeWeather;

/// 地理位置信息
@property (nonatomic, strong) BMFWeatherSearchLocation *location;

/// 未来5天预报数据
@property (nonatomic, strong) NSArray <BMFWeatherSearchForecasts *> *forecasts;

/// 未来24小时逐小时预报，高级字段
@property (nonatomic, strong) NSArray <BMFWeatherSearchForecastForHours *> * forecastHours;

/// 生活指数数据，高级字段
@property (nonatomic, strong) NSArray <BMFWeatherSearchIndexes *> * lifeIndexes;

/// 气象预警数据，高级字段
@property (nonatomic, strong) NSArray <BMFWeatherSearchAlerts *> * weatherAlerts;

+ (instancetype)fromBMKWeatherSearchResult:(BMKWeatherSearchResult *)result;

@end

NS_ASSUME_NONNULL_END
