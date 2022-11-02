import 'package:flutter_baidu_mapapi_search/src/model/bmf_buslinesearch_options.dart';
import 'package:flutter_baidu_mapapi_search/src/model/bmf_buslinesearch_result.dart';
import 'package:flutter_baidu_mapapi_search/src/private/bmf_buslinesearch_dispatcher.dart';
import 'package:flutter_baidu_mapapi_search/src/search/bmf_search_errorcode.dart';

/// 公交详情搜索服务
class BMFBusLineSearch {
  /// 公交详情搜索实例
  late BMFBuslineSearchDispatcher _buslineSearchDispatcher;

  /// 无参构造
  BMFBusLineSearch() {
    _buslineSearchDispatcher = BMFBuslineSearchDispatcher();
  }

  /// 公交详情检索
  ///
  /// onGetBuslineSearchResult 通知公交详情检索结果BMFBusLineResult
  /// busLineSearchOption 公交线路检索信息类
  /// bool 成功返回true，否则返回null
  Future<bool> busLineSearch(BMFBusLineSearchOption busLineSearchOption) async {
    return _buslineSearchDispatcher.busLineSearch(busLineSearchOption);
  }

  /// 公交详情搜索服务结果回调
  void onGetBuslineSearchResult(
      {required void Function(
              BMFBusLineResult result, BMFSearchErrorCode errorCode)
          callback}) {
    _buslineSearchDispatcher.onGetBuslineSearchResultCallback(callback);
  }
}
