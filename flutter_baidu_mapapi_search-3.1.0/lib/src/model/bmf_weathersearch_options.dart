import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFModel, BMFCoordinate;

/// 天气服务类型枚举
enum BMFWeatherServerType {
  /// 国内
  Default,

  /// 海外
  Abroad
}

/// 天气数据类型枚举
enum BMFWeatherDataType {
  /// 实时天气预报
  Now,

  /// 未来五天天气预报
  Forecasts,

  /// 按小时天气预报，高级字段
  ForecastsForHour,

  /// 生活指数，仅支持国内，高级字段
  LifeIndex,

  /// 天气事件预警，仅支持国内，高级字段
  Alert,

  /// 以上全部，高级字段获取对应权限后可返回
  All
}

/// 语言类型枚举
enum BMFLanguageType {
  /// 中文
  Chinese,

  /// 英文
  English
}

/// 开通高级权限： http://lbsyun.baidu.com/apiconsole/fankui#?typeOne=产品需求&typeTwo=高级服务
/// 国内行政区域编码表：https://mapopen-website-wiki.cdn.bcebos.com/cityList/weather_district_id.csv
/// 海外行政区域编码表：https://mapopen-website-wiki.cdn.bcebos.com/cityList/weather_aboard_district_id.xlsx
/// 天气取值对照表：https://mapopen-website-wiki.cdn.bcebos.com/cityList/百度地图天气取值对照表(0410).xlsx
class BMFWeatherSearchOption implements BMFModel {
  /// 必选。区县的行政区划编码，和location二选一
  String? districtID;

  /// 必选。经纬度，高级字段，需要申请高级权限
  BMFCoordinate? location;

  /// 可选。天气服务类型，默认国内
  BMFWeatherServerType? serverType;

  /// 可选。请求数据类型，默认：BMFWeatherDataTypeNow
  BMFWeatherDataType? dataType;

  /// 可选。语言类型，默认中文。目前仅支持海外天气服务行政区划显示英文。
  BMFLanguageType? languageType;

  /// 有参构造
  BMFWeatherSearchOption({
    required this.districtID,
    this.location,
    this.serverType: BMFWeatherServerType.Default,
    this.dataType: BMFWeatherDataType.Now,
    this.languageType: BMFLanguageType.Chinese,
  });

  /// map => BMFWeatherSearchOption
  BMFWeatherSearchOption.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFWeatherSearchOption，The parameter map cannot be null !') {
    districtID = map['districtID'];
    location =
        map['location'] == null ? null : BMFCoordinate.fromMap(map['location']);
    serverType = BMFWeatherServerType.values[map['serverType'] as int];
    dataType = BMFWeatherDataType.values[map['dataType'] as int];
    languageType = BMFLanguageType.values[map['languageType'] as int];
  }

  @override
  fromMap(Map map) {
    return BMFWeatherSearchOption.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'districtID': this.districtID,
      'location': this.location?.toMap(),
      'serverType': this.serverType?.index,
      'dataType': this.dataType?.index,
      'languageType': this.languageType?.index
    };
  }
}
