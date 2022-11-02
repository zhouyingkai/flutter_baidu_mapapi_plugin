/// 调起百度地图结果状态码
enum BMFOpenErrorCode {
  /// 正常
  NO_ERROR,

  /// 打开的是web地图
  WEB_MAP,

  /// 传入的参数为空
  OPTION_NULL,

  /// 没有安装百度地图，或者版本太低
  NOT_SUPPORT,

  /// poi详情 poiUid为空
  POI_DETAIL_UID_NULL,

  /// poi周边 keyWord为空
  POI_NEARBY_KEYWORD_NULL,

  /// 路线起点有误
  ROUTE_START_ERROR,

  /// 路线终点有误
  ROUTE_END_ERROR,

  /// 调起全景 poiUid不正确
  PANORAMA_UID_ERROR,

  /// 调起全景 此处不支持全景
  PANORAMA_ABSENT,

  ///还未完成鉴权，请在鉴权通过后重试
  PERMISSION_UNFINISHED,

  /// app key错误
  KEY_ERROR,

  /// 网络连接错误
  NETWOKR_ERROR,

  /// 其它错误
  OTHER_ERROR,

  /// 参数错误
  OPTION_ERROR
}
