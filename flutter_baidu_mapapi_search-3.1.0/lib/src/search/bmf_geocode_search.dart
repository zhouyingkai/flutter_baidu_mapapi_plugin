import 'package:flutter_baidu_mapapi_search/src/model/bmf_geocodesearch_options.dart';
import 'package:flutter_baidu_mapapi_search/src/model/bmf_geocodesearch_result.dart';
import 'package:flutter_baidu_mapapi_search/src/private/bmf_geocodesearch_dispatcher.dart';
import 'package:flutter_baidu_mapapi_search/src/search/bmf_search_errorcode.dart';

/// 正地理编码检索
class BMFGeocodeSearch {
  /// 正地理编码实例
  late BMFGeocodeSearchDispatcher _geocodeSearchDispatcher;

  /// 无参构造
  BMFGeocodeSearch() {
    _geocodeSearchDispatcher = BMFGeocodeSearchDispatcher();
  }

  /// 根据地址名称获取地理信息
  ///
  /// onGetGeoCodeSearchResult 通知正地理编码结果BMFGeoCodeSearchResult
  /// geoCodeSearchOption geo检索信息类
  /// 成功返回YES，否则返回false
  Future<bool> geoCodeSearch(BMFGeoCodeSearchOption geoCodeSearchOption) async {
    return await _geocodeSearchDispatcher.geoCodeSearch(geoCodeSearchOption);
  }

  /// 正地理编码异步回调结果
  void onGetGeoCodeSearchResult(
      {required void Function(
              BMFGeoCodeSearchResult result, BMFSearchErrorCode errorCode)
          callback}) {
    _geocodeSearchDispatcher.onGetGeoCodeSearchCallback(callback);
  }
}

/// 逆地理编码
class BMFReverseGeoCodeSearch {
  /// 逆地理编码实例
  late BMFReverseGeoCodeSearchDispatcher _reverseGeoCodeSearchDispatcher;

  /// 无参构造
  BMFReverseGeoCodeSearch() {
    _reverseGeoCodeSearchDispatcher = BMFReverseGeoCodeSearchDispatcher();
  }

  /// 根据地理坐标获取地址信息
  ///
  /// onGetReverseGeoCodeSearchResult 通知逆地理编码结果BMFReverseGeoCodeSearchResult
  /// reverseGeoCodeOption 反geo检索信息类
  /// 成功返回ture，否则返回false
  Future<bool> reverseGeoCodeSearch(
      BMFReverseGeoCodeSearchOption reverseGeoCodeSearchOption) async {
    return await _reverseGeoCodeSearchDispatcher
        .reverseGeoCodeSearch(reverseGeoCodeSearchOption);
  }

  /// 逆地理编码异步回调结果
  void onGetReverseGeoCodeSearchResult(
      {required void Function(BMFReverseGeoCodeSearchResult result,
              BMFSearchErrorCode errorCode)
          callback}) {
    _reverseGeoCodeSearchDispatcher.onGetReverseGeoCodeSearchCallback(callback);
  }
}
