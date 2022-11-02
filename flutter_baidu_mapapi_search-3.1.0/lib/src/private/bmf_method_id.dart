/// search公共常量定义
class BMFSearhConstants {
  /// search基础通信channel
  static const kSearhMethodChannelName = 'flutter_bmfsearch';
}

/// poi检索方法id
class BMFPoiSearchMethodID {
  /// 城市POI检索
  static const String kPoiSearchInCity =
      BMFSearhConstants.kSearhMethodChannelName + '/poiSearch/poiSearchInCity';

  /// 根据范围和检索词发起范围检索
  static const String kPoiSearchInbounds =
      BMFSearhConstants.kSearhMethodChannelName +
          '/poiSearch/poiSearchInbounds';

  /// 根据中心点、半径和检索词发起周边检索
  static const String kPoiSearchNearBy =
      BMFSearhConstants.kSearhMethodChannelName + '/poiSearch/poiSearchNearBy';

  /// 根据poi uid 发起poi详情检索
  static const String kPoiDetailSearch =
      BMFSearhConstants.kSearhMethodChannelName + '/poiSearch/poiDetailSearch';

  /// poi室内检索
  static const String kPoiIndoorSearch =
      BMFSearhConstants.kSearhMethodChannelName + '/poiSearch/poiIndoorSearch';
}

/// 地理编码方法id
class BMFGeoAndReverseGeoMethodID {
  /// 地理编码： 根据地址名称获取地理信息
  static const String kGeoCode =
      BMFSearhConstants.kSearhMethodChannelName + '/geoSearch/geoCode';

  /// 反编码：根据地理坐标获取地址信息
  static const String kReverseGeoCode =
      BMFSearhConstants.kSearhMethodChannelName + '/geoSearch/reverseGeoCode';
}

/// 行政区域搜索服务方法id
class BMFDistrictSearchMethodID {
  static const String kDistrictSearch =
      BMFSearhConstants.kSearhMethodChannelName +
          '/districtSearch/districtSearch';
}

/// 公交详情搜索服务方法id
class BMFBusLineSearchMethodID {
  static const String kBusLineSearch =
      BMFSearhConstants.kSearhMethodChannelName +
          '/busLineSearch/busLineSearch';
}

/// 路线规划服务方法id
class BMFRouteSearchMethodID {
  /// 公交路线检索（仅支持市内）
  static const String kTransitRoutePlan =
      BMFSearhConstants.kSearhMethodChannelName + '/routeSearch/transitSearch';

  /// 公共交通路线检索（new）（支持市内和跨城）
  static const String kMassTransitRoutePlan =
      BMFSearhConstants.kSearhMethodChannelName +
          '/routeSearch/massTransitSearch';

  /// 驾乘路线检索
  static const String kDrivingRoutePlan =
      BMFSearhConstants.kSearhMethodChannelName + '/routeSearch/drivingSearch';

  /// 步行路线检索
  static const String kWalkingRoutePlan =
      BMFSearhConstants.kSearhMethodChannelName + '/routeSearch/walkingSearch';

  /// 骑行路线检索
  static const String kRidingRoutePlan =
      BMFSearhConstants.kSearhMethodChannelName + '/routeSearch/ridingSearch';

  /// 室内路线检索
  static const String kIndoorRoutePlanSearch =
      BMFSearhConstants.kSearhMethodChannelName +
          '/routeSearch/indoorRoutePlanSearch';
}

/// 短串搜索服务方法id
class BMFShareURLSearchMethodID {
  /// 获取poi详情短串分享url
  static const String kRequestPoiDetailShareURL =
      BMFSearhConstants.kSearhMethodChannelName +
          '/shareURL/requestPoiDetailShareURL';

  /// 获取反geo短串分享url
  static const String kRequestLocationShareURL =
      BMFSearhConstants.kSearhMethodChannelName +
          '/shareURL/requestLocationShareURL';

  /// 获取路线规划短串分享url
  static const String kRequestRoutePlanShareURL =
      BMFSearhConstants.kSearhMethodChannelName +
          '/shareURL/requestRoutePlanShareURL';
}

/// sug搜索服务方法id
class BMFSuggestionSearchMethodID {
  /// 获取路线规划短串分享url
  static const String kSuggestionSearch =
      BMFSearhConstants.kSearhMethodChannelName +
          '/suggestionSearch/suggestionSearch';
}

/// 推荐上车点服务方法id
class BMFRecommendStopSearchMethodID {
  static const String kRecommendStopSearch =
      BMFSearhConstants.kSearhMethodChannelName +
          '/recommendStopSearch/recommendStopSearch';
}

/// 天气检索服务id
class BMFWeatherSearchMethodID {
  static const String kWeatherSearch =
      BMFSearhConstants.kSearhMethodChannelName +
          '/weatherSearch/weatherSearch';
}

/// 建筑物检索服务id
class BMFBuildingSearchMethodID {
  static const String kBuildingSearch =
      BMFSearhConstants.kSearhMethodChannelName +
          '/buildingSearch/buildingSearch';
}
