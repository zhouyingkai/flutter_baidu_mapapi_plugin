import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'flutter_baidu_location_base_option.dart';

abstract class LocationBaseGeofenceOption extends BMFLocationBaseOption {
  ///地理围栏监听状态类型
  GeofenceActivateAction activateAction;

  ///指定定位是否会被系统自动暂停。默认为NO。(仅iOS，Android设置无效)
  bool? pausesLocationUpdatesAutomatically;

  /** 
   * 是否允许后台定位。默认为NO。只在iOS 9.0及之后起作用。
   * 设置为YES的时候必须保证 Background Modes 中的 Location updates 处于选中状态，否则会抛出异常。
  */
  ///(仅iOS，Android设置无效)
  bool? allowsBackgroundLocationUpdates;

  ///自定义围栏ID
  String? customId;

  LocationBaseGeofenceOption(
      {required BMFLocationCoordType coordType,
      required this.activateAction,
      this.allowsBackgroundLocationUpdates,
      this.pausesLocationUpdatesAutomatically,
      this.customId})
      : super(coordType: coordType);
}

class LocationPolygonGeofenceOption extends LocationBaseGeofenceOption {
  ///围栏坐标点（必选）
  List<BMFCoordinate> coordinateList;

  /// 构造方法
  LocationPolygonGeofenceOption({
    required this.coordinateList,
    required BMFLocationCoordType coordType,
    required GeofenceActivateAction activateAction,
    bool? allowsBackgroundLocationUpdates,
    bool? pausesLocationUpdatesAutomatically,
    String? customId,
  }) : super(
            coordType: coordType,
            activateAction: activateAction,
            allowsBackgroundLocationUpdates: allowsBackgroundLocationUpdates,
            pausesLocationUpdatesAutomatically:
                pausesLocationUpdatesAutomatically,
            customId: customId);

  Map<String, Object?> toMap() {
    return {
      'coordinateList': this.coordinateList.map((e) => e.toMap()).toList(),
      'customId': this.customId,
      'coordType': this.coordType!.index,
      'activateAction': this.activateAction.index,
      'allowsBackgroundLocationUpdates': this.allowsBackgroundLocationUpdates,
      'pausesLocationUpdatesAutomatically':
          this.pausesLocationUpdatesAutomatically
    };
  }
}

class LocationCircleGeofenceOption extends LocationBaseGeofenceOption {
  ///围栏中心点（必选）
  BMFCoordinate centerCoordinate;

  ///半径,单位：米(必选)
  String radius;

  /// 构造方法
  LocationCircleGeofenceOption({
    required this.centerCoordinate,
    required this.radius,
    required BMFLocationCoordType coordType,
    required GeofenceActivateAction activateAction,
    bool? allowsBackgroundLocationUpdates,
    bool? pausesLocationUpdatesAutomatically,
    String? customId,
  }) : super(
            coordType: coordType,
            activateAction: activateAction,
            allowsBackgroundLocationUpdates: allowsBackgroundLocationUpdates,
            pausesLocationUpdatesAutomatically:
                pausesLocationUpdatesAutomatically,
            customId: customId);

  Map<String, Object?> toMap() {
    return {
      'centerCoordinate': this.centerCoordinate.toMap(),
      'radius': this.radius,
      'customId': this.customId,
      'coordType': this.coordType!.index,
      'activateAction': this.activateAction.index,
      'allowsBackgroundLocationUpdates': this.allowsBackgroundLocationUpdates,
      'pausesLocationUpdatesAutomatically':
          this.pausesLocationUpdatesAutomatically
    };
  }
}

enum GeofenceActivateAction {
  ///进入地理围栏
  geofence_In,

  ///退出地理围栏
  geofenceOut,

  ///在地理围栏内停留(在范围内超过10分钟)
  geofenceStayed,

  ///进入、退出地理围栏
  geofenceIn_Out,

  ///进入地理围栏、在地理围栏内停留
  geofenceIn_Stayed,

  ///退出地理围栏、在地理围栏内停留
  geofenceOut_Stayed,

  ///进入、退出、停留
  geofenceAll,
}
