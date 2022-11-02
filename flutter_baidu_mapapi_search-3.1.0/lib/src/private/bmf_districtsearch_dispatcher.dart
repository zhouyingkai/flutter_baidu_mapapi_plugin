import 'package:flutter/services.dart';
import 'package:flutter_baidu_mapapi_search/src/model/bmf_districtsearch_options.dart';
import 'package:flutter_baidu_mapapi_search/src/model/bmf_districtsearch_result.dart';
import 'package:flutter_baidu_mapapi_search/src/private/bmf_method_id.dart'
    show BMFDistrictSearchMethodID;
import 'package:flutter_baidu_mapapi_search/src/private/bmf_search_channel_factory.dart';
import 'package:flutter_baidu_mapapi_search/src/search/bmf_search_errorcode.dart';

/// 行政检索回调
typedef BMFOnGetDistrictResultCallback = void Function(
    BMFDistrictSearchResult result, BMFSearchErrorCode errorCode);

/// 行政检索调度中心
class BMFDistrictSearchDispatcher {
  /// 结果回调闭包
  BMFOnGetDistrictResultCallback? _onGetDistrictCallback;

  /// 无参构造
  BMFDistrictSearchDispatcher() {
    BMFSearchChannelFactory.searchChannel
        .setMethodCallHandler(_handlerMethodCallback);
  }

  ///行政区域检索
  ///
  /// districtSearchOption 公交线路检索信息类
  /// 成功返回true，否则返回false
  Future<bool> districtSearch(
      BMFDistrictSearchOption districtSearchOption) async {
    ArgumentError.checkNotNull(districtSearchOption, "districtSearchOption");

    bool result = false;
    try {
      Map map = (await BMFSearchChannelFactory.searchChannel.invokeMethod(
          BMFDistrictSearchMethodID.kDistrictSearch,
          {
            'districtSearchOption': districtSearchOption.toMap(),
          } as dynamic)) as Map;
      result = map['result'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// native - flutter
  Future<dynamic> _handlerMethodCallback(MethodCall call) async {
    if (call.method == BMFDistrictSearchMethodID.kDistrictSearch) {
      if (this._onGetDistrictCallback != null) {
        Map map = call.arguments;
        BMFDistrictSearchResult result =
            BMFDistrictSearchResult.fromMap(map['result']);
        BMFSearchErrorCode errorCode =
            BMFSearchErrorCode.values[map['errorCode'] as int];
        this._onGetDistrictCallback!(result, errorCode);
      }
    }
  }

  /// 检索异步回调结果
  void onGetDistrictCallback(BMFOnGetDistrictResultCallback block) {
    ArgumentError.checkNotNull(block, "block");
    this._onGetDistrictCallback = block;
  }
}
