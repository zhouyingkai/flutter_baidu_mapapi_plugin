import 'package:flutter/services.dart';
import 'package:flutter_baidu_mapapi_search/src/model/bmf_poisearch_options.dart';
import 'package:flutter_baidu_mapapi_search/src/model/bmf_poisearch_result.dart';
import 'package:flutter_baidu_mapapi_search/src/private/bmf_method_id.dart';
import 'package:flutter_baidu_mapapi_search/src/private/bmf_search_channel_factory.dart';
import 'package:flutter_baidu_mapapi_search/src/search/bmf_search_errorcode.dart';

/// poi检索回调闭包
typedef BMFOnGetPoiSearchResultCallback = void Function(
    BMFPoiSearchResult result, BMFSearchErrorCode errorCode);

/// poi详情检索回调闭包
typedef BMFOnGetPOIDetailSearchResultCallback = void Function(
    BMFPoiDetailSearchResult result, BMFSearchErrorCode errorCode);

/// poi室内检索回调闭包
typedef BMFOnGetPOIIndoorSearchResultCallback = void Function(
    BMFPoiIndoorSearchResult result, BMFSearchErrorCode errorCode);

/// poi检索调度中心
class BMFPoiSearchDispatcher {
  /// poi城市检索回调闭包
  BMFOnGetPoiSearchResultCallback? _onGetPoiCitySearchCallback;

  /// poi周边检索回调闭包
  BMFOnGetPoiSearchResultCallback? _onGetPoiNearBySearchCallback;

  /// poi矩形检索回调闭包
  BMFOnGetPoiSearchResultCallback? _onGetPoiBoundsSearchCallback;

  /// poi详情检索回调闭包
  BMFOnGetPOIDetailSearchResultCallback? _onGetPOIDetailSearchCallback;

  /// poi室内检索回调闭包
  BMFOnGetPOIIndoorSearchResultCallback? _onGetPOIIndoorSearchCallback;

  /// 无参构造
  BMFPoiSearchDispatcher() {
    BMFSearchChannelFactory.searchChannel
        .setMethodCallHandler(_handlerMethodCallback);
  }

  /// 城市POI检索
  ///
  ///  poiCitySearchOption 城市内搜索的搜索参数类（BMFPoiCitySearchOption）
  /// 成功返回ture，否则返回false
  Future<bool> poiCitySearch(BMFPoiCitySearchOption poiCitySearchOption) async {
    ArgumentError.checkNotNull(poiCitySearchOption, "poiCitySearchOption");

    bool result = false;
    try {
      Map map = (await BMFSearchChannelFactory.searchChannel.invokeMethod(
          BMFPoiSearchMethodID.kPoiSearchInCity,
          {
            'poiCitySearchOption': poiCitySearchOption.toMap(),
          } as dynamic)) as Map;
      result = map['result'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 根据中心点、半径和检索词发起周边检索
  ///
  /// poiNearbySearchOption 周边搜索的搜索参数类（BMFPOINearbySearchOption）
  /// index 页码，如果是第一次发起搜索，填0，根据返回的结果可以去获取第n页的结果，页码从0开始
  /// 成功返回bool，否则返回false
  Future<bool> poiNearbySearch(
      BMFPoiNearbySearchOption poiNearbySearchOption) async {
    ArgumentError.checkNotNull(poiNearbySearchOption, "poiNearbySearchOption");

    bool result = false;
    try {
      Map map = (await BMFSearchChannelFactory.searchChannel.invokeMethod(
          BMFPoiSearchMethodID.kPoiSearchNearBy,
          {
            'poiNearbySearchOption': poiNearbySearchOption.toMap(),
          } as dynamic)) as Map;
      result = map['result'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 根据范围和检索词发起范围检索
  ///
  /// poiBoundsSearchOption 范围搜索的搜索参数类（BMFPOIBoundSearchOption）
  /// 成功返回bool，否则返回false
  Future<bool> poiBoundsSearch(
      BMFPoiBoundSearchOption poiBoundSearchOption) async {
    ArgumentError.checkNotNull(poiBoundSearchOption, "poiBoundSearchOption");

    bool result = false;
    try {
      Map map = (await BMFSearchChannelFactory.searchChannel.invokeMethod(
          BMFPoiSearchMethodID.kPoiSearchInbounds,
          {
            'poiBoundSearchOption': poiBoundSearchOption.toMap(),
          } as dynamic)) as Map;
      result = map['result'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 根据poi uid 发起poi详情检索
  ///
  /// poiDetailSearchOption poi详情检索参数类（BMFPOIDetailSearchOption）
  /// 成功返回ture，否则返回false
  Future<bool> poiDetailSearch(
      BMFPoiDetailSearchOption poiDetailSearchOption) async {
    ArgumentError.checkNotNull(poiDetailSearchOption, "poiDetailSearchOption");

    bool result = false;
    try {
      Map map = (await BMFSearchChannelFactory.searchChannel.invokeMethod(
          BMFPoiSearchMethodID.kPoiDetailSearch,
          {
            'poiDetailSearchOption': poiDetailSearchOption.toMap(),
          } as dynamic)) as Map;
      result = map['result'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// poi室内检索
  ///
  /// option poi室内检索参数类（BMFPOIIndoorSearchOption）
  /// 成功返回ture，否则返回false
  Future<bool> poiIndoorSearch(
      BMFPoiIndoorSearchOption poiIndoorSearchOption) async {
    ArgumentError.checkNotNull(poiIndoorSearchOption, "poiIndoorSearchOption");

    bool result = false;
    try {
      Map map = (await BMFSearchChannelFactory.searchChannel.invokeMethod(
          BMFPoiSearchMethodID.kPoiIndoorSearch,
          {
            'poiIndoorSearchOption': poiIndoorSearchOption.toMap(),
          } as dynamic)) as Map;
      result = map['result'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// native - flutter
  Future<dynamic> _handlerMethodCallback(MethodCall call) async {
    switch (call.method) {
      case BMFPoiSearchMethodID.kPoiSearchInCity:
        if (this._onGetPoiCitySearchCallback != null) {
          BMFPoiSearchResult result =
              BMFPoiSearchResult.fromMap(call.arguments['result']);
          BMFSearchErrorCode errorCode =
              BMFSearchErrorCode.values[call.arguments['errorCode'] as int];
          this._onGetPoiCitySearchCallback!(result, errorCode);
        }
        break;
      case BMFPoiSearchMethodID.kPoiSearchNearBy:
        if (this._onGetPoiNearBySearchCallback != null) {
          BMFPoiSearchResult result =
              BMFPoiSearchResult.fromMap(call.arguments['result']);
          BMFSearchErrorCode errorCode =
              BMFSearchErrorCode.values[call.arguments['errorCode'] as int];
          this._onGetPoiNearBySearchCallback!(result, errorCode);
        }
        break;
      case BMFPoiSearchMethodID.kPoiSearchInbounds:
        if (this._onGetPoiBoundsSearchCallback != null) {
          BMFPoiSearchResult result =
              BMFPoiSearchResult.fromMap(call.arguments['result']);
          BMFSearchErrorCode errorCode =
              BMFSearchErrorCode.values[call.arguments['errorCode'] as int];
          this._onGetPoiBoundsSearchCallback!(result, errorCode);
        }
        break;
      case BMFPoiSearchMethodID.kPoiDetailSearch:
        if (this._onGetPOIDetailSearchCallback != null) {
          BMFPoiDetailSearchResult result =
              BMFPoiDetailSearchResult.fromMap(call.arguments['result']);
          BMFSearchErrorCode errorCode =
              BMFSearchErrorCode.values[call.arguments['errorCode'] as int];
          this._onGetPOIDetailSearchCallback!(result, errorCode);
        }
        break;
      case BMFPoiSearchMethodID.kPoiIndoorSearch:
        if (this._onGetPOIIndoorSearchCallback != null) {
          BMFPoiIndoorSearchResult result =
              BMFPoiIndoorSearchResult.fromMap(call.arguments['result']);
          BMFSearchErrorCode errorCode =
              BMFSearchErrorCode.values[call.arguments['errorCode'] as int];
          this._onGetPOIIndoorSearchCallback!(result, errorCode);
        }
        break;
    }
  }

  /// poi城市检索异步回调结果
  void onGetPoiCitySearchCallback(BMFOnGetPoiSearchResultCallback block) {
    ArgumentError.checkNotNull(block, "block");
    this._onGetPoiCitySearchCallback = block;
  }

  /// poi周边检索异步回调结果
  void onGetPoiNearbySearchCallback(BMFOnGetPoiSearchResultCallback block) {
    ArgumentError.checkNotNull(block, "block");
    this._onGetPoiNearBySearchCallback = block;
  }

  /// poi矩形检索异步回调结果
  void onGetPoiBoundsSearchCallback(BMFOnGetPoiSearchResultCallback block) {
    ArgumentError.checkNotNull(block, "block");
    this._onGetPoiBoundsSearchCallback = block;
  }

  /// poi详情检索异步回调结果
  void onGetPoiDetailSearchCallback(
      BMFOnGetPOIDetailSearchResultCallback block) {
    ArgumentError.checkNotNull(block, "block");
    this._onGetPOIDetailSearchCallback = block;
  }

  /// poi室内检索异步回调结果
  void onGetPoiIndoorSearchearchCallback(
      BMFOnGetPOIIndoorSearchResultCallback block) {
    ArgumentError.checkNotNull(block, "block");
    this._onGetPOIIndoorSearchCallback = block;
  }
}
