import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_bmflocation/src/private/bdmap_location_callback_handler.dart';
import 'package:flutter_bmflocation/src/private/bdmap_location_dispatcher_factory.dart';
import 'package:flutter_bmflocation/src/private/bdmap_location_method_id.dart';
import 'package:flutter_bmflocation/src/private/dispatcher/bdmap_location_options_dispather.dart';

class LocationFlutterPlugin {
  static late MethodChannel _channel;

  late BMFLocationCallbackHandler _callbacklHandler;

  LocationFlutterPlugin() {
    _channel = const MethodChannel(BMFLocationConstants.kLocationChannelName);
    _callbacklHandler = BMFLocationCallbackHandler();
    _channel.setMethodCallHandler(_handlerMethod);
  }

  Future<dynamic> _handlerMethod(MethodCall call) async {
    return await _callbacklHandler.handlerMethod(call);
  }

  //设置AK(仅支持iOS)
  @Deprecated('已废弃since2.0.1，推荐使用 `authAK()`')
  static Future<bool> setApiKey(String key) async {
    return BMFLocationDispatcherFactory.instance.authDispatcher
        .keyAuthRequest(_channel, key);
  }

  // 设置AK(仅支持iOS)
  // Android 目前不支持接口设置Apikey,
  // 请在主工程的Manifest文件里设置，详细配置方法请参考官网(https://lbsyun.baidu.com/)
  Future<bool> authAK(String key) async {
    return BMFLocationDispatcherFactory.instance.authDispatcher
        .keyAuthRequest(_channel, key);
  }

  //授权回调(仅支持iOS)
  void getApiKeyCallback({required BMFSetApiKeyResultCallback callback}) {
    _callbacklHandler.setLocationAuthCallback(callback);
  }

  // 设置是否同意隐私政策
  // 隐私政策官网链接：https://lbsyun.baidu.com/index.php?title=openprivacy
  // 未同意隐私政策之前无法使用定位及地理围栏等功能。
  Future<bool> setAgreePrivacy(bool isAgree) async {
    return BMFLocationDispatcherFactory.instance.authDispatcher
        .setAgreePrivacy(_channel, isAgree);
  }

  //设置定位参数
  Future<bool> prepareLoc(Map androidMap, Map iosMap) async {
    return BMFLocationDispatcherFactory.instance.optionsDispatcher
        .setLocationOptions(_channel, androidMap, iosMap);
  }

  //开始连续定位
  Future<bool> startLocation() async {
    return BMFLocationDispatcherFactory.instance.resultDispatcher
        .startSeriesLocation(_channel);
  }

  //定位回调结果
  @Deprecated('已废弃since2.0.1，推荐使用 `seriesLocationCallback()`')
  void onResultCallback({required BMFLocationResultCallback callback}) {
    _callbacklHandler.seriesLocationCallback(callback);
  }

  //连续定位回调
  void seriesLocationCallback({required BMFLocationResultCallback callback}) {
    _callbacklHandler.seriesLocationCallback(callback);
  }

  //停止连续定位
  Future<bool> stopLocation() async {
    return BMFLocationDispatcherFactory.instance.resultDispatcher
        .stopSeriesLocation(_channel);
  }

  //单次定位
  Future<bool> singleLocation(Map arguments) async {
    if (Platform.isIOS) {
      return BMFLocationDispatcherFactory.instance.resultDispatcher
          .startSingleLocation(_channel, arguments);
    } else {
      return BMFLocationDispatcherFactory.instance.resultDispatcher
          .startSeriesLocation(_channel);
    }
  }

  //单次定位回调
  void singleLocationCallback({required BMFLocationResultCallback callback}) {
    _callbacklHandler.singleLocationCallback(callback);
  }

  //返回设备是否支持设备朝向（仅iOS支持）
  Future<bool> headingAvailable() async {
    return BMFLocationDispatcherFactory.instance.headingDispatcher
        .isSupportHeading(_channel);
  }

  //获取设备朝向
  Future<bool> startUpdatingHeading() async {
    return BMFLocationDispatcherFactory.instance.headingDispatcher
        .startHeading(_channel);
  }

  //停止获取设备朝向
  Future<bool> stopUpdatingHeading() async {
    return BMFLocationDispatcherFactory.instance.headingDispatcher
        .stopHeading(_channel);
  }

  //设备朝向回调
  void updateHeadingCallback({required BMFHeadingResultCallback callback}) {
    _callbacklHandler.headingCallback(callback);
  }
}

class GeofenceFlutterPlugin {
  static late MethodChannel _channel;

  late BMFLocationCallbackHandler _callbacklHandler;

  GeofenceFlutterPlugin() {
    _channel = const MethodChannel(BMFLocationConstants.kLocationChannelName);
    _callbacklHandler = BMFLocationCallbackHandler();
    _channel.setMethodCallHandler(_handlerMethod);
  }

  Future<dynamic> _handlerMethod(MethodCall call) async {
    return await _callbacklHandler.handlerMethod(call);
  }

  //iOS端使用地理围栏功能需要在工程中配置App registers for location updates权限。
  //添加圆形围栏
  void addCircleRegion(Map regionMap) async {
    BMFLocationDispatcherFactory.instance.geofenceDispatcher
        .addCircleGeofence(_channel, regionMap);
  }

  //添加多边形围栏
  void addPolygonRegion(Map regionMap) async {
    BMFLocationDispatcherFactory.instance.geofenceDispatcher
        .addPolygonGeofence(_channel, regionMap);
  }

  //围栏创建完成回调
  /*
       Android和iOS不同的是，Android不可重复创建相同的围栏，iOS可以
     */
  void geofenceFinishCallback(
      {required BMFCircleGeofenceCallback callback}) async {
    _callbacklHandler.geofenceCallback(callback);
  }

  //监听围栏状态改变回调
  /*
    结果
      1< 进入地理围栏   2< 在围栏内停留超过10分钟  3< 在地理围栏之外
  */
  void didGeoFencesStatusChangedCallback(
      {required BMFMonitorGeofenceCallback callback}) async {
    _callbacklHandler.monitorGeofenceCallback(callback);
  }

  //获取全部围栏
  Future<List?> getGeofenceIdList() async {
    return BMFLocationDispatcherFactory.instance.geofenceDispatcher
        .getGeofenceIdList(_channel);
  }

  //移除指定id围栏(仅支持iOS)
  void removeGeofenceWithId(String customId) async {
    if (Platform.isIOS) {
      return BMFLocationDispatcherFactory.instance.geofenceDispatcher
          .removeGeofenceCustomId(_channel, customId);
    } else {
      print('removeGeofenceWithId：暂不支持Android');
    }
  }

  //移除全部围栏
  void removeAllGeofence() async {
    return BMFLocationDispatcherFactory.instance.geofenceDispatcher
        .removeAllGeofence(_channel);
  }
}

class AuxiliaryFuctionFlutterPlugin {
  static late MethodChannel _channel;

  late BMFLocationCallbackHandler _callbacklHandler;

  AuxiliaryFuctionFlutterPlugin() {
    _channel = const MethodChannel(BMFLocationConstants.kLocationChannelName);
    _callbacklHandler = BMFLocationCallbackHandler();
    _channel.setMethodCallHandler(_handlerMethod);
  }

  Future<dynamic> _handlerMethod(MethodCall call) async {
    return await _callbacklHandler.handlerMethod(call);
  }

  //移动热点识别
  void getNetworkState() async {
    return BMFLocationDispatcherFactory.instance.auxiliaryDispatcher
        .getNetworkState(_channel);
  }

  //移动热点识别回调(需要开启定位)
  void networkStateCallback({required BMFNetworkStateCallback callback}) async {
    _callbacklHandler.networkStateCallback(callback);
  }
}
