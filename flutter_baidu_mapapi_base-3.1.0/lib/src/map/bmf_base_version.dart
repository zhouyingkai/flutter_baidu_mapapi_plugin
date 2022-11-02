import 'package:flutter/services.dart';

/// 获取原生地图base组件版本号
class BMFMapAPI_Base {
  /// 获取原生地图base组件版本号
  ///
  /// return 平台：xx 组件：xx 版本号：xx
  /// eg: {'platform':'ios', 'component': 'base', version':'6.0.0'}
  static Future<Map?> get nativeBaseVersion async {
    Map? result;
    try {
      result = await MethodChannel('flutter_bmfbase')
          .invokeMethod('flutter_bmfbase/sdk/getNativeBaseVersion') as Map?;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }
}
