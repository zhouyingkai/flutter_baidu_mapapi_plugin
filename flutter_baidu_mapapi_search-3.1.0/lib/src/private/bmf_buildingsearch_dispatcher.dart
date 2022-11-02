import 'package:flutter/services.dart';
import 'package:flutter_baidu_mapapi_search/src/model/bmf_buildingsearch_options.dart';
import 'package:flutter_baidu_mapapi_search/src/model/bmf_buildingsearch_result.dart';
import 'package:flutter_baidu_mapapi_search/src/private/bmf_method_id.dart'
    show BMFBuildingSearchMethodID;
import 'package:flutter_baidu_mapapi_search/src/private/bmf_search_channel_factory.dart';
import 'package:flutter_baidu_mapapi_search/src/search/bmf_search_errorcode.dart';

/// 地图建筑物检索回调
typedef BMFOnGetBuildingResultCallback = void Function(
    BMFBuildingSearchResult result, BMFSearchErrorCode errorCode);

/// Buildingsearch调度中心
class BMFBuildingSearchDispatcher {
  /// 地图建筑物检索回调
  BMFOnGetBuildingResultCallback? _onGetBuildingResultCallback;

  /// 无参构造
  BMFBuildingSearchDispatcher() {
    BMFSearchChannelFactory.searchChannel
        .setMethodCallHandler(_handlerMethodCallback);
  }

  /// 地图建筑物检索
  ///
  /// buildingSearchOption 地图建筑物线路检索信息类
  /// bool 成功返回true，否则返回false
  Future<bool> buildingSearch(
      BMFBuildingSearchOption buildingSearchOption) async {
    ArgumentError.checkNotNull(buildingSearchOption, "buildingSearchOption");

    bool result = false;
    try {
      Map map = (await BMFSearchChannelFactory.searchChannel.invokeMethod(
          BMFBuildingSearchMethodID.kBuildingSearch,
          {
            'buildingSearchOption': buildingSearchOption.toMap(),
          } as dynamic)) as Map;
      result = map['result'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// native - flutter
  Future<dynamic> _handlerMethodCallback(MethodCall call) async {
    if (call.method == BMFBuildingSearchMethodID.kBuildingSearch) {
      if (this._onGetBuildingResultCallback != null) {
        Map map = call.arguments;
        BMFBuildingSearchResult result =
            BMFBuildingSearchResult.fromMap(map['result']);
        BMFSearchErrorCode errorCode =
            BMFSearchErrorCode.values[map['errorCode'] as int];
        this._onGetBuildingResultCallback!(result, errorCode);
      }
    }
  }

  /// 地图建筑物检索异步回调结果
  void onGetBuildingSearchResultCallback(BMFOnGetBuildingResultCallback block) {
    ArgumentError.checkNotNull(block, "block");
    this._onGetBuildingResultCallback = block;
  }
}
