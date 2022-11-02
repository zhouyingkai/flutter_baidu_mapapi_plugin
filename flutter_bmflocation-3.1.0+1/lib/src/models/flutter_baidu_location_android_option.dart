import 'package:flutter_bmflocation/src/models/flutter_baidu_location_base_option.dart';

/// 设置android端定位参数类
class BaiduLocationAndroidOption extends BMFLocationBaseOption {
  /// 坐标系类型
  @Deprecated('已废弃since2.0.1，推荐使用 `coordType`')
  String? coorType;

  /// 是否需要返回地址信息
  bool? isNeedAddress;

  /// 是否需要返回海拔高度信息
  bool? isNeedAltitude;

  /// 是否需要返回周边poi信息
  bool? isNeedLocationPoiList;

  /// 是否需要返回新版本rgc信息
  bool? isNeedNewVersionRgc;

  /// 是否需要返回位置描述信息
  bool? isNeedLocationDescribe;

  /// 是否使用gps
  bool? openGps;

  /// 可选，设置发起定位请求的间隔，int类型，单位ms
  /// 如果设置为0，则代表单次定位，即仅定位一次，默认为0
  /// 如果设置非0，需设置1000ms以上才有效
  int? scanspan;

  /// 设置定位模式，可选的模式有高精度、仅设备、仅网络。默认为高精度模式
  BMFLocationMode? locationMode;

  /// 可选，设置场景定位参数，包括签到场景、运动场景、出行场景
  BMFLocationPurpose? locationPurpose;

  /// 可选，设置返回经纬度坐标类型，默认GCJ02
  void setCoorType(String coorType) {
    this.coorType = coorType;
  }

  /// 可选，设置返回经纬度坐标类型，默认gcj02
  void setCoordType(BMFLocationCoordType coordType) {
    this.coordType = coordType;
  }

  /// 是否需要返回地址信息
  void setIsNeedAddress(bool isNeedAddress) {
    this.isNeedAddress = isNeedAddress;
  }

  /// 是否需要返回海拔高度信息
  void setIsNeedAltitude(bool isNeedAltitude) {
    this.isNeedAltitude = isNeedAltitude;
  }

  /// 是否需要返回周边poi信息
  void setIsNeedLocationPoiList(bool isNeedLocationPoiList) {
    this.isNeedLocationPoiList = isNeedLocationPoiList;
  }

  /// 是否需要返回位置描述信息
  void setIsNeedLocationDescribe(bool isNeedLocationDescribe) {
    this.isNeedLocationDescribe = isNeedLocationDescribe;
  }

  /// 是否需要返回新版本rgc信息
  void setIsNeedNewVersionRgc(bool isNeedNewVersionRgc) {
    this.isNeedNewVersionRgc = isNeedNewVersionRgc;
  }

  /// 是否使用gps
  void setOpenGps(bool openGps) {
    this.openGps = openGps;
  }

  /// 可选，设置发起定位请求的间隔，int类型，单位ms
  /// 如果设置为0，则代表单次定位，即仅定位一次，默认为0
  /// 如果设置非0，需设置1000ms以上才有效
  void setScanspan(int scanspan) {
    this.scanspan = scanspan;
  }

  /// 设置定位模式，可选的模式有高精度、仅设备、仅网络，默认为高精度模式
  void setLocationMode(BMFLocationMode locationMode) {
    this.locationMode = locationMode;
  }

  /// 可选，设置场景定位参数，包括签到场景、运动场景、出行场景
  void setLocationPurpose(BMFLocationPurpose locationPurpose) {
    this.locationPurpose = locationPurpose;
  }

  /// 构造方法
  BaiduLocationAndroidOption({
    this.coorType,
    required BMFLocationCoordType coordType,
    this.isNeedAddress,
    this.isNeedAltitude,
    this.isNeedLocationPoiList,
    this.isNeedNewVersionRgc,
    this.isNeedLocationDescribe,
    this.openGps,
    this.scanspan = 0,
    this.locationMode = BMFLocationMode.hightAccuracy,
    this.locationPurpose = BMFLocationPurpose.other,
  }) : super(coordType: coordType);

  /// 获取对本类所有变量赋值后的map键值对
  Map<String, Object?> getMap() {
    return {
      "coorType": coorType,
      "coordType": coordType!.index,
      "isNeedAddress": isNeedAddress,
      "isNeedAltitude": isNeedAltitude,
      "isNeedLocationPoiList": isNeedLocationPoiList,
      "isNeedNewVersionRgc": isNeedNewVersionRgc,
      "openGps": openGps,
      "isNeedLocationDescribe": isNeedLocationDescribe,
      "scanspan": scanspan,
      "locationMode": locationMode?.index,
      "locationPurpose": locationPurpose?.index,
    };
  }
}

/// 定位模式枚举类
enum BMFLocationMode {
  /// 高精度模式
  hightAccuracy,

  /// 低功耗模式
  batterySaving,

  /// 仅设备(Gps)模式
  deviceSensors
}

/// 场景定位枚举类
enum BMFLocationPurpose {
  ///  签到场景
  /// 只进行一次定位返回最接近真实位置的定位结果（定位速度可能会延迟1-3s）
  signIn,

  /// 出行场景
  /// 高精度连续定位，适用于有户内外切换的场景，卫星定位和网络定位相互切换，卫星定位成功之后网络定位不再返回，卫星信号断开之后一段时间才会返回网络结果
  sport,

  /// 运动场景
  /// 高精度连续定位，适用于有户内外切换的场景，卫星定位和网络定位相互切换，卫星定位成功之后网络定位不再返回，卫星信号断开之后一段时间才会返回网络结果
  transport,

  ///其他类型
  other
}
