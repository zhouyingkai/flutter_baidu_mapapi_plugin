import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_bmflocation/src/private/bdmap_location_method_id.dart';

class BMFLocationOptionsDispatcher {
  /// 设置定位参数
  Future<bool> setLocationOptions(
      MethodChannel channel, Map androidMap, Map iosMap) async {
    ArgumentError.checkNotNull(androidMap, "androidMap");
    ArgumentError.checkNotNull(iosMap, "iosMap");

    bool result = false;
    try {
      Map map = (await channel.invokeMethod(
          BMFLocationOptionsMethodId.kLocationSetOptions,
          Platform.isAndroid ? androidMap : iosMap) as Map);
      result = map['result'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }
}
