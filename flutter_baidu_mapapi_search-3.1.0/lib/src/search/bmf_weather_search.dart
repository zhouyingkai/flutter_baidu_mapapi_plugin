import 'package:flutter_baidu_mapapi_search/src/model/bmf_weathersearch_options.dart';
import 'package:flutter_baidu_mapapi_search/src/model/bmf_weathersearch_result.dart';
import 'package:flutter_baidu_mapapi_search/src/private/bmf_weathersearch_dispatcher.dart';
import 'package:flutter_baidu_mapapi_search/src/search/bmf_search_errorcode.dart';

/// 天气检索
class BMFWeatherSearch {
  /// 天气服务实例
  late BMFWeatherSearchDispatcher _weatherSearchDispatcher;

  /// 无参构造
  BMFWeatherSearch() {
    _weatherSearchDispatcher = BMFWeatherSearchDispatcher();
  }

  /// 天气检索
  /// onGetWeatherSearchResult 通知天气检索结果BMFWeatherSearchResult
  /// BMFWeatherSearchOption  天气检索信息类
  /// 成功返回true，否则返回false
  Future<bool> weatherSearch(
      BMFWeatherSearchOption rcommendStopSearchOption) async {
    return await _weatherSearchDispatcher
        .weatherSearch(rcommendStopSearchOption);
  }

  /// 天气检索异步回调结果
  void onGetWeatherSearchResult(
      {required void Function(
              BMFWeatherSearchResult result, BMFSearchErrorCode errorCode)
          callback}) {
    _weatherSearchDispatcher.onGetWeatherSearchCallback(callback);
  }
}
