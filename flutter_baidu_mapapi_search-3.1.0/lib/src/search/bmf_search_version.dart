import 'package:flutter/services.dart';

/// 获取原生地图Search组件版本号
class BMFMapAPI_Search {
  /// 获取原生地图search组件版本号
  ///
  /// return 平台：xx 组件：xx 版本号：xx
  /// eg: {'platform':'ios', 'component': 'search', version':'6.0.0'}
  static Future<Map?> get nativeSearchVersion async {
    Map? result;
    try {
      result = await MethodChannel('flutter_bmfsearch')
              .invokeMethod('flutter_bmfsearch/search/getNativeSearchVersion')
          as Map?;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }
}
