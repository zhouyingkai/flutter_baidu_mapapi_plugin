import 'package:flutter/services.dart';
import 'package:flutter_baidu_mapapi_search/src/private/bmf_method_id.dart';

/// 检索channel单例
class BMFSearchChannelFactory {
  static final MethodChannel _searchChannel =
      MethodChannel(BMFSearhConstants.kSearhMethodChannelName);

  static MethodChannel get searchChannel => _searchChannel;
}
