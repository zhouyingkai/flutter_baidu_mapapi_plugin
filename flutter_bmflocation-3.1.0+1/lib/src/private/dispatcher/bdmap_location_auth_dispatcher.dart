import 'package:flutter/services.dart';

import 'package:flutter_bmflocation/src/private/bdmap_location_method_id.dart';

class BMFLocationAuthDispatcher {
  /// 设置AK
  Future<bool> keyAuthRequest(MethodChannel channel, String key) async {
    ArgumentError.checkNotNull(key, "key");

    bool result = false;
    print(BMFLocationAuthMethodId.kLocationSetApiKey);
    try {
      Map map = (await channel.invokeMethod(
          BMFLocationAuthMethodId.kLocationSetApiKey, key) as Map);
      result = map['result'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 设置隐私政策授权
  Future<bool> setAgreePrivacy(MethodChannel channel, bool isAgree) async {
    ArgumentError.checkNotNull(isAgree, "isAgree");

    bool result = false;
    print(BMFLocationAuthMethodId.kLocationSetAgreePrivacy);
    try {
      Map map = (await channel.invokeMethod(
          BMFLocationAuthMethodId.kLocationSetAgreePrivacy, isAgree) as Map);
      result = map['result'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }
}
