import 'package:flutter/services.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/src/models/overlays/bmf_3dmodel_overlay.dart';
import 'package:flutter_baidu_mapapi_map/src/models/overlays/bmf_arcline.dart';
import 'package:flutter_baidu_mapapi_map/src/models/overlays/bmf_circle.dart';
import 'package:flutter_baidu_mapapi_map/src/models/overlays/bmf_dot.dart';
import 'package:flutter_baidu_mapapi_map/src/models/overlays/bmf_geodesicline.dart';
import 'package:flutter_baidu_mapapi_map/src/models/overlays/bmf_gradientline.dart';
import 'package:flutter_baidu_mapapi_map/src/models/overlays/bmf_ground.dart';
import 'package:flutter_baidu_mapapi_map/src/models/overlays/bmf_multipoint_overlay.dart';
import 'package:flutter_baidu_mapapi_map/src/models/overlays/bmf_overlay.dart';
import 'package:flutter_baidu_mapapi_map/src/models/overlays/bmf_polygon.dart';
import 'package:flutter_baidu_mapapi_map/src/models/overlays/bmf_polyline.dart';
import 'package:flutter_baidu_mapapi_map/src/models/overlays/bmf_prism_overlay.dart';
import 'package:flutter_baidu_mapapi_map/src/models/overlays/bmf_text.dart';
import 'package:flutter_baidu_mapapi_map/src/models/overlays/bmf_tile.dart';
import 'package:flutter_baidu_mapapi_map/src/models/overlays/bmf_trace_overlay.dart';
import 'package:flutter_baidu_mapapi_map/src/private/mapdispatcher/bmf_map_method_id.dart'
    show BMFOverlayMethodId;

/// polyline, arcline, polygon, circle,
/// geodesicline, gradientline, prismoverlay,
/// 3dmodeloverlay, multipointoverlay, traceoverlay
/// Dot Text (Android)
class BMFOverlayDispatcher {
  static const _tag = 'BMFOverlayDispatcher';

  /// overlay获取外接矩形
  Future<BMFCoordinateBounds?> getBounds(BMFOverlay overlay) async {
    ArgumentError.checkNotNull(overlay, "overlay");
    BMFCoordinateBounds? result;

    try {
      Map map = (await overlay.methodChannel.invokeMethod(
          BMFOverlayMethodId.kMapGetOverlayBoundsMethod,
          {
            'overlayType': overlay.runtimeType.toString(),
            'overlay': overlay.toMap()
          } as dynamic)) as Map;
      result = BMFCoordinateBounds.fromMap(map);
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 地图添加Polyline
  Future<bool> addPolyline(
      MethodChannel _mapChannel, BMFPolyline polyline) async {
    ArgumentError.checkNotNull(_mapChannel, "_mapChannel");
    ArgumentError.checkNotNull(polyline, "polyline");

    polyline.methodChannel = _mapChannel;

    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(
          BMFOverlayMethodId.kMapAddPolylineMethod,
          polyline.toMap() as dynamic)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 地图添加arcline
  Future<bool> addArcline(MethodChannel _mapChannel, BMFArcLine arcline) async {
    ArgumentError.checkNotNull(_mapChannel, "_mapChannel");
    ArgumentError.checkNotNull(arcline, "arcline");

    arcline.methodChannel = _mapChannel;
    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(
          BMFOverlayMethodId.kMapAddArclinelineMethod,
          arcline.toMap() as dynamic)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 地图添加polygon
  Future<bool> addPolygon(MethodChannel _mapChannel, BMFPolygon polygon) async {
    ArgumentError.checkNotNull(_mapChannel, "_mapChannel");
    ArgumentError.checkNotNull(polygon, "polygon");

    polygon.methodChannel = _mapChannel;
    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(
          BMFOverlayMethodId.kMapAddPolygonMethod,
          polygon.toMap() as dynamic)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 地图添加circle
  Future<bool> addCircle(MethodChannel _mapChannel, BMFCircle circle) async {
    ArgumentError.checkNotNull(_mapChannel, "_mapChannel");
    ArgumentError.checkNotNull(circle, "circle");

    circle.methodChannel = _mapChannel;
    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(
          BMFOverlayMethodId.kMapAddCircleMethod,
          circle.toMap() as dynamic)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 地图添加Dot
  Future<bool> addDot(MethodChannel _mapChannel, BMFDot dot) async {
    ArgumentError.checkNotNull(_mapChannel, "_mapChannel");
    ArgumentError.checkNotNull(dot, "dot");

    dot.methodChannel = _mapChannel;
    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(
          BMFOverlayMethodId.kMapAddDotMethod, dot.toMap() as dynamic)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 地图添加Text
  Future<bool> addText(MethodChannel _mapChannel, BMFText text) async {
    ArgumentError.checkNotNull(_mapChannel, "_mapChannel");
    ArgumentError.checkNotNull(text, "text");

    text.methodChannel = _mapChannel;
    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(
              BMFOverlayMethodId.kMapAddTextMethod, text.toMap() as dynamic))
          as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 地图添加Ground
  Future<bool> addGround(MethodChannel _mapChannel, BMFGround ground) async {
    ArgumentError.checkNotNull(_mapChannel, "_mapChannel");
    ArgumentError.checkNotNull(ground, "ground");

    ground.methodChannel = _mapChannel;
    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(
          BMFOverlayMethodId.kMapAddGroundMethod,
          ground.toMap() as dynamic)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 地图添加geodesicLine since 3.1.0
  Future<bool> addGeodesicLine(
      MethodChannel _mapChannel, BMFGeodesicLine geodesicLine) async {
    ArgumentError.checkNotNull(_mapChannel, '_mapChannel');
    ArgumentError.checkNotNull(geodesicLine, 'geodesicLine');
    bool result = false;
    geodesicLine.methodChannel = _mapChannel;
    try {
      result = (await _mapChannel.invokeMethod(
          BMFOverlayMethodId.kMapAddGeodesicLineMethod,
          geodesicLine.toMap() as dynamic)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 地图添加gradientLine since 3.1.0
  Future<bool> addGradientLine(
      MethodChannel _mapChannel, BMFGradientLine gradientLine) async {
    ArgumentError.checkNotNull(_mapChannel, '_mapChannel');
    ArgumentError.checkNotNull(gradientLine, 'gradientLine');
    bool result = false;
    gradientLine.methodChannel = _mapChannel;
    try {
      result = (await _mapChannel.invokeMethod(
          BMFOverlayMethodId.kBMFMapAddGradientLineMethod,
          gradientLine.toMap() as dynamic)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 地图添加prismOverlay since 3.1.0
  Future<bool> addPrismOverlay(
      MethodChannel _mapChannel, BMFPrismOverlay prismOverlay) async {
    ArgumentError.checkNotNull(_mapChannel, '_mapChannel');
    ArgumentError.checkNotNull(prismOverlay, 'prismOverlay');
    bool result = false;
    prismOverlay.methodChannel = _mapChannel;
    try {
      result = (await _mapChannel.invokeMethod(
          BMFOverlayMethodId.kBMFMapAddPrismOverlayMethod,
          prismOverlay.toMap() as dynamic)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 地图添加3dModel since 3.1.0
  Future<bool> add3dModelOverlay(
      MethodChannel _mapChannel, BMF3DModelOverlay modelOverlay) async {
    ArgumentError.checkNotNull(_mapChannel, '_mapChannel');
    ArgumentError.checkNotNull(modelOverlay, 'modelOverlay');
    bool result = false;
    modelOverlay.methodChannel = _mapChannel;
    try {
      result = (await _mapChannel.invokeMethod(
          BMFOverlayMethodId.kBMFMapAdd3DModelOverlayMethod,
          modelOverlay.toMap() as dynamic)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 地图添加海量点 since 3.1.0
  Future<bool> addMultiPointOverlay(
      MethodChannel _mapChannel, BMFMultiPointOverlay multiPointOverlay) async {
    ArgumentError.checkNotNull(_mapChannel, '_mapChannel');
    ArgumentError.checkNotNull(multiPointOverlay, 'multiPointOverlay');
    bool result = false;
    multiPointOverlay.methodChannel = _mapChannel;
    try {
      result = (await _mapChannel.invokeMethod(
          BMFOverlayMethodId.kBMFMapAddMultiPointOverlayMethod,
          multiPointOverlay.toMap() as dynamic)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 地图添加动态轨迹 since 3.1.0
  Future<bool> addTraceOverlay(
      MethodChannel _mapChannel, BMFTraceOverlay traceOverlay) async {
    ArgumentError.checkNotNull(_mapChannel, '_mapChannel');
    ArgumentError.checkNotNull(traceOverlay, 'traceOverlay');
    bool result = false;
    traceOverlay.methodChannel = _mapChannel;
    try {
      result = (await _mapChannel.invokeMethod(
          BMFOverlayMethodId.kBMFMapAddTraceOverlayMethod,
          traceOverlay.toMap() as dynamic)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 添加瓦片图
  Future<bool> addTile(MethodChannel _mapChannel, BMFTile tile) async {
    ArgumentError.checkNotNull(_mapChannel, "_mapChannel");
    ArgumentError.checkNotNull(tile, "tile");

    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(
              BMFOverlayMethodId.kMapAddTileMethod, tile.toMap() as dynamic))
          as bool;
    } on PlatformException catch (e) {
      BMFLog.e(e.toString(), tag: _tag);
    }
    return result;
  }

  /// 移除瓦片图
  Future<bool> removeTile(MethodChannel _mapChannel, BMFTile tile) async {
    ArgumentError.checkNotNull(_mapChannel, "_mapChannel");
    ArgumentError.checkNotNull(tile, "tile");

    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(
              BMFOverlayMethodId.kMapRemoveTileMethod, tile.toMap() as dynamic))
          as bool;
    } on PlatformException catch (e) {
      BMFLog.e(e.toString(), tag: _tag);
    }
    return result;
  }

  /// 指定id删除overlay
  Future<bool> removeTraceOverlay(
      MethodChannel _mapChannel, String overlayId) async {
    ArgumentError.checkNotNull(_mapChannel, "_mapChannel");
    ArgumentError.checkNotNull(overlayId, "overlayId");

    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(
          BMFOverlayMethodId.kMapRemoveTraceOverlayMethod,
          {'id': overlayId} as dynamic)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 指定id删除overlay
  Future<bool> removeOverlay(
      MethodChannel _mapChannel, String overlayId) async {
    ArgumentError.checkNotNull(_mapChannel, "_mapChannel");
    ArgumentError.checkNotNull(overlayId, "overlayId");

    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(
          BMFOverlayMethodId.kMapRemoveOverlayMethod,
          {'id': overlayId} as dynamic)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 更新arcline属性
  Future<bool> updateArclineMember(MethodChannel _mapChannel, Map map) async {
    ArgumentError.checkNotNull(_mapChannel, "_mapChannel");
    ArgumentError.checkNotNull(map, "map");

    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(
          BMFOverlayMethodId.kMapUpdateArclineMemberMethod, map)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 更新circle属性
  Future<bool> updateCircleMember(MethodChannel _mapChannel, Map map) async {
    ArgumentError.checkNotNull(_mapChannel, "_mapChannel");
    ArgumentError.checkNotNull(map, "map");

    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(
          BMFOverlayMethodId.kMapUpdateCircleMemberMethod, map)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 更新polygon属性
  Future<bool> updatePolygonMember(MethodChannel _mapChannel, Map map) async {
    ArgumentError.checkNotNull(_mapChannel, "_mapChannel");
    ArgumentError.checkNotNull(map, "map");

    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(
          BMFOverlayMethodId.kMapUpdatePolygonMemberMethod, map)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 更新polyline属性
  Future<bool> updatePolylineMember(MethodChannel _mapChannel, Map map) async {
    ArgumentError.checkNotNull(_mapChannel, "_mapChannel");
    ArgumentError.checkNotNull(map, "map");

    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(
          BMFOverlayMethodId.kMapUpdatePolylineMemberMethod, map)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 更新Dot属性
  Future<bool> updateDotMember(MethodChannel _mapChannel, Map map) async {
    ArgumentError.checkNotNull(_mapChannel, "_mapChannel");
    ArgumentError.checkNotNull(map, "map");

    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(
          BMFOverlayMethodId.kMapUpdateDotMemberMethod, map)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 更新Ground属性
  Future<bool> updateGroundMember(MethodChannel _mapChannel, Map map) async {
    ArgumentError.checkNotNull(_mapChannel, "_mapChannel");
    ArgumentError.checkNotNull(map, "map");

    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(
          BMFOverlayMethodId.kMapUpdateGroundMemberMethod, map)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }

  /// 更新Text属性
  Future<bool> updateTextMember(MethodChannel _mapChannel, Map map) async {
    ArgumentError.checkNotNull(_mapChannel, "_mapChannel");
    ArgumentError.checkNotNull(map, "map");

    bool result = false;
    try {
      result = (await _mapChannel.invokeMethod(
          BMFOverlayMethodId.kMapUpdateTextMemberMethod, map)) as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }
}
