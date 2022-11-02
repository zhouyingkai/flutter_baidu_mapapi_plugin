import 'package:flutter_baidu_mapapi_map/src/private/mapdispatcher/bmf_map_get_state_dispacther.dart';
import 'package:flutter_baidu_mapapi_map/src/private/mapdispatcher/bmf_map_status_dispacther.dart';
import 'package:flutter_baidu_mapapi_map/src/private/mapdispatcher/bmf_marker_dispatcher.dart';
import 'package:flutter_baidu_mapapi_map/src/private/mapdispatcher/bmf_offline_map_dispatcher.dart';
import 'package:flutter_baidu_mapapi_map/src/private/mapdispatcher/bmf_overlay_dispatcher.dart';
import 'package:flutter_baidu_mapapi_map/src/private/mapdispatcher/bmf_projection_dispatcher.dart';
import 'package:flutter_baidu_mapapi_map/src/private/mapdispatcher/bmf_userlocation_dispatcher.dart';

class BMFMapDispatcherFactory {
  // 工厂模式
  factory BMFMapDispatcherFactory() => _getInstance();
  static BMFMapDispatcherFactory get instance => _getInstance();
  static final BMFMapDispatcherFactory _instance =
      BMFMapDispatcherFactory._internal();

  late BMFMapStatusDispatcher _mapStatusDispatcher;
  late BMFMapGetStateDispatcher _mapGetStateDispatcher;
  late BMFMapUserLocationDispatcher _mapUserLocationDispatcher;
  late BMFMarkerDispatcher _markerDispatcher;
  late BMFOverlayDispatcher _overlayDispatcher;
  late BMFOfflineMapDispatcher _offlineMapDispatcher;
  late BMFProjectionDispatcher _projectionDispatcher;

  BMFMapDispatcherFactory._internal() {
    _mapStatusDispatcher = BMFMapStatusDispatcher();
    _mapGetStateDispatcher = BMFMapGetStateDispatcher();
    _mapUserLocationDispatcher = BMFMapUserLocationDispatcher();
    _markerDispatcher = BMFMarkerDispatcher();
    _overlayDispatcher = BMFOverlayDispatcher();
    _offlineMapDispatcher = BMFOfflineMapDispatcher();
    _projectionDispatcher = BMFProjectionDispatcher();
  }

  static BMFMapDispatcherFactory _getInstance() {
    return _instance;
  }

  /// mapStateDispatcher
  BMFMapStatusDispatcher get mapStatusDispatcher => _mapStatusDispatcher;

  /// mapGetStateDispatcher
  BMFMapGetStateDispatcher get mapGetStateDispatcher => _mapGetStateDispatcher;

  /// mapUserLocationDispatcher
  BMFMapUserLocationDispatcher get mapUserLocationDispatcher =>
      _mapUserLocationDispatcher;

  /// markerDispatcher
  BMFMarkerDispatcher get markerDispatcher => _markerDispatcher;

  /// overlayDispatcher
  BMFOverlayDispatcher get overlayDispatcher => _overlayDispatcher;

  /// offlineMapDispatcher
  BMFOfflineMapDispatcher get OfflineMapDispatcher => _offlineMapDispatcher;

  /// projectionDispatcher
  BMFProjectionDispatcher get projectionDispatcher => _projectionDispatcher;
}
