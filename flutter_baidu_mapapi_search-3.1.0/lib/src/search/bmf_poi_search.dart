import 'package:flutter_baidu_mapapi_search/src/model/bmf_poisearch_options.dart';
import 'package:flutter_baidu_mapapi_search/src/model/bmf_poisearch_result.dart';
import 'package:flutter_baidu_mapapi_search/src/private/bmf_poisearch_dispatcher.dart';
import 'package:flutter_baidu_mapapi_search/src/search/bmf_search_errorcode.dart';

/// poi城市检索
class BMFPoiCitySearch {
  /// poi检索服务实例
  late BMFPoiSearchDispatcher _poiSearchDispatcher;

  /// 无参构造
  BMFPoiCitySearch() {
    _poiSearchDispatcher = BMFPoiSearchDispatcher();
  }

  /// 城市POI检索
  ///
  /// onGetPoiCitySearchResult 通知城市检索结果BMFPoiSearchResult
  /// poiCitySearchOption 城市内搜索的搜索参数类（BMFPoiCitySearchOption）
  /// 成功返回ture，否则返回false
  Future<bool> poiCitySearch(BMFPoiCitySearchOption poiCitySearchOption) async {
    return await _poiSearchDispatcher.poiCitySearch(poiCitySearchOption);
  }

  /// poi城市检索异步回调结果
  void onGetPoiCitySearchResult(
      {required void Function(
              BMFPoiSearchResult result, BMFSearchErrorCode errorCode)
          callback}) {
    _poiSearchDispatcher.onGetPoiCitySearchCallback(callback);
  }
}

/// poi周边检索
class BMFPoiNearbySearch {
  /// poi检索服务实例
  late BMFPoiSearchDispatcher _poiSearchDispatcher;

  /// 无参构造
  BMFPoiNearbySearch() {
    _poiSearchDispatcher = BMFPoiSearchDispatcher();
  }

  /// 根据中心点、半径和检索词发起周边检索
  ///
  /// onGetPoiNearbySearchResult 通知周边检索结果BMFPoiSearchResult
  /// poiNearbySearchOption 周边搜索的搜索参数类（BMFPoiNearbySearchOption）
  /// index 页码，如果是第一次发起搜索，填0，根据返回的结果可以去获取第n页的结果，页码从0开始
  /// 成功返回ture，否则返回false
  Future<bool> poiNearbySearch(
      BMFPoiNearbySearchOption poiNearbySearchOption) async {
    return await _poiSearchDispatcher.poiNearbySearch(poiNearbySearchOption);
  }

  /// poi周边搜索异步回调结果
  void onGetPoiNearbySearchResult(
      {required void Function(
              BMFPoiSearchResult result, BMFSearchErrorCode errorCode)
          callback}) {
    _poiSearchDispatcher.onGetPoiNearbySearchCallback(callback);
  }
}

/// poi矩形检索
class BMFPoiBoundSearch {
  /// poi检索服务实例
  late BMFPoiSearchDispatcher _poiSearchDispatcher;

  /// 无参构造
  BMFPoiBoundSearch() {
    _poiSearchDispatcher = BMFPoiSearchDispatcher();
  }

  /// 根据范围和检索词发起范围检索
  ///
  /// onGetPoiBoundsSearchResult 通知矩形检索结果BMFPoiSearchResult
  /// poiBoundsSearchOption 范围搜索的搜索参数类（BMFPoiBoundSearchOption）
  /// 成功返回ture，否则返回false
  Future<bool> poiBoundsSearch(
      BMFPoiBoundSearchOption poiBoundSearchOption) async {
    return await _poiSearchDispatcher.poiBoundsSearch(poiBoundSearchOption);
  }

  /// poi矩形搜索异步回调结果
  void onGetPoiBoundsSearchResult(
      {required void Function(
              BMFPoiSearchResult result, BMFSearchErrorCode errorCode)
          callback}) {
    _poiSearchDispatcher.onGetPoiBoundsSearchCallback(callback);
  }
}

/// poi详情检索
class BMFPoiDetailSearch {
  /// poi检索服务实例
  late BMFPoiSearchDispatcher _poiSearchDispatcher;

  /// 无参构造
  BMFPoiDetailSearch() {
    _poiSearchDispatcher = BMFPoiSearchDispatcher();
  }

  /// 根据poi uid 发起poi详情检索
  ///
  /// onGetPoiDetailSearchResult 通知poi详情检索结果BMFPoiDetailSearchResult
  /// poiDetailSearchOption poi详情检索参数类（BMFPoiDetailSearchOption）
  /// 成功返回ture，否则返回false
  Future<bool> poiDetailSearch(
      BMFPoiDetailSearchOption poiDetailSearchOption) async {
    return await _poiSearchDispatcher.poiDetailSearch(poiDetailSearchOption);
  }

  /// poi详情检索异步回调结果
  void onGetPoiDetailSearchResult(
      {required void Function(
              BMFPoiDetailSearchResult result, BMFSearchErrorCode errorCode)
          callback}) {
    _poiSearchDispatcher.onGetPoiDetailSearchCallback(callback);
  }
}

/// poi室内检索
class BMFPoiIndoorSearch {
  /// poi检索服务实例
  late BMFPoiSearchDispatcher _poiSearchDispatcher;

  /// 无参构造
  BMFPoiIndoorSearch() {
    _poiSearchDispatcher = BMFPoiSearchDispatcher();
  }

  /// poi室内检索
  ///
  /// onGetPoiIndoorSearchearchResult 通知poi室内检索结果BMFPoiIndoorSearchResult
  /// option poi室内检索参数类（BMFPoiIndoorSearchOption）
  /// 成功返回ture，否则返回false
  Future<bool> poiIndoorSearch(
      BMFPoiIndoorSearchOption poiIndoorSearchOption) async {
    return await _poiSearchDispatcher.poiIndoorSearch(poiIndoorSearchOption);
  }

  /// poi室内检索异步回调结果
  void onGetPoiIndoorSearchearchResult(
      {required void Function(
              BMFPoiIndoorSearchResult result, BMFSearchErrorCode errorCode)
          callback}) {
    _poiSearchDispatcher.onGetPoiIndoorSearchearchCallback(callback);
  }
}
