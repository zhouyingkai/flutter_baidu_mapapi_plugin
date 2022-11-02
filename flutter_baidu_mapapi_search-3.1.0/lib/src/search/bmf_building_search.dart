import 'package:flutter_baidu_mapapi_search/src/model/bmf_buildingsearch_options.dart';
import 'package:flutter_baidu_mapapi_search/src/model/bmf_buildingsearch_result.dart';
import 'package:flutter_baidu_mapapi_search/src/private/bmf_buildingsearch_dispatcher.dart';
import 'package:flutter_baidu_mapapi_search/src/search/bmf_search_errorcode.dart';

/// 地图建筑物搜索服务 since 3.1.0
class BMFBuildingSearch {
  /// 地图建筑物搜索服务实例
  late BMFBuildingSearchDispatcher _buildingSearchDispatcher;

  /// 无参构造
  BMFBuildingSearch() {
    _buildingSearchDispatcher = BMFBuildingSearchDispatcher();
  }

  /// 地图建筑物检索
  /// onGetBuildingSearchResult 通知地图建筑物检索结果BMFBuildingSearchResult
  /// buildingSearchOption  地图建筑物检索信息类
  /// 成功返回true，否则返回false
  Future<bool> buildingSearch(
      BMFBuildingSearchOption buildingSearchOption) async {
    return await _buildingSearchDispatcher.buildingSearch(buildingSearchOption);
  }

  /// 地图建筑物检索异步回调结果
  void onGetBuildingSearchResult(
      {required void Function(
              BMFBuildingSearchResult result, BMFSearchErrorCode errorCode)
          callback}) {
    _buildingSearchDispatcher.onGetBuildingSearchResultCallback(callback);
  }
}
