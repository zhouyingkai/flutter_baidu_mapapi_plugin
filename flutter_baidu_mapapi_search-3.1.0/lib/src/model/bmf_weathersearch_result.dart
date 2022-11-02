import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';

/// 注意：天气服务高级字段，需要申请高级权限
/// http://lbsyun.baidu.com/apiconsole/fankui#?typeOne=产品需求&typeTwo=高级服务
class BMFWeatherSearchResult implements BMFModel {
  /// 天气实况数据
  BMFWeatherSearchNow? realTimeWeather;

  /// 地理位置信息
  BMFWeatherSearchLocation? location;

  /// 未来5天预报数据
  List<BMFWeatherSearchForecasts>? forecasts;

  /// 未来24小时逐小时预报，高级字段
  List<BMFWeatherSearchForecastForHours>? forecastHours;

  /// 生活指数数据，高级字段
  List<BMFWeatherSearchIndexes>? lifeIndexes;

  /// 气象预警数据，高级字段
  List<BMFWeatherSearchAlerts>? weatherAlerts;

  /// 有参构造
  BMFWeatherSearchResult({
    this.realTimeWeather,
    this.location,
    this.forecasts,
    this.forecastHours,
    this.lifeIndexes,
    this.weatherAlerts,
  });

  /// map => BMFWeatherSearchResult
  BMFWeatherSearchResult.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFWeatherSearchResult，The parameter map cannot be null !') {
    realTimeWeather = map['realTimeWeather'] == null
        ? null
        : BMFWeatherSearchNow.fromMap(map['realTimeWeather']);
    location = map['location'] == null
        ? null
        : BMFWeatherSearchLocation.fromMap(map['location']);

    if (map['forecasts'] != null) {
      List<BMFWeatherSearchForecasts> tmpForecasts = [];
      map['forecasts'].forEach((v) {
        tmpForecasts.add(BMFWeatherSearchForecasts.fromMap(v as Map));
      });
      forecasts = tmpForecasts;
    }

    if (map['forecastHours'] != null) {
      List<BMFWeatherSearchForecastForHours> tmpForecastHours = [];
      map['forecastHours'].forEach((v) {
        tmpForecastHours
            .add(BMFWeatherSearchForecastForHours.fromMap(v as Map));
      });
      forecastHours = tmpForecastHours;
    }

    if (map['lifeIndexes'] != null) {
      List<BMFWeatherSearchIndexes> tmpLifeIndexes = [];
      map['lifeIndexes'].forEach((v) {
        tmpLifeIndexes.add(BMFWeatherSearchIndexes.fromMap(v as Map));
      });
      lifeIndexes = tmpLifeIndexes;
    }

    if (map['weatherAlerts'] != null) {
      List<BMFWeatherSearchAlerts> tmpWeatherAlerts = [];
      map['weatherAlerts'].forEach((v) {
        tmpWeatherAlerts.add(BMFWeatherSearchAlerts.fromMap(v as Map));
      });
      weatherAlerts = tmpWeatherAlerts;
    }
  }

  @override
  fromMap(Map map) {
    return BMFWeatherSearchResult.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'realTimeWeather': this.realTimeWeather?.toMap(),
      'location': this.location?.toMap(),
      'forecasts': this.forecasts?.map((e) => e.toMap()).toList(),
      'forecastHours': this.forecastHours?.map((e) => e.toMap()).toList(),
      'lifeIndexes': this.lifeIndexes?.map((e) => e.toMap()).toList(),
      'weatherAlerts': this.weatherAlerts?.map((e) => e.toMap()).toList()
    };
  }
}

class BMFWeatherSearchNow implements BMFModel {
  /// 相对湿度(%)
  int? relativeHumidity;

  /// 体感温度(℃)
  int? sensoryTemp;

  /// 天气现象
  String? phenomenon;

  /// 风向描述
  String? windDirection;

  /// 数据更新时间，北京时间
  String? updateTime;

  /// 温度（℃）
  int? temperature;

  /// 风力等级
  String? windPower;

  /// 云量(%)，高级字段
  int? clouds;

  /// 1小时累计降水量(mm)，高级字段
  double? hourlyPrecipitation;

  /// 能见度(m)，高级字段
  int? visibility;

  /// 臭氧浓度(μg/m3)，高级字段，仅国内支持
  int? O3;

  /// pm2.5浓度(μg/m3)，高级字段，仅国内支持
  int? PM2_5;

  /// 二氧化氮浓度(μg/m3)，高级字段，仅国内支持
  int? NO2;

  /// 二氧化硫浓度(μg/m3)，高级字段，仅国内支持
  int? SO2;

  /// 空气质量指数数值，高级字段，仅国内支持
  int? airQualityIndex;

  /// pm10浓度(μg/m3)，高级字段，仅国内支持
  int? PM10;

  /// 一氧化碳浓度(mg/m3)，高级字段，仅国内支持
  double? CO;

  /// 有参构造
  BMFWeatherSearchNow({
    this.relativeHumidity,
    this.sensoryTemp,
    this.phenomenon,
    this.windDirection,
    this.updateTime,
    this.temperature,
    this.windPower,
    this.clouds,
    this.hourlyPrecipitation,
    this.visibility,
    this.O3,
    this.PM2_5,
    this.NO2,
    this.SO2,
    this.airQualityIndex,
    this.PM10,
    this.CO,
  });

  /// map => BMFWeatherSearchNow
  BMFWeatherSearchNow.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFWeatherSearchNow，The parameter map cannot be null !') {
    relativeHumidity = map['relativeHumidity'];
    sensoryTemp = map['sensoryTemp'];
    phenomenon = map['phenomenon'];
    windDirection = map['windDirection'];
    updateTime = map['updateTime'];
    temperature = map['temperature'];
    windPower = map['windPower'];
    clouds = map['clouds'];
    hourlyPrecipitation = map['hourlyPrecipitation'];
    visibility = map['visibility'];
    O3 = map['O3'];
    PM2_5 = map['PM2_5'];
    NO2 = map['NO2'];
    SO2 = map['SO2'];
    airQualityIndex = map['airQualityIndex'];
    PM10 = map['PM10'];
    CO = map['CO'];
  }

  @override
  fromMap(Map map) {
    return BMFWeatherSearchNow.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'relativeHumidity': this.relativeHumidity,
      'sensoryTemp': this.sensoryTemp,
      'phenomenon': this.phenomenon,
      'windDirection': this.windDirection,
      'updateTime': this.updateTime,
      'temperature': this.temperature,
      'windPower': this.windPower,
      'clouds': this.clouds,
      'hourlyPrecipitation': this.hourlyPrecipitation,
      'visibility': this.visibility,
      'O3': this.O3,
      'PM2_5': this.PM2_5,
      'NO2': this.NO2,
      'SO2': this.SO2,
      'airQualityIndex': this.airQualityIndex,
      'PM10': this.PM10,
      'CO': this.CO
    };
  }
}

class BMFWeatherSearchLocation implements BMFModel {
  /// 国家名称
  String? country;

  /// 省份名称
  String? province;

  /// 城市名称
  String? city;

  /// 区县名称
  String? districtName;

  /// 区县id
  String? districtID;

  /// 有参构造
  BMFWeatherSearchLocation({
    this.country,
    this.province,
    this.city,
    this.districtName,
    this.districtID,
  });

  /// map => BMFWeatherSearchLocation
  BMFWeatherSearchLocation.fromMap(Map map)
      : assert(
            // ignore: unnecessary_null_comparison
            map != null,
            'Construct a BMFWeatherSearchLocation，The parameter map cannot be null !') {
    country = map['country'];
    province = map['province'];
    city = map['city'];
    districtName = map['districtName'];
    districtID = map['districtID'];
  }

  @override
  fromMap(Map map) {
    return BMFWeatherSearchLocation.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'country': this.country,
      'province': this.province,
      'city': this.city,
      'districtName': this.districtName,
      'districtID': this.districtID
    };
  }
}

class BMFWeatherSearchForecasts implements BMFModel {
  /// 日期，北京时区
  String? date;

  /// 星期，北京时区
  String? week;

  /// 最低温度(℃)
  int? lowestTemp;

  /// 最高温度(℃)
  int? highestTemp;

  /// 白天风力
  String? windPowerDay;

  /// 晚上风力
  String? windPowerNight;

  /// 白天风向
  String? windDirectionDay;

  /// 晚上风向
  String? windDirectionrNight;

  /// 白天天气现象
  String? phenomenonDay;

  /// 晚上天气现象
  String? phenomenonNight;

  /// 空气质量指数数值，高级字段
  int? airQualityIndex;

  /// 有参构造
  BMFWeatherSearchForecasts({
    this.date,
    this.week,
    this.lowestTemp,
    this.highestTemp,
    this.windPowerDay,
    this.windPowerNight,
    this.windDirectionDay,
    this.windDirectionrNight,
    this.phenomenonDay,
    this.phenomenonNight,
    this.airQualityIndex,
  });

  /// map => BMFWeatherSearchForecasts
  BMFWeatherSearchForecasts.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFWeatherSearchForecasts，The parameter map cannot be null !') {
    date = map['date'];
    week = map['week'];
    lowestTemp = map['lowestTemp'];
    highestTemp = map['highestTemp:'];
    windPowerDay = map['windPowerDay'];
    windPowerNight = map['windPowerNight'];
    windDirectionDay = map['windDirectionDay'];
    windDirectionrNight = map['windDirectionrNight'];
    phenomenonDay = map['phenomenonDay'];
    phenomenonNight = map['phenomenonNight'];
    airQualityIndex = map['airQualityIndex'];
  }

  @override
  fromMap(Map map) {
    return BMFWeatherSearchForecasts.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'date': this.date,
      'week': this.week,
      'lowestTemp': this.lowestTemp,
      'highestTemp': this.highestTemp,
      'windPowerDay': this.windPowerDay,
      'windPowerNight': this.windPowerNight,
      'windDirectionDay': this.windDirectionDay,
      'windDirectionrNight': this.windDirectionrNight,
      'phenomenonDay': this.phenomenonDay,
      'phenomenonNight': this.phenomenonNight,
      'airQualityIndex': this.airQualityIndex
    };
  }
}

class BMFWeatherSearchIndexes implements BMFModel {
  /// 生活指数中文名称，高级字段
  String? name;

  /// 生活指数概要说明，高级字段
  String? brief;

  /// 生活指数详细说明，高级字段
  String? detail;

  /// 有参构造
  BMFWeatherSearchIndexes({this.name, this.brief, this.detail});

  /// map => BMFWeatherSearchIndexes
  BMFWeatherSearchIndexes.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFWeatherSearchIndexes，The parameter map cannot be null !') {
    name = map['name'];
    brief = map['brief'];
    detail = map['detail'];
  }

  @override
  fromMap(Map map) {
    return BMFWeatherSearchIndexes.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {'name': this.name, 'brief': this.brief, 'detail': this.detail};
  }
}

class BMFWeatherSearchForecastForHours implements BMFModel {
  /// 相对湿度(%)，高级字段
  int? relativeHumidity;

  /// 数据时间，高级字段
  String? dataTime;

  /// 风向描述，高级字段
  String? windDirection;

  /// 风力等级，高级字段
  String? windPower;

  /// 温度(℃)，高级字段
  int? temperature;

  /// 云量(%)，高级字段
  int? clouds;

  /// 天气现象，高级字段
  String? phenomenon;

  /// 1小时累计降水量(mm)，高级字段
  int? hourlyPrecipitation;

  ///有参构造
  BMFWeatherSearchForecastForHours({
    this.relativeHumidity,
    this.dataTime,
    this.windDirection,
    this.windPower,
    this.temperature,
    this.clouds,
    this.phenomenon,
    this.hourlyPrecipitation,
  });

  /// map => BMFWeatherSearchForecastForHours
  BMFWeatherSearchForecastForHours.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFWeatherSearchForecastForHours，The parameter map cannot be null !') {
    relativeHumidity = map['relativeHumidity'];
    dataTime = map['dataTime'];
    windDirection = map['windDirection'];
    windPower = map['windPower'];
    temperature = map['temperature'];
    clouds = map['clouds'];
    phenomenon = map['phenomenon'];
    hourlyPrecipitation = map['hourlyPrecipitation'];
  }

  @override
  fromMap(Map map) {
    return BMFWeatherSearchForecastForHours.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'relativeHumidity': this.relativeHumidity,
      'dataTime': this.dataTime,
      'windDirection': this.windDirection,
      'windPower': this.windPower,
      'temperature': this.temperature,
      'clouds': this.clouds,
      'phenomenon': this.phenomenon,
      'hourlyPrecipitation': this.hourlyPrecipitation
    };
  }
}

class BMFWeatherSearchAlerts implements BMFModel {
  /// 预警事件类型，高级字段
  String? type;

  /// 预警事件等级，高级字段
  String? level;

  /// 预警标题，高级字段
  String? title;

  /// 预警详细提示信息，高级字段
  String? desc;

  /// 有参构造
  BMFWeatherSearchAlerts({this.type, this.level, this.title, this.desc});

  /// map => BMFWeatherSearchAlerts
  BMFWeatherSearchAlerts.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFWeatherSearchAlerts，The parameter map cannot be null !') {
    type = map['type'];
    level = map['level'];
    desc = map['desc'];
  }

  @override
  fromMap(Map map) {
    return BMFWeatherSearchAlerts.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {'type': this.type, 'level': this.level, 'desc': this.desc};
  }
}
