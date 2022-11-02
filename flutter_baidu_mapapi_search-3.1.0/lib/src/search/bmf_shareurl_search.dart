import 'package:flutter_baidu_mapapi_search/src/model/bmf_shareurlsearch_options.dart';
import 'package:flutter_baidu_mapapi_search/src/model/bmf_shareurlsearch_result.dart';
import 'package:flutter_baidu_mapapi_search/src/private/bmf_shareurlsearch_dispatcher.dart';
import 'package:flutter_baidu_mapapi_search/src/search/bmf_search_errorcode.dart';

/// 获取poi详情短串分享url
class BMFPoiDetailShareUrlSearch {
  /// 短串服务实例
  late BMFShareurlSearchDispatcher _shareurlSearchDispatcher;

  /// 无参构造
  BMFPoiDetailShareUrlSearch() {
    _shareurlSearchDispatcher = BMFShareurlSearchDispatcher();
  }

  /// 获取poi详情短串分享url
  ///
  /// onGetPoiDetailShareURLResult 通知回调结果MFShareURLResult
  /// poiDetailShareUrlSearchOption poi详情短串分享检索信息类
  /// 请求发送成功返回true，否则返回false
  Future<bool> poiDetailShareUrlSearch(
      BMFPoiDetailShareURLOption poiDetailShareURLOption) async {
    return await _shareurlSearchDispatcher
        .poiDetailShareUrlSearchDispatcher(poiDetailShareURLOption);
  }

  /// poi详情短串分享url回调结果
  void onGetPoiDetailShareURLResult(
      {required
          void Function(BMFShareURLResult result, BMFSearchErrorCode errorCode)
              callback}) {
    _shareurlSearchDispatcher.onGetPoiDetailShareURLResultCallback(callback);
  }
}

/// 获取逆地理编码短串分享url
class BMFReverseGeoShareUrlSearch {
  late BMFShareurlSearchDispatcher _shareurlSearchDispatcher;

  /// 无参构造
  BMFReverseGeoShareUrlSearch() {
    _shareurlSearchDispatcher = BMFShareurlSearchDispatcher();
  }

  /// 获取反geo短串分享url
  ///
  /// onGetReverseGeoShareURLResult 通知回调结果MFShareURLResult
  /// reverseGeoShareUrlSearchOption 反geo短串分享检索信息类
  /// 请求发送成功返回true，否则返回false
  Future<bool> reverseGeoShareUrlSearch(
      BMFReverseGeoShareURLOption reverseGeoShareURLOption) async {
    return await _shareurlSearchDispatcher
        .reverseGeoShareUrlSearchDispatcher(reverseGeoShareURLOption);
  }

  /// 反geo短串分享url回调结果
  void onGetReverseGeoShareURLResult(
      {required void Function(
              BMFShareURLResult result, BMFSearchErrorCode errorCode)
          callback}) {
    _shareurlSearchDispatcher.onGetReverseGeoShareURLResultCallback(callback);
  }
}

/// 获取路线规划短串分享url
class BMFRoutePlanShareUrlSearch {
  late BMFShareurlSearchDispatcher _shareurlSearchDispatcher;

  /// 无参构造
  BMFRoutePlanShareUrlSearch() {
    _shareurlSearchDispatcher = BMFShareurlSearchDispatcher();
  }

  /// 获取路线规划短串分享url
  ///
  /// onGetRoutePlanShareURLResult 通知回调结果MFShareURLResult
  /// routePlanShareUrlSearchOption 取路线规划短串分享检索信息类
  /// 请求发送成功返回true，否则返回false
  Future<bool> routePlanShareUrlSearch(
      BMFRoutePlanShareURLOption routePlanShareURLOption) async {
    return await _shareurlSearchDispatcher
        .routePlanShareUrlSearchDispatcher(routePlanShareURLOption);
  }

  /// 路线规划短串分享url回调结果闭包
  void onGetRoutePlanShareURLResult(
      {required void Function(
              BMFShareURLResult result, BMFSearchErrorCode errorCode)
          callback}) {
    _shareurlSearchDispatcher.onGetRoutePlanShareURLResultCallback(callback);
  }
}
