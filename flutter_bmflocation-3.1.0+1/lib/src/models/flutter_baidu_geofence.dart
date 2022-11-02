import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_bmflocation/flutter_bmflocation.dart';

abstract class BMFGeofence {
  ///GeoFence的唯一标识符
  String? geofenceId;

  ///用户自定义ID，可为nil。
  String? customId;

  ///坐标点和围栏的关系，比如用户的位置和围栏的关系
  GeofenceActivateState? geofenceState;

  ///围栏坐标系类型。
  BMFLocationCoordType? coordType;

  //地理围栏样式
  GeofenceStyleType? geofenceStyle;

  BMFGeofence({
    this.geofenceId,
    this.customId,
    this.geofenceState,
    this.coordType,
    this.geofenceStyle,
  });

  BMFGeofence.fromMap(Map map) {
    geofenceId = map['geofenceId'].toString();
    customId = map['customId'].toString();
    geofenceState = map['geofenceState'] == null
        ? null
        : GeofenceActivateState.values[map['geofenceState'] as int];
    coordType = map['coordType'] == null
        ? null
        : BMFLocationCoordType.values[map['coordType'] as int];
    geofenceStyle = GeofenceStyleType.values[map['geofenceStyle'] as int];
  }
}

class BMFCircleGeofence extends BMFGeofence {
  ///围栏中心点
  BMFCoordinate? centerCoordinate;

  ///半径,单位：米
  String? radius;

  BMFCircleGeofence({
    this.centerCoordinate,
    this.radius,
    String? geofenceId,
    String? customId,
    GeofenceActivateState? geofenceState,
    BMFLocationCoordType? coordType,
    GeofenceStyleType? geofenceStyle,
  }) : super(
            geofenceId: geofenceId,
            customId: customId,
            geofenceState: geofenceState,
            coordType: coordType,
            geofenceStyle: geofenceStyle);

  BMFCircleGeofence.fromMap(Map map) : super.fromMap(map) {
    centerCoordinate = BMFCoordinate.fromMap(map['centerCoordinate']);
    radius = map['radius'].toString();
  }
}

class BMFPolygonGeofence extends BMFGeofence {
  List<BMFCoordinate>? coordinateList;

  String? coordinateCount;

  BMFPolygonGeofence({
    this.coordinateList,
    this.coordinateCount,
    String? geofenceId,
    String? customId,
    GeofenceActivateState? geofenceState,
    BMFLocationCoordType? coordType,
    GeofenceStyleType? geofenceStyle,
  }) : super(
            geofenceId: geofenceId,
            customId: customId,
            geofenceState: geofenceState,
            coordType: coordType,
            geofenceStyle: geofenceStyle);

  BMFPolygonGeofence.fromMap(Map map) : super.fromMap(map) {
    if (map['coordinateList'] != null) {
      coordinateList = [];
      map['coordinateList'].forEach((v) {
        coordinateList?.add(BMFCoordinate.fromMap(v as Map));
      });
    }
    coordinateCount = map['coordinateCount'].toString();
  }
}

enum GeofenceStyleType {
  ///圆形
  circleGeofence,

  ///多边形
  polygonGeofence,
}

enum GeofenceActivateState {
  ///进入地理围栏
  geofenceState_In,

  ///围栏内停留超过10分钟
  geofenceState_Stayed,

  ///地理围栏之外
  geofenceState_Out,
}
