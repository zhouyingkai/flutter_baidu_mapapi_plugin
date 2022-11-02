import 'package:flutter_baidu_mapapi_search/src/model/bmf_routesearch_options.dart';
import 'package:flutter_baidu_mapapi_search/src/model/bmf_routesearch_result.dart';
import 'package:flutter_baidu_mapapi_search/src/private/bmf_routesearch_dispatcher.dart';
import 'package:flutter_baidu_mapapi_search/src/search/bmf_search_errorcode.dart';

/// 公交路线检索（仅支持市内）
class BMFTransitRouteSearch {
  /// route检索服务实例
  late BMFRouteSearchDisptacher _routeSearchDispatcher;

  /// 无参构造
  BMFTransitRouteSearch() {
    _routeSearchDispatcher = BMFRouteSearchDisptacher();
  }

  /// 公交路线检索（仅支持市内）
  ///
  /// onGetTransitRouteSearchResult 通知公交检索结果BMFTransitRouteResult
  /// transitRoutePlanOption 公交换乘信息类
  /// 成功返回ture，否则返回null
  Future<bool> transitRouteSearch(
      BMFTransitRoutePlanOption transitRoutePlanOption) async {
    return await _routeSearchDispatcher
        .transitRouteSearch(transitRoutePlanOption);
  }

  /// 公交检索结果回调
  void onGetTransitRouteSearchResult(
      {required void Function(
              BMFTransitRouteResult result, BMFSearchErrorCode errorCode)
          callback}) {
    _routeSearchDispatcher.onGetTransitRouteResultCallback(callback);
  }
}

/// 公共交通路线检索（new）（支持市内和跨城）
class BMFMassTransitRouteSearch {
  /// route检索服务实例
  late BMFRouteSearchDisptacher _routeSearchDispatcher;

  /// 无参构造
  BMFMassTransitRouteSearch() {
    _routeSearchDispatcher = BMFRouteSearchDisptacher();
  }

  /// 公共交通路线检索（new）（支持市内和跨城）
  ///
  /// onGetMassTransitRouteSearchResult 通知公共交通路线检索结果BMFMassTransitRouteResult
  /// 注：起终点城市不支持使用cityId
  /// routePlanOption 公共交通检索信息类
  /// 成功返回ture，否则返回false
  Future<bool> massTransitRouteSearch(
      BMFMassTransitRoutePlanOption massTransitRoutePlanOption) async {
    return await _routeSearchDispatcher
        .massTransitRouteSearch(massTransitRoutePlanOption);
  }

  /// 公共交通路线检索结果回调
  void onGetMassTransitRouteSearchResult(
      {required void Function(
              BMFMassTransitRouteResult result, BMFSearchErrorCode errorCode)
          callback}) {
    _routeSearchDispatcher.onGetMassTransitRouteResultCallback(callback);
  }
}

/// 驾乘路线检索
class BMFDrivingRouteSearch {
  /// route检索服务实例
  late BMFRouteSearchDisptacher _routeSearchDispatcher;

  /// 无参构造
  BMFDrivingRouteSearch() {
    _routeSearchDispatcher = BMFRouteSearchDisptacher();
  }

  /// 驾乘路线检索
  /// onGetDrivingRouteSearchResult 通知驾乘路线检索结果BMFDrivingRouteResult
  /// drivingRoutePlanOption 驾车检索信息类
  /// 成功返回ture，否则返回false
  Future<bool> dringRouteSearch(
      BMFDrivingRoutePlanOption drivingRoutePlanOption) async {
    return await _routeSearchDispatcher
        .dringRouteSearch(drivingRoutePlanOption);
  }

  /// 驾乘路线搜索结果回调
  void onGetDrivingRouteSearchResult(
      {required void Function(
              BMFDrivingRouteResult result, BMFSearchErrorCode errorCode)
          callback}) {
    _routeSearchDispatcher.onGetDrivingRouteResultCallback(callback);
  }
}

/// 步行路线检索
class BMFWalkingRouteSearch {
  /// route检索服务实例
  late BMFRouteSearchDisptacher _routeSearchDispatcher;

  /// 无参构造
  BMFWalkingRouteSearch() {
    _routeSearchDispatcher = BMFRouteSearchDisptacher();
  }

  /// 步行路线检索
  ///
  /// onGetWalkingRouteSearchResult 通知步行路线检索结果BMFWalkingRouteResult
  /// walkingRoutePlanOption 步行检索信息类
  /// 成功返回ture，否则返回false
  Future<bool> walkingRouteSearch(
      BMFWalkingRoutePlanOption walkingRoutePlanOption) async {
    return await _routeSearchDispatcher
        .walkingRouteSearch(walkingRoutePlanOption);
  }

  /// 步行路线搜索结果回调
  void onGetWalkingRouteSearchResult(
      {required void Function(
              BMFWalkingRouteResult result, BMFSearchErrorCode errorCode)
          callback}) {
    _routeSearchDispatcher.onGetWalkingRouteResultCallback(callback);
  }
}

/// 骑行路线检索
class BMFRidingRouteSearch {
  /// route检索服务实例
  late BMFRouteSearchDisptacher _routeSearchDispatcher;

  /// 无参构造
  BMFRidingRouteSearch() {
    _routeSearchDispatcher = BMFRouteSearchDisptacher();
  }

  /// 骑行路线检索
  ///
  /// onGetRidingRouteSearchResult 通知骑行路线检索结果BMFRidingRouteResult
  /// ridingRoutePlanOption 骑行检索信息类
  /// 成功返回ture，否则返回false
  Future<bool> ridingRouteSearch(
      BMFRidingRoutePlanOption ridingRoutePlanOption) async {
    return await _routeSearchDispatcher
        .ridingRouteSearch(ridingRoutePlanOption);
  }

  /// 骑行路线搜索结果回调
  void onGetRidingRouteSearchResult(
      {required void Function(
              BMFRidingRouteResult result, BMFSearchErrorCode errorCode)
          callback}) {
    _routeSearchDispatcher.onGetRidingRouteResultCallback(callback);
  }
}

/// 室内路线检索
class BMFIndoorRouteSearch {
  /// route检索服务实例
  late BMFRouteSearchDisptacher _routeSearchDispatcher;

  /// 无参构造
  BMFIndoorRouteSearch() {
    _routeSearchDispatcher = BMFRouteSearchDisptacher();
  }

  /// 室内路线检索
  ///
  /// onGetIndoorRouteSearchResult 通知骑行路线检索结果BMFIndoorRouteResult
  /// indoorRoutePlanOption 室内路线检索信息类
  /// 成功返回ture，否则返回false
  Future<bool> indoorRouteSearch(
      BMFIndoorRoutePlanOption indoorRoutePlanOption) async {
    return await _routeSearchDispatcher
        .indoorRouteSearch(indoorRoutePlanOption);
  }

  /// 室内路线搜索结果回调
  void onGetIndoorRouteSearchResult(
      {required void Function(
              BMFIndoorRouteResult result, BMFSearchErrorCode errorCode)
          callback}) {
    _routeSearchDispatcher.onGetIndoorRouteResultCallback(callback);
  }
}
