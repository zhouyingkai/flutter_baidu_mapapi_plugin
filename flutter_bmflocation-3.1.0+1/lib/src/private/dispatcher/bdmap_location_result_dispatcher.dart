import 'package:flutter/services.dart';
import 'package:flutter_bmflocation/src/private/bdmap_location_method_id.dart';

class BMFLocationResultDispatcher {
  /// 开始连续定位
  Future<bool> startSeriesLocation(MethodChannel channel) async {
    bool result = false;
    try {
      Map map = (await channel.invokeMethod(
          BMFLocationResultMethodId.kLocationSeriesLocation) as Map);
      result = map['result'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<bool> stopSeriesLocation(MethodChannel channel) async {
    bool result = false;
    try {
      Map map = (await channel.invokeMethod(
          BMFLocationResultMethodId.kLocationStopLocation) as Map);
      result = map['result'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  ///单次定位
  Future<bool> startSingleLocation(MethodChannel channel, Map arguments) async {
    bool result = false;
    try {
      Map map = (await channel
          .invokeMethod(BMFLocationResultMethodId.kLocationSingleLocation, {
        'isReGeocode': arguments['isReGeocode'],
        'isNetworkState': arguments['isNetworkState']
      }) as Map);
      result = map['result'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }
}
