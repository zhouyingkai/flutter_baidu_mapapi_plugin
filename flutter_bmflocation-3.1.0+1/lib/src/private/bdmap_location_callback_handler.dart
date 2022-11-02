import 'package:flutter/services.dart';
import 'package:flutter_bmflocation/flutter_bmflocation.dart';
import 'package:flutter_bmflocation/src/private/bdmap_location_method_id.dart';

typedef BMFSetApiKeyResultCallback = void Function(String result);

typedef BMFLocationResultCallback = void Function(BaiduLocation result);

typedef BMFCircleGeofenceCallback = void Function(BMFGeofence? geofence);

typedef BMFMonitorGeofenceCallback = void Function(Map monitorResult);

typedef BMFNetworkStateCallback = void Function(Map stateResult);

typedef BMFHeadingResultCallback = void Function(BaiduHeading result);

class BMFLocationCallbackHandler {
  BMFSetApiKeyResultCallback? _keyRequestResultCallback;

  BMFLocationResultCallback? _locationResultCallback;

  BMFCircleGeofenceCallback? _geofenceCallback;

  BMFMonitorGeofenceCallback? _monitorGeofenceCallback;

  BMFNetworkStateCallback? _networkStateCallback;

  BMFHeadingResultCallback? _headingCallback;

  dynamic handlerMethod(MethodCall call) async {
    switch (call.method) {
      case BMFLocationAuthMethodId.kLocationSetApiKey:
        {
          if (_keyRequestResultCallback != null) {
            Map map = call.arguments;
            String result = map['result'];
            _keyRequestResultCallback!(result);
          }
          break;
        }
      case BMFLocationResultMethodId.kLocationSeriesLocation:
        {
          if (_locationResultCallback != null) {
            if (call.arguments != null) {
              Map map = call.arguments;
              BaiduLocation result = BaiduLocation.fromMap(map['result']);
              if (result.latitude != null && result.longitude != null) {
                _locationResultCallback!(result);
              } else {
                print('定位错误：latitude == null或longitude == null');
              }
            } else {
              print('定位错误：call.arguments == null');
            }
          }
          break;
        }
      case BMFLocationResultMethodId.kLocationSingleLocation:
        {
          if (_locationResultCallback != null) {
            Map map = call.arguments;
            BaiduLocation result = BaiduLocation.fromMap(map['result']);
            _locationResultCallback!(result);
          }
          break;
        }
      case BMFLocationGeofenceMethodId.kLocationGeofenceCallback:
        {
          if (_geofenceCallback != null) {
            Map result = call.arguments;

            if (result.isNotEmpty) {
              if (result['errorCode'] as int == 0) {
                Map map = result['result'];
                Map geofenceMap = map['region'];
                if (geofenceMap['geofenceStyle'] ==
                    GeofenceStyleType.circleGeofence.index) {
                  BMFCircleGeofence circle =
                      BMFCircleGeofence.fromMap(geofenceMap);
                  _geofenceCallback!(circle);
                } else {
                  BMFPolygonGeofence polygonle =
                      BMFPolygonGeofence.fromMap(geofenceMap);
                  print(polygonle.geofenceId);
                  _geofenceCallback!(polygonle);
                }
              } else {
                //创建失败
                _geofenceCallback!(null);
              }
            }
          }
          break;
        }
      case BMFLocationGeofenceMethodId.kLocationMonitorGeofence:
        {
          if (_monitorGeofenceCallback != null) {
            Map map = call.arguments;
            _monitorGeofenceCallback!(map);
          }
          break;
        }
      case BMFLocationAuxiliaryFuctionMethodId.kLocationNetworkState:
        {
          if (_networkStateCallback != null) {
            Map map = call.arguments;
            _networkStateCallback!(map);
          }
        }
        break;
      case BMFLocationHeadingMethodId.kLocationStartHeading:
        {
          if (_headingCallback != null) {
            if (call.arguments != null) {
              Map map = call.arguments;
              BaiduHeading heading = BaiduHeading.fromMap(map['result']);
              _headingCallback!(heading);
            } else {
              print('设备朝向：call.arguments == null');
            }
          }
        }
        break;
      default:
        break;
    }
  }

  /// 鉴权回调
  void setLocationAuthCallback(BMFSetApiKeyResultCallback block) {
    ArgumentError.checkNotNull(block, "block");
    _keyRequestResultCallback = block;
  }

  //连续定位
  void seriesLocationCallback(BMFLocationResultCallback block) {
    ArgumentError.checkNotNull(block, "block");
    _locationResultCallback = block;
  }

  //单次定位
  void singleLocationCallback(BMFLocationResultCallback block) {
    ArgumentError.checkNotNull(block, "block");
    _locationResultCallback = block;
  }

  //圆形围栏创建完成/失败
  void geofenceCallback(BMFCircleGeofenceCallback block) {
    ArgumentError.checkNotNull(block, "block");
    _geofenceCallback = block;
  }

  //监听围栏
  void monitorGeofenceCallback(BMFMonitorGeofenceCallback block) {
    ArgumentError.checkNotNull(block, "block");
    _monitorGeofenceCallback = block;
  }

  /// 移动热点识别
  void networkStateCallback(BMFNetworkStateCallback block) {
    ArgumentError.checkNotNull(block, "block");
    _networkStateCallback = block;
  }

  /// 设备朝向回调
  void headingCallback(BMFHeadingResultCallback block) {
    ArgumentError.checkNotNull(block, "block");
    _headingCallback = block;
  }
}
