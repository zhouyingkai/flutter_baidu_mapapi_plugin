import 'package:flutter/services.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFCoordinate, BMF_COORD_TYPE;
import 'package:flutter_baidu_mapapi_utils/src/private/bmf_utils_cal_dispatcher.dart';

/// 计算工具接口
class BMFCalculateUtils {
  static const MethodChannel _calcChannel =
      const MethodChannel('flutter_bmfutils/calculate');

  /// 经纬度坐标之间的坐标转换
  ///
  /// iOS支持：WGS84LL->BD09LL, WGS84LL->GCJ02LL,
  /// GCJ02LL->BD09LL, BD09LL->GCJ02LL
  ///
  /// Android支持：WGS84LL->BD09LL, COMMON->BD09LL,BD09LL->COMMON
  ///
  /// [BMFCoordinate] coordinate 源经纬度
  ///
  /// [BMF_COORD_TYPE] fromType 源经纬度类型
  ///
  /// [BMF_COORD_TYPE] toType 目标经纬度类型，iOS必传，Android不需要传(Android对于某一个输入经纬度类型
  /// 的输出经纬度类型是固定的
  ///
  /// 输入输出坐标为其他类型时，认为是非法输入，返回的坐标中经纬度均为0 或 null
  ///
  /// 返回 转换后的经纬度坐标
  static Future<BMFCoordinate?> coordConvert(
      {required BMFCoordinate coordinate,
      required BMF_COORD_TYPE fromType,
      BMF_COORD_TYPE? toType}) async {
    return await BMFUtilsCalculateDispatcher.coordTrans(
        _calcChannel, coordinate, fromType,
        toType: toType);
  }

  /// 判断点是否在多边形内
  ///
  /// [BMFCoordinate] coord 待判断的经纬度点
  ///
  /// List<[BMFCoordinate]> polygon 目标多边形的顶点数组
  ///
  /// 如果在内，返回true，否则返回false
  static Future<bool?> polygonContainsCoordinate(
    BMFCoordinate coord,
    List<BMFCoordinate> polygon,
  ) async {
    return await BMFUtilsCalculateDispatcher.polygonContainsCoordinate(
        _calcChannel, coord, polygon);
  }

  /// 判断点是否在圆内
  ///
  /// [BMFCoordinate] coord 待判断的平面坐标点
  ///
  /// [BMFCoordinate] center 目标圆形的中心点平面坐标
  ///
  /// [BMFCoordinate] radius 目标圆形的半径，单位m
  ///
  /// 如果在内，返回true，否则返回false
  static Future<bool?> circleContainsCoordinate(
      BMFCoordinate coord, BMFCoordinate center, double radius) async {
    return await BMFUtilsCalculateDispatcher.circleContainsCoordinate(
        _calcChannel, coord, center, radius);
  }

  /// 获取矢量坐标方向
  ///
  /// [BMFCoordinate] startCoord 矢量坐标起点
  ///
  /// [BMFCoordinate] endCoord 矢量坐标终点
  ///
  /// 返回方向
  static Future<double?> getDirectionFromCoords(
      BMFCoordinate startCoord, BMFCoordinate endCoord) async {
    return await BMFUtilsCalculateDispatcher.getDirectionFromCoords(
        _calcChannel, startCoord, endCoord);
  }

  /// 计算地理矩形区域的面积
  ///
  /// [BMFCoordinate] leftTop 左上角经纬度坐标点
  ///
  /// [BMFCoordinate] rightBottom 右下角经纬度坐标点
  ///
  /// 返回区域面积，单位：平方米
  static Future<double?> areaBetweenCoordinates(
      BMFCoordinate leftTop, BMFCoordinate rightBottom) async {
    return await BMFUtilsCalculateDispatcher.areaBetweenCoordinates(
        _calcChannel, leftTop, rightBottom);
  }

  /// 计算多边形polygon面积
  ///
  /// List<[BMFCoordinate]> coordinates:多边形顶点经纬度
  ///
  /// 返回区域面积，单位：平方米
  static Future<double?> calculatePolygonArea(
      List<BMFCoordinate> coordinates) async {
    return await BMFUtilsCalculateDispatcher.calculatePolygonArea(
        _calcChannel, coordinates);
  }

  /// 返回某点距线上最近的点
  ///
  /// List<[BMFCoordinate]> polyLine 折线
  ///
  /// [BMFCoordinate] coord 点
  static Future<BMFCoordinate?> getNearestPointToLine(
      List<BMFCoordinate> polyLine, BMFCoordinate coord) async {
    return await BMFUtilsCalculateDispatcher.getNearestPointToLine(
        _calcChannel, polyLine, coord);
  }

  /// 获取点到线段的垂足
  ///
  /// [BMFCoordinate] coord 点
  ///
  /// [BMFCoordinate] lineStart 线段起点经纬度
  ///
  /// [BMFCoordinate] lineEnd 线段终点经纬度
  static Future<BMFCoordinate?> getPointToTheVerticalFootOfLine(
      BMFCoordinate coord,
      BMFCoordinate lineStart,
      BMFCoordinate lineEnd) async {
    return await BMFUtilsCalculateDispatcher.getPointToTheVerticalFootOfLine(
        _calcChannel, coord, lineStart, lineEnd);
  }

  /// 计算两点之间的距离
  ///
  /// [BMFCoordinate] startCoord 起点
  ///
  /// [BMFCoordinate] endCoord 终点
  ///
  /// return: 距离值
  static Future<double?> getLocationDistance(
      BMFCoordinate startCoord, BMFCoordinate endCoord) async {
    return await BMFUtilsCalculateDispatcher.getLocationDistance(
        _calcChannel, startCoord, endCoord);
  }
}
