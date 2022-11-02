import 'package:flutter/services.dart';
import 'package:flutter_baidu_mapapi_search/src/model/bmf_buslinesearch_options.dart';
import 'package:flutter_baidu_mapapi_search/src/model/bmf_buslinesearch_result.dart';
import 'package:flutter_baidu_mapapi_search/src/private/bmf_method_id.dart'
    show BMFBusLineSearchMethodID;
import 'package:flutter_baidu_mapapi_search/src/private/bmf_search_channel_factory.dart';
import 'package:flutter_baidu_mapapi_search/src/search/bmf_search_errorcode.dart';

/// 公交详情检索回调
typedef BMFOnGetBuslineResultCallback = void Function(
    BMFBusLineResult result, BMFSearchErrorCode errorCode);

/// buslinesearch调度中心
class BMFBuslineSearchDispatcher {
  /// 公交检索回调
  BMFOnGetBuslineResultCallback? _onGetBuslineResultCallback;

  /// 无参构造
  BMFBuslineSearchDispatcher() {
    BMFSearchChannelFactory.searchChannel
        .setMethodCallHandler(_handlerMethodCallback);
  }

  /// 公交详情检索
  ///
  /// busLineSearchOption 公交线路检索信息类
  /// bool 成功返回true，否则返回false
  Future<bool> busLineSearch(BMFBusLineSearchOption busLineSearchOption) async {
    ArgumentError.checkNotNull(busLineSearchOption, "busLineSearchOption");

    bool result = false;
    try {
      Map map = (await BMFSearchChannelFactory.searchChannel.invokeMethod(
          BMFBusLineSearchMethodID.kBusLineSearch,
          {
            'busLineSearchOption': busLineSearchOption.toMap(),
          } as dynamic)) as Map;
      result = map['result'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// native - flutter
  Future<dynamic> _handlerMethodCallback(MethodCall call) async {
    if (call.method == BMFBusLineSearchMethodID.kBusLineSearch) {
      if (this._onGetBuslineResultCallback != null) {
        Map map = call.arguments;
        BMFBusLineResult result = BMFBusLineResult.fromMap(map['result']);
        BMFSearchErrorCode errorCode =
            BMFSearchErrorCode.values[map['errorCode'] as int];
        this._onGetBuslineResultCallback!(result, errorCode);
      }
    }
  }

  /// 公交检索异步回调结果
  void onGetBuslineSearchResultCallback(BMFOnGetBuslineResultCallback block) {
    ArgumentError.checkNotNull(block, "block");
    this._onGetBuslineResultCallback = block;
  }
}
