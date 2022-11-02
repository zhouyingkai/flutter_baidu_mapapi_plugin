import 'package:flutter/services.dart';
import 'package:flutter_baidu_mapapi_utils/src/model/bmf_open_navi_options.dart';
import 'package:flutter_baidu_mapapi_utils/src/model/bmf_open_panorama_options.dart';
import 'package:flutter_baidu_mapapi_utils/src/model/bmf_open_poi_options.dart';
import 'package:flutter_baidu_mapapi_utils/src/model/bmf_open_route_options.dart';
import 'package:flutter_baidu_mapapi_utils/src/private/bmf_utils_open_dispatcher.dart';
import 'package:flutter_baidu_mapapi_utils/src/utils/bmf_open_errorcode.dart';

/// 打开地图客户端接口
class BMFOpenMapUtils {
  static const MethodChannel _openChannel =
      const MethodChannel('flutter_bmfutils/open');

  /// 调起客户端导航
  ///
  /// [BMFOpenErrorCode] 调起百度地图结果状态码
  static Future<BMFOpenErrorCode?> openBaiduMapNavi(
      BMFOpenNaviOption naviOption) async {
    return await BMFUtilsOpenDispatcher.openBaiduMapNavi(
        _openChannel, naviOption);
  }

  /// 调起客户端路线规划
  ///
  /// [BMFOpenErrorCode] 调起百度地图结果状态码
  static Future<BMFOpenErrorCode?> openBaiduMapRoute(
      BMFOpenRouteOption routeOption) async {
    return await BMFUtilsOpenDispatcher.openBaiduMapRoute(
        _openChannel, routeOption);
  }

  /// 调起客户端poi详情
  ///
  /// [BMFOpenErrorCode] 调起百度地图结果状态码
  static Future<BMFOpenErrorCode?> openBaiduMapPoiDetail(
      BMFOpenPoiDetailOption poiDetailOption) async {
    return await BMFUtilsOpenDispatcher.openBaiduMapPoiDetail(
        _openChannel, poiDetailOption);
  }

  /// 调起客户端poi周边
  ///
  /// [BMFOpenErrorCode] 调起百度地图结果状态码
  static Future<BMFOpenErrorCode?> openBaiduMapPoiNear(
      BMFOpenPoiNearOption poiNearOption) async {
    return await BMFUtilsOpenDispatcher.openBaiduMapPoiNear(
        _openChannel, poiNearOption);
  }

  /// 调起百度地图全景图
  ///
  /// [BMFOpenErrorCode] 调起百度地图结果状态码
  static Future<BMFOpenErrorCode?> openBaiduMapPanorama(
      BMFOpenPanoramaOption panoramaOption) async {
    return await BMFUtilsOpenDispatcher.openBaiduMapPanorama(
        _openChannel, panoramaOption);
  }
}
