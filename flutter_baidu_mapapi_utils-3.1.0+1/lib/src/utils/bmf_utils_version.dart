import 'package:flutter/services.dart';

/// 获取原生地图Utils组件版本号
class BMFMapAPI_Utils {
  /// 获取原生地图utils组件版本号
  ///
  /// return 平台：xx 组件：xx 版本号：xx
  /// eg: {'platform':'ios', 'component': 'utils', version':'6.0.0'}
  static Future<Map?> get nativeUtilsVersion async {
    Map? result;
    try {
      result = await MethodChannel('flutter_bmfutils')
          .invokeMethod('flutter_bmfutils/utils/getNativeUtilsVersion') as Map?;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }
}
