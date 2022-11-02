import 'package:flutter/services.dart';
import 'package:flutter_baidu_mapapi_search/src/model/bmf_weathersearch_options.dart';
import 'package:flutter_baidu_mapapi_search/src/model/bmf_weathersearch_result.dart';

import 'package:flutter_baidu_mapapi_search/src/private/bmf_method_id.dart';
import 'package:flutter_baidu_mapapi_search/src/private/bmf_search_channel_factory.dart';
import 'package:flutter_baidu_mapapi_search/src/search/bmf_search_errorcode.dart';

/// 天气查询回调闭包
typedef BMFOnGetWeatherSearchResultCallback = void Function(
    BMFWeatherSearchResult result, BMFSearchErrorCode errorCode);

class BMFWeatherSearchDispatcher {
  /// 天气查询回调闭包
  BMFOnGetWeatherSearchResultCallback? _onGetWeatherSearchCallback;

  BMFWeatherSearchDispatcher() {
    BMFSearchChannelFactory.searchChannel
        .setMethodCallHandler(_handlerMethodCallback);
  }

  Future<bool> weatherSearch(BMFWeatherSearchOption weatherSearchOption) async {
    ArgumentError.checkNotNull(weatherSearchOption, "weatherSearchOption");

    bool result = false;
    try {
      Map map = (await BMFSearchChannelFactory.searchChannel.invokeMethod(
          BMFWeatherSearchMethodID.kWeatherSearch,
          {
            'weatherSearchOption': weatherSearchOption.toMap(),
          } as dynamic)) as Map;
      result = map['result'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// native - flutter
  Future<dynamic> _handlerMethodCallback(MethodCall call) async {
    if (call.method == BMFWeatherSearchMethodID.kWeatherSearch) {
      if (this._onGetWeatherSearchCallback != null) {
        Map map = call.arguments;
        BMFWeatherSearchResult result =
            BMFWeatherSearchResult.fromMap(map['result']);
        BMFSearchErrorCode errorCode =
            BMFSearchErrorCode.values[map['errorCode'] as int];
        this._onGetWeatherSearchCallback!(result, errorCode);
      }
    }
  }

  /// 天气查询检索异步回调结果
  void onGetWeatherSearchCallback(BMFOnGetWeatherSearchResultCallback block) {
    ArgumentError.checkNotNull(block, "block");
    this._onGetWeatherSearchCallback = block;
  }
}
