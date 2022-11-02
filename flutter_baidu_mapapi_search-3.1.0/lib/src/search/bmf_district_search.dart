import 'package:flutter_baidu_mapapi_search/src/model/bmf_districtsearch_options.dart';
import 'package:flutter_baidu_mapapi_search/src/model/bmf_districtsearch_result.dart';
import 'package:flutter_baidu_mapapi_search/src/private/bmf_districtsearch_dispatcher.dart';
import 'package:flutter_baidu_mapapi_search/src/search/bmf_search_errorcode.dart';

/// 行政区域检索
class BMFDistrictSearch {
  /// 行政检索实例
  late BMFDistrictSearchDispatcher _districtSearchDispatcher;

  /// 无参构造
  BMFDistrictSearch() {
    _districtSearchDispatcher = BMFDistrictSearchDispatcher();
  }

  /// 行政区域检索
  ///
  /// onGetDistrictSearchResult 行政区域检索结果BMFDistrictSearchResult
  /// districtSearchOption 公交线路检索信息类
  /// 成功返回true，否则返回false
  Future<bool> districtSearch(
      BMFDistrictSearchOption districtSearchOption) async {
    return await _districtSearchDispatcher.districtSearch(districtSearchOption);
  }

  /// 行政区域检索结果回调
  void onGetDistrictSearchResult(
      {required void Function(
              BMFDistrictSearchResult result, BMFSearchErrorCode errorCode)
          callback}) {
    _districtSearchDispatcher.onGetDistrictCallback(callback);
  }
}
