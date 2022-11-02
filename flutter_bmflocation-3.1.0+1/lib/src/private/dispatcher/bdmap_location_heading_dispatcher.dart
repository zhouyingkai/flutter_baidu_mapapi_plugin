import 'package:flutter/services.dart';

import 'package:flutter_bmflocation/src/private/bdmap_location_method_id.dart';

class BMFLocationHeadingDispatcher {
  /// 是否支持设备朝向
  Future<bool> isSupportHeading(MethodChannel channel) async {
    bool result = false;
    print(BMFLocationAuthMethodId.kLocationSetApiKey);
    try {
      Map map = (await channel.invokeMethod(
          BMFLocationHeadingMethodId.kLocationHeadingAvailable) as Map);
      result = map['result'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<bool> startHeading(MethodChannel channel) async {
    bool result = false;
    try {
      Map map = (await channel.invokeMethod(
          BMFLocationHeadingMethodId.kLocationStartHeading) as Map);
      result = map['result'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<bool> stopHeading(MethodChannel channel) async {
    bool result = false;
    try {
      Map map = (await channel.invokeMethod(
          BMFLocationHeadingMethodId.kLocationStopHeading) as Map);
      result = map['result'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }
}
