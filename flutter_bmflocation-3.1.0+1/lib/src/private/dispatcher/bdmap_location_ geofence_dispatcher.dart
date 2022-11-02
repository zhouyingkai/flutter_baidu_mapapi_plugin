import 'package:flutter/services.dart';

import 'package:flutter_bmflocation/src/private/bdmap_location_method_id.dart';

class BMFLocatioGeofenceDispatcher {
  ///圆形围栏
  void addCircleGeofence(MethodChannel channel, Map regionMap) async {
    try {
      channel.invokeMethod(
          BMFLocationGeofenceMethodId.kLocationCircleGeofence, regionMap);
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  ///多边形围栏
  void addPolygonGeofence(MethodChannel channel, Map regionMap) async {
    try {
      channel.invokeMethod(
          BMFLocationGeofenceMethodId.kLocationPolygonGeofence, regionMap);
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  ///获取全部围栏id
  Future<List?> getGeofenceIdList(MethodChannel channel) async {
    List? result;
    try {
      Map map = await channel
          .invokeMethod(BMFLocationGeofenceMethodId.kLocationGetAllGeofence);
      result = map['result'] as List;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  ///移除指定id围栏
  void removeGeofenceCustomId(MethodChannel channel, String customId) async {
    try {
      channel.invokeMethod(
          BMFLocationGeofenceMethodId.kLocationRemoveGeofenceId, customId);
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  ///移除全部围栏
  void removeAllGeofence(MethodChannel channel) async {
    try {
      channel
          .invokeMethod(BMFLocationGeofenceMethodId.kLocationRemoveAllGeofence);
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }
}
