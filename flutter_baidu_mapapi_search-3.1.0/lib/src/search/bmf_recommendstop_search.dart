import 'package:flutter_baidu_mapapi_search/src/model/bmf_recommendstopsearch_options.dart';
import 'package:flutter_baidu_mapapi_search/src/model/bmf_recommendstopsearch_reslut.dart';
import 'package:flutter_baidu_mapapi_search/src/private/bmf_recommendstop_dispatcher.dart';
import 'package:flutter_baidu_mapapi_search/src/search/bmf_search_errorcode.dart';

/// 推荐上车点搜索服务
class BMFRecommendStopSearch {
  /// 推荐上车点搜索服务实例
  late BMFRecommendStopSearchDispatcher _recommendStopSearchDispatcher;

  /// 无参构造
  BMFRecommendStopSearch() {
    _recommendStopSearchDispatcher = BMFRecommendStopSearchDispatcher();
  }

  /// 推荐上车点检索
  /// onGetRecommendStopSearchResult 通知推荐上车点检索结果BMFRecommendStopSearchResult
  /// BMFRecommendStopSearchOption  推荐上车点检索信息类
  /// 成功返回true，否则返回false
  Future<bool> recommendStopSearch(
      BMFRecommendStopSearchOption rcommendStopSearchOption) async {
    return await _recommendStopSearchDispatcher
        .recommendStopSearch(rcommendStopSearchOption);
  }

  /// 推荐上车点检索异步回调结果
  void onGetRecommendStopSearchResult(
      {required void Function(
              BMFRecommendStopSearchResult result, BMFSearchErrorCode errorCode)
          callback}) {
    _recommendStopSearchDispatcher.onGetRecommendStopSearchCallback(callback);
  }
}
