import 'flutter_baidu_location_base_option.dart';

/// 设置ios端定位参数类
class BaiduLocationIOSOption extends BMFLocationBaseOption {
  /// 设置位置获取超时时间
  int? locationTimeout;

  /// 设置获取地址信息超时时间
  int? reGeocodeTimeout;

  /// 设置应用位置类型 默认为automotiveNavigation
  BMFActivityType? activityType;

  /// 设置返回位置的坐标系类型
  @Deprecated('已废弃since2.0.1，推荐使用 `coordType`')
  String? BMKLocationCoordinateType;

  /// 设置返回位置的坐标系类型 默认为gcj02

  /// 设置预期精度参数 默认为best
  BMFDesiredAccuracy? desiredAccuracy;

  /// 是否需要最新版本rgc数据
  bool? isNeedNewVersionRgc;

  /// 指定定位是否会被系统自动暂停
  bool? pausesLocationUpdatesAutomatically;

  /// 指定是否允许后台定位,
  /// 允许的话是可以进行后台定位的，但需要项目配置允许后台定位，否则会报错，具体参考开发文档
  bool? allowsBackgroundLocationUpdates;

  /// 设定定位的最小更新距离
  double? distanceFilter;

  /// 指定是否允许后台定位
  /// allowsBackgroundLocationUpdates为true则允许后台定位
  /// allowsBackgroundLocationUpdates为false则不允许后台定位
  void setAllowsBackgroundLocationUpdates(
      bool allowsBackgroundLocationUpdates) {
    this.allowsBackgroundLocationUpdates = allowsBackgroundLocationUpdates;
  }

  /// 指定定位是否会被系统自动暂停
  /// pausesLocationUpdatesAutomatically为true则定位会被系统自动暂停
  /// pausesLocationUpdatesAutomatically为false则定位不会被系统自动暂停
  void setPauseLocUpdateAutomatically(bool pausesLocationUpdatesAutomatically) {
    this.pausesLocationUpdatesAutomatically =
        pausesLocationUpdatesAutomatically;
  }

  /// 设置位置获取超时时间
  void setLocationTimeout(int locationTimeout) {
    this.locationTimeout = locationTimeout;
  }

  /// 设置获取地址信息超时时间
  void setReGeocodeTimeout(int reGeocodeTimeout) {
    this.reGeocodeTimeout = reGeocodeTimeout;
  }

  /// 设置应用位置类型
  void setActivityType(BMFActivityType activityType) {
    this.activityType = activityType;
  }

  /// 设置返回位置的坐标系类型
  @Deprecated('已废弃since2.0.1，推荐使用 `coordType`')
  void setBMKLocationCoordinateType(String BMKLocationCoordinateType) {
    this.BMKLocationCoordinateType = BMKLocationCoordinateType;
  }

  /// 设置预期精度参数
  void setDesiredAccuracy(BMFDesiredAccuracy desiredAccuracy) {
    this.desiredAccuracy = desiredAccuracy;
  }

  /// 设定定位的最小更新距离
  void setDistanceFilter(double distanceFilter) {
    this.distanceFilter = distanceFilter;
  }

  /// 是否需要最新版本rgc数据
  /// isNeedNewVersionRgc为true则需要返回最新版本rgc数据
  /// isNeedNewVersionRgc为false则不需要返回最新版本rgc数据
  void setIsNeedNewVersionRgc(bool isNeedNewVersionRgc) {
    this.isNeedNewVersionRgc = isNeedNewVersionRgc;
  }

  /// 构造方法
  BaiduLocationIOSOption({
    this.BMKLocationCoordinateType,
    required BMFLocationCoordType coordType,
    this.locationTimeout,
    this.allowsBackgroundLocationUpdates = false,
    this.reGeocodeTimeout,
    this.activityType = BMFActivityType.automotiveNavigation,
    this.distanceFilter,
    this.desiredAccuracy = BMFDesiredAccuracy.best,
    this.isNeedNewVersionRgc,
    this.pausesLocationUpdatesAutomatically,
  }) : super(coordType: coordType);

  /// 获取对本类所有变量赋值后的map键值对
  Map<String, Object?> getMap() {
    return {
      "locationTimeout": locationTimeout,
      "reGeocodeTimeout": reGeocodeTimeout,
      "activityType": activityType?.index,
      "BMKLocationCoordinateType": BMKLocationCoordinateType,
      "coordType": coordType!.index,
      "desiredAccuracy": desiredAccuracy?.index,
      "isNeedNewVersionRgc": isNeedNewVersionRgc,
      "pausesLocationUpdatesAutomatically": pausesLocationUpdatesAutomatically,
      "allowsBackgroundLocationUpdates": allowsBackgroundLocationUpdates,
      "distanceFilter": distanceFilter,
    };
  }
}

///对应iOS中CLLocationAccuracy类型
enum BMFDesiredAccuracy {
  best,
  bestForNavigation,
  nearestTenMeters,
  kilometer,
  threeKilometers,
}

//对应iOS中CLActivityType类型
enum BMFActivityType {
  other,
  automotiveNavigation,
  fitness,
  otherNavigation,
  airborne,
}
