import 'package:flutter/services.dart';
import 'package:flutter_baidu_mapapi_base/src/map/bmf_types.dart';

/// 鉴权方法名
const kSetAPIKey = 'flutter_bmfbase/sdk/setApiKey';

/// 隐私政策
const kSetPrivacyAPIKey = 'flutter_bmfbase/sdk/setAgreePrivacy';

/// 地图sdk初始化鉴权
class BMFMapSDK {
  /// 初始化百度地图sdk
  ///
  /// apiKey 百度地图开放平台申请的ak
  /// coordType 坐标类型 目前不支持将全局坐标类型设置为WGS84
  static void setApiKeyAndCoordType(
      String apiKey, BMF_COORD_TYPE coordType) async {
    try {
      await MethodChannel('flutter_bmfbase').invokeMethod(
          kSetAPIKey, {'apiKey': apiKey, 'BMF_COORD_TYPE': coordType.index});
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  /// 设置地图坐标类型
  ///
  /// coordType 坐标类型，目前不支持将全局坐标类型设置为WGS84
  static void setCoordType(BMF_COORD_TYPE coordType) async {
    try {
      await MethodChannel('flutter_bmfbase')
          .invokeMethod(kSetAPIKey, {'BMF_COORD_TYPE': coordType.index});
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  /// 设置用户是否同意SDK隐私协议，默认false，since 3.1.0
  ///
  /// 设置为false时，将影响地图SDK所有检索组件功能的使用
  ///
  /// 隐私政策官网链接：https://lbsyun.baidu.com/index.php?title=openprivacy
  /// isAgree 用户是否同意SDK隐私协议
  static void setAgreePrivacy(bool isAgree) async {
    try {
      await MethodChannel('flutter_bmfbase')
          .invokeMethod(kSetPrivacyAPIKey, {'isAgree': isAgree});
    } catch (e) {
      print(e.toString());
    }
  }
}
