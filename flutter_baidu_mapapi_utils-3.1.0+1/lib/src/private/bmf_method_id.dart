/// 公共常量定义
class BMFUtilsConstants {
  /// utils基础通信channel
  static const kBaseMethodChannelName = 'flutter_bmfutils';
}

/// SDK调起百度地图客户端功能methodID
class BMFOpenMethodID {
  /// 调起客户端 -- 导航
  static const String kOpenBaiduMapNavi =
      BMFUtilsConstants.kBaseMethodChannelName + '/open/openBaiduMapNavi';

  /// 调起百度地图 -- 路线
  static const String kOpenBaiduMapRoute =
      BMFUtilsConstants.kBaseMethodChannelName + '/open/openBaiduMapRoute';

  /// 调起百度地图 -- poi详情
  static const String kOpenBaiduMapPoiDetail =
      BMFUtilsConstants.kBaseMethodChannelName + '/open/openBaiduMapPoiDetail';

  /// 调起百度地图 -- poi周边
  static const String kOpenBaiduMapPoiNear =
      BMFUtilsConstants.kBaseMethodChannelName + '/open/openBaiduMapPoiNear';

  /// 调起百度地图 -- 全景
  static const String kOpenBaiduMapPanorama =
      BMFUtilsConstants.kBaseMethodChannelName + '/open/openBaiduMapPanorama';
}

/// 计算methodID
class BMFCalculateMethodID {
  /// 坐标类型转换
  static const String kCoordTransType =
      BMFUtilsConstants.kBaseMethodChannelName + '/calculate/coordTransType';

  /// 坐标是否在polygon内
  static const String kPolygonContainsCoord =
      BMFUtilsConstants.kBaseMethodChannelName +
          '/calculate/polygonContainsCoord';

  /// 坐标是否在cirlce内
  static const String kCircleContainsCoord =
      BMFUtilsConstants.kBaseMethodChannelName +
          '/calculate/circleContainsCoord';

  /// 获取矢量坐标方向
  static const String kGetDirectionFromCoords =
      BMFUtilsConstants.kBaseMethodChannelName +
          '/calculate/getDirectionFromCoords';

  /// 计算地理矩形区域的面积
  static const String kAreaBetweenCoordinates =
      BMFUtilsConstants.kBaseMethodChannelName +
          '/calculate/areaBetweenCoordinates';

  /// 计算多边形面积
  static const String kCalculatePolygonArea =
      BMFUtilsConstants.kBaseMethodChannelName +
          '/calculate/calculatePolygonArea';

  /// 计算两点之间的距离
  static const String kLocationDistance =
      BMFUtilsConstants.kBaseMethodChannelName + '/calculate/locationDistance';

  /// 获取点到折线最近的点
  static const String kNearestPointToLine =
      BMFUtilsConstants.kBaseMethodChannelName +
          '/calculate/nearestPointToLine';

  /// 点到线段的垂足
  static const String kPointToTheVerticalFootOfLine =
      BMFUtilsConstants.kBaseMethodChannelName +
          '/calculate/pointToTheVerticalFootOfLine';
}
