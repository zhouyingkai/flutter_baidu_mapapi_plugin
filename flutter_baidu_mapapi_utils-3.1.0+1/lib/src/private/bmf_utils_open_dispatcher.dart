// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/services.dart';
import 'package:flutter_baidu_mapapi_utils/src/model/bmf_open_navi_options.dart';
import 'package:flutter_baidu_mapapi_utils/src/model/bmf_open_panorama_options.dart';
import 'package:flutter_baidu_mapapi_utils/src/model/bmf_open_poi_options.dart';
import 'package:flutter_baidu_mapapi_utils/src/model/bmf_open_route_options.dart';
import 'package:flutter_baidu_mapapi_utils/src/private/bmf_method_id.dart';
import 'package:flutter_baidu_mapapi_utils/src/utils/bmf_open_errorcode.dart';

/// utils调起客户端调度中心
class BMFUtilsOpenDispatcher {
  // static BMFUtilsOpenDispatcher _instance;
  // BMFUtilsOpenDispatcher._();
  // // BMFUtilsOpen();
  // factory BMFUtilsOpen() {
  //   if (_instance == null) {
  //     _instance = BMFUtilsOpenDispatcher._();
  //   }
  //   return _instance;
  // }

  /// 调起客户端导航
  static Future<BMFOpenErrorCode?> openBaiduMapNavi(
      MethodChannel _openChannel, BMFOpenNaviOption naviOption) async {
    if (_openChannel == null || naviOption == null) {
      return BMFOpenErrorCode.OPTION_NULL;
    }
    BMFOpenErrorCode? result;
    try {
      Map map = (await _openChannel.invokeMethod(
          BMFOpenMethodID.kOpenBaiduMapNavi,
          {'naviOption': naviOption.toMap()} as dynamic)) as Map;
      result = BMFOpenErrorCode.values[map['result'] as int];
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 调起客户端路线规划
  static Future<BMFOpenErrorCode?> openBaiduMapRoute(
      MethodChannel _openChannel, BMFOpenRouteOption routeOption) async {
    if (_openChannel == null || routeOption == null) {
      return BMFOpenErrorCode.OPTION_NULL;
    }
    BMFOpenErrorCode? result;
    try {
      Map map = (await _openChannel.invokeMethod(
          BMFOpenMethodID.kOpenBaiduMapRoute,
          {'routeOption': routeOption.toMap()} as dynamic)) as Map;
      result = BMFOpenErrorCode.values[map['result'] as int];
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 调起客户端poi详情
  static Future<BMFOpenErrorCode?> openBaiduMapPoiDetail(
      MethodChannel _openChannel,
      BMFOpenPoiDetailOption poiDetailOption) async {
    if (_openChannel == null || poiDetailOption == null) {
      return BMFOpenErrorCode.OPTION_NULL;
    }
    BMFOpenErrorCode? result;
    try {
      Map map = (await _openChannel.invokeMethod(
          BMFOpenMethodID.kOpenBaiduMapPoiDetail,
          {'poiDetailOption': poiDetailOption.toMap()} as dynamic)) as Map;
      result = BMFOpenErrorCode.values[map['result'] as int];
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 调起客户端poi周边
  static Future<BMFOpenErrorCode?> openBaiduMapPoiNear(
      MethodChannel _openChannel, BMFOpenPoiNearOption poiNearOption) async {
    if (_openChannel == null || poiNearOption == null) {
      return BMFOpenErrorCode.OPTION_NULL;
    }
    BMFOpenErrorCode? result;
    try {
      Map map = (await _openChannel.invokeMethod(
          BMFOpenMethodID.kOpenBaiduMapPoiNear,
          {'poiNearOption': poiNearOption.toMap()} as dynamic)) as Map;
      result = BMFOpenErrorCode.values[map['result'] as int];
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 调起百度地图全景图
  static Future<BMFOpenErrorCode?> openBaiduMapPanorama(
      MethodChannel _openChannel, BMFOpenPanoramaOption panoramaOption) async {
    if (_openChannel == null || panoramaOption == null) {
      return BMFOpenErrorCode.OPTION_NULL;
    }
    BMFOpenErrorCode? result;
    try {
      Map map = (await _openChannel.invokeMethod(
          BMFOpenMethodID.kOpenBaiduMapPanorama,
          {'panoramaOption': panoramaOption.toMap()} as dynamic)) as Map;
      result = BMFOpenErrorCode.values[map['result'] as int];
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }
}
