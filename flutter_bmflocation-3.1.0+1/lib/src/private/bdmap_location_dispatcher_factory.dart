import 'package:flutter_bmflocation/src/private/dispatcher/bdmap_location_auth_dispatcher.dart';
import 'package:flutter_bmflocation/src/private/dispatcher/bdmap_location_%20geofence_dispatcher.dart';
import 'package:flutter_bmflocation/src/private/dispatcher/bdmap_location_auxiliary_dispatcher.dart';
import 'package:flutter_bmflocation/src/private/dispatcher/bdmap_location_options_dispather.dart';
import 'package:flutter_bmflocation/src/private/dispatcher/bdmap_location_result_dispatcher.dart';
import 'package:flutter_bmflocation/src/private/dispatcher/bdmap_location_heading_dispatcher.dart';

//BMFLocationDispatcherFactory
class BMFLocationDispatcherFactory {
  factory BMFLocationDispatcherFactory() => _getInstance();
  static BMFLocationDispatcherFactory get instance => _getInstance();
  static final BMFLocationDispatcherFactory _instance =
      BMFLocationDispatcherFactory._internal();
  static BMFLocationDispatcherFactory _getInstance() {
    return _instance;
  }

  late BMFLocationAuthDispatcher _authDispatcher;
  late BMFLocationOptionsDispatcher _optionsDispatcher;
  late BMFLocationResultDispatcher _resultDispatcher;
  late BMFLocatioGeofenceDispatcher _geofenceDispatcher;
  late BMFLocatioAuxiliaryDispatcher _auxiliaryDispatcher;
  late BMFLocationHeadingDispatcher _headingDispatcher;

  BMFLocationDispatcherFactory._internal() {
    _authDispatcher = BMFLocationAuthDispatcher();
    _optionsDispatcher = BMFLocationOptionsDispatcher();
    _resultDispatcher = BMFLocationResultDispatcher();
    _geofenceDispatcher = BMFLocatioGeofenceDispatcher();
    _auxiliaryDispatcher = BMFLocatioAuxiliaryDispatcher();
    _headingDispatcher = BMFLocationHeadingDispatcher();
  }

  //授权
  BMFLocationAuthDispatcher get authDispatcher => _authDispatcher;

  //设置定位参数
  BMFLocationOptionsDispatcher get optionsDispatcher => _optionsDispatcher;

  //定位结果
  BMFLocationResultDispatcher get resultDispatcher => _resultDispatcher;

  //设备朝向
  BMFLocationHeadingDispatcher get headingDispatcher => _headingDispatcher;

  //地理围栏
  BMFLocatioGeofenceDispatcher get geofenceDispatcher => _geofenceDispatcher;

  //辅助功能
  BMFLocatioAuxiliaryDispatcher get auxiliaryDispatcher => _auxiliaryDispatcher;
}
