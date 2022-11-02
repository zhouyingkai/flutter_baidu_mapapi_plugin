class BMFLocationConstants {
  static const kLocationChannelName = 'flutter_bmflocation';
}

class BMFLocationAuthMethodId {
  /// 设置ak进行鉴权
  static const kLocationSetApiKey =
      BMFLocationConstants.kLocationChannelName + '/setAK';

  /// 设置是否同意隐私政策
  static const kLocationSetAgreePrivacy =
      BMFLocationConstants.kLocationChannelName + '/setAgreePrivacy';
}

class BMFLocationOptionsMethodId {
  ///设置参数
  static const kLocationSetOptions =
      BMFLocationConstants.kLocationChannelName + '/setOptions';
}

class BMFLocationResultMethodId {
  ///单次定位
  static const kLocationSingleLocation =
      BMFLocationConstants.kLocationChannelName + '/singleLocation';

  ///连续定位
  static const kLocationSeriesLocation =
      BMFLocationConstants.kLocationChannelName + '/seriesLocation';

  ///停止定位
  static const kLocationStopLocation =
      BMFLocationConstants.kLocationChannelName + '/stopLocation';
}

///仅支持iOS
class BMFLocationHeadingMethodId {
  ///是否支持设备朝向
  static const kLocationHeadingAvailable =
      BMFLocationConstants.kLocationChannelName + '/headingAvailable';

  ///开启设备朝向
  static const kLocationStartHeading =
      BMFLocationConstants.kLocationChannelName + '/startUpdatingHeading';

  ///停止设备朝向
  static const kLocationStopHeading =
      BMFLocationConstants.kLocationChannelName + '/stopUpdatingHeading';
}

class BMFLocationGeofenceMethodId {
  ///圆形围栏
  static const kLocationCircleGeofence =
      BMFLocationConstants.kLocationChannelName + '/circleGeofence';

  ///多边形围栏
  static const kLocationPolygonGeofence =
      BMFLocationConstants.kLocationChannelName + '/polygonGeofence';

  ///围栏创建完成回调
  static const kLocationGeofenceCallback =
      BMFLocationConstants.kLocationChannelName + '/geofenceCallback';

  ///监听围栏
  static const kLocationMonitorGeofence =
      BMFLocationConstants.kLocationChannelName + '/monitorGeofence';

  ///获取全部围栏
  static const kLocationGetAllGeofence =
      BMFLocationConstants.kLocationChannelName + '/getAllGeofenceId';

  ///移除围栏id
  static const kLocationRemoveGeofenceId =
      BMFLocationConstants.kLocationChannelName + '/removeGeofenceId';

  ///移除围栏id
  static const kLocationRemoveAllGeofence =
      BMFLocationConstants.kLocationChannelName + '/removeAllGeofence';
}

class BMFLocationAuxiliaryFuctionMethodId {
  ///移动热点识别id
  static const kLocationNetworkState =
      BMFLocationConstants.kLocationChannelName + '/networkState';
}
