import 'package:flutter/services.dart';
import 'package:flutter_baidu_mapapi_search/src/model/bmf_suggestionsearch_options.dart';
import 'package:flutter_baidu_mapapi_search/src/model/bmf_suggestionsearch_result.dart';
import 'package:flutter_baidu_mapapi_search/src/private/bmf_method_id.dart';
import 'package:flutter_baidu_mapapi_search/src/private/bmf_search_channel_factory.dart';
import 'package:flutter_baidu_mapapi_search/src/search/bmf_search_errorcode.dart';

/// sug检索回调闭包
typedef BMFOnGetSuggestionSearchResultCallback = void Function(
    BMFSuggestionSearchResult result, BMFSearchErrorCode errorCode);

/// sug检索调度中心
class BMFSuggestionSearchDispatcher {
  /// sug检索回调闭包
  BMFOnGetSuggestionSearchResultCallback? _onGetSuggestionSearchCallback;

  /// 无参构造
  BMFSuggestionSearchDispatcher() {
    BMFSearchChannelFactory.searchChannel
        .setMethodCallHandler(_handlerMethodCallback);
  }

  /// 搜索建议检索
  ///
  /// suggestionSearchOption       sug检索信息类
  /// 成功返回ture，否则返回false
  Future<bool> suggestionSearch(
      BMFSuggestionSearchOption suggestionSearchOption) async {
    ArgumentError.checkNotNull(
        suggestionSearchOption, "suggestionSearchOption");

    bool result = false;
    try {
      Map map = (await BMFSearchChannelFactory.searchChannel.invokeMethod(
          BMFSuggestionSearchMethodID.kSuggestionSearch,
          {
            'suggestionSearchOption': suggestionSearchOption.toMap(),
          } as dynamic)) as Map;
      result = map['result'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// native - flutter
  Future<dynamic> _handlerMethodCallback(MethodCall call) async {
    if (call.method == BMFSuggestionSearchMethodID.kSuggestionSearch) {
      if (this._onGetSuggestionSearchCallback != null) {
        Map map = call.arguments;
        BMFSuggestionSearchResult result =
            BMFSuggestionSearchResult.fromMap(map['result']);
        BMFSearchErrorCode errorCode =
            BMFSearchErrorCode.values[map['errorCode'] as int];
        this._onGetSuggestionSearchCallback!(result, errorCode);
      }
    }
  }

  /// sug检索异步回调结果
  void onGetSuggestionSearchCallback(
      BMFOnGetSuggestionSearchResultCallback block) {
    ArgumentError.checkNotNull(block, "block");
    this._onGetSuggestionSearchCallback = block;
  }
}
