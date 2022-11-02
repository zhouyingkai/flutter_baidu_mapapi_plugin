// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/services.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFCoordinate, BMF_COORD_TYPE;
import 'package:flutter_baidu_mapapi_utils/src/private/bmf_method_id.dart';

/// utils计算调度中心
class BMFUtilsCalculateDispatcher {
  /// 经纬度坐标之间的坐标转换
  ///
  /// iOS支持 WGS84LL->BD09LL, WGS84LL->GCJ02LL,
  /// GCJ02LL->BD09LL, BD09LL->GCJ02LL
  ///
  /// Android支持：WGS84LL->BD09LL, COMMON->BD09LL,BD09LL->COMMON
  ///
  /// [BMFCoordinate] coordinate 源经纬度
  ///
  /// [BMF_COORD_TYPE] fromType 源经纬度类型
  ///
  /// [BMF_COORD_TYPE] toType 目标经纬度类型，
  /// iOS必传，Android不需要传(Android对于某一个输入经纬度类型的输出经纬度类型是固定的)
  ///
  /// 输入输出坐标为其他类型时，认为是非法输入，返回的坐标中经纬度均为0 或 null
  /// 返回 转换后的经纬度坐标
  static Future<BMFCoordinate?> coordTrans(MethodChannel _calcChannel,
      BMFCoordinate coordinate, BMF_COORD_TYPE fromType,
      {BMF_COORD_TYPE? toType}) async {
    if (_calcChannel == null || coordinate == null) {
      return null;
    }

    BMFCoordinate? result;
    try {
      Map map = (await _calcChannel.invokeMethod(
          BMFCalculateMethodID.kCoordTransType,
          {
            'coordinate': coordinate.toMap(),
            'fromType': fromType.index,
            'toType': toType?.index
          } as dynamic)) as Map;

      result = BMFCoordinate.fromMap(map['coordinate']);
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 获取矢量坐标方向
  ///
  /// startCoord 矢量坐标起点
  /// endCoord 矢量坐标终点
  /// 返回方向
  static Future<double?> getDirectionFromCoords(MethodChannel _calcChannel,
      BMFCoordinate startCoord, BMFCoordinate endCoord) async {
    if (_calcChannel == null || startCoord == null || endCoord == null) {
      return 361.0;
    }
    double? result;
    try {
      Map map = (await _calcChannel.invokeMethod(
          BMFCalculateMethodID.kGetDirectionFromCoords,
          {'startCoord': startCoord.toMap(), 'endCoord': endCoord.toMap()}
              as dynamic)) as Map;

      result = map['result'] as double?;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 计算地理矩形区域的面积
  ///
  /// leftTop 左上角经纬度坐标点
  /// rightBottom 右下角经纬度坐标点
  /// 返回区域面积，单位：平方米
  static Future<double?> areaBetweenCoordinates(MethodChannel _calcChannel,
      BMFCoordinate leftTop, BMFCoordinate rightBottom) async {
    if (_calcChannel == null || leftTop == null || rightBottom == null) {
      return -1.0;
    }
    double? result;
    try {
      Map map = (await _calcChannel.invokeMethod(
          BMFCalculateMethodID.kAreaBetweenCoordinates,
          {'leftTop': leftTop.toMap(), 'rightBottom': rightBottom.toMap()}
              as dynamic)) as Map;

      result = map['result'] as double?;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 计算polygon面积
  static Future<double?> calculatePolygonArea(
      MethodChannel _calcChannel, List<BMFCoordinate> polygon) async {
    if (_calcChannel == null || polygon == null) {
      return -1.0;
    }
    double? result;
    try {
      Map map = (await _calcChannel.invokeMethod(
          BMFCalculateMethodID.kCalculatePolygonArea,
          {'polygon': polygon.map((coordinate) => coordinate.toMap()).toList()}
              as dynamic)) as Map;
      result = map['result'] as double?;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 判断点是否在多边形内
  ///
  /// coord 待判断的经纬度点
  /// polygon 目标多边形的顶点数组
  /// 如果在内，返回true，否则返回false
  static Future<bool?> polygonContainsCoordinate(MethodChannel _calcChannel,
      BMFCoordinate coord, List<BMFCoordinate> polygon) async {
    if (_calcChannel == null || coord == null || polygon == null) {
      return false;
    }
    bool? result;
    try {
      Map map = (await _calcChannel.invokeMethod(
          BMFCalculateMethodID.kPolygonContainsCoord,
          {
            'coordinate': coord.toMap(),
            'polygon': polygon.map((coord) => coord.toMap()).toList(),
          } as dynamic)) as Map;

      result = map['result'] as bool?;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 判断点是否在圆内
  ///
  /// coord 待判断的平面坐标点
  /// center 目标圆形的中心点平面坐标
  /// radius 目标圆形的半径，单位m
  /// 如果在内，返回true，否则返回false
  static Future<bool?> circleContainsCoordinate(MethodChannel _calcChannel,
      BMFCoordinate coord, BMFCoordinate center, double radius) async {
    if (_calcChannel == null || coord == null || center == null) {
      return false;
    }
    bool? result;
    try {
      Map map = (await _calcChannel.invokeMethod(
          BMFCalculateMethodID.kCircleContainsCoord,
          {'coord': coord.toMap(), 'center': center.toMap(), 'radius': radius}
              as dynamic)) as Map;

      result = map['result'] as bool?;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 计算两点之间的距离
  ///
  /// startCoord 起点
  /// endCoord 终点
  /// return: 距离值
  static Future<double?> getLocationDistance(MethodChannel _calcChannel,
      BMFCoordinate startCoord, BMFCoordinate endCoord) async {
    if (_calcChannel == null || startCoord == null || endCoord == null) {
      return -1.0;
    }
    double? result;
    try {
      Map map = (await _calcChannel.invokeMethod(
          BMFCalculateMethodID.kLocationDistance,
          {'startCoord': startCoord.toMap(), 'endCoord': endCoord.toMap()}
              as dynamic)) as Map;

      result = map['result'] as double?;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 返回某点距线上最近的点
  ///
  /// polyLine 折线
  /// coord 点
  static Future<BMFCoordinate?> getNearestPointToLine(
      MethodChannel _calcChannel,
      List<BMFCoordinate> polyLine,
      BMFCoordinate coord) async {
    if (null == polyLine || null == coord) {
      return null;
    }

    BMFCoordinate? result;
    try {
      Map map = (await _calcChannel.invokeMethod(
          BMFCalculateMethodID.kNearestPointToLine,
          {
            'polyLine': polyLine.map((linePoint) => linePoint.toMap()).toList(),
            'coord': coord.toMap()
          } as dynamic)) as Map;

      result = BMFCoordinate.fromMap(map['result']);
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 获取点到线段的垂足
  ///
  /// coord 点
  /// lineStart 线段起点经纬度
  /// lineEnd 线段终点经纬度
  static Future<BMFCoordinate?> getPointToTheVerticalFootOfLine(
      MethodChannel _calcChannel,
      BMFCoordinate coord,
      BMFCoordinate lineStart,
      BMFCoordinate lineEnd) async {
    if (null == _calcChannel ||
        null == coord ||
        null == lineStart ||
        null == lineEnd) {
      return null;
    }

    BMFCoordinate? result;
    try {
      Map map = (await _calcChannel.invokeMethod(
          BMFCalculateMethodID.kPointToTheVerticalFootOfLine,
          {
            'coord': coord.toMap(),
            'lineStart': lineStart.toMap(),
            'lineEnd': lineEnd.toMap()
          } as dynamic)) as Map;

      result = BMFCoordinate.fromMap(map['result']);
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }
}
