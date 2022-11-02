import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFCoordinate, ColorUtil, BMFBuildInfo;
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';

/// 3D棱柱 since 3.1.0
class BMFPrismOverlay extends BMFOverlay {
  /// 经纬度数组
  List<BMFCoordinate>? coordinates;

  BMFBuildInfo? buildInfo;

  /// 高度
  int? height;

  /// 3D棱柱顶面颜色
  Color? topFaceColor;

  /// 3D棱柱侧面颜色
  ///
  /// 与sideFacTexture二选一
  Color? sideFaceColor;

  /// 3D棱柱侧面纹理图片路径
  ///
  /// 与sideFaceColor二选一
  String? sideFacTexture;

  /// 3d棱柱构造方法
  BMFPrismOverlay({
    required this.coordinates,
    required this.topFaceColor,
    this.sideFaceColor,
    this.sideFacTexture,
    this.height,
    int zIndex: 0,
    bool visible: true,
  })  : assert(coordinates != null),
        assert(coordinates!.length > 3),
        super(zIndex: zIndex, visible: visible);

  /// 3d棱柱颜色构造方法
  BMFPrismOverlay.colorPrismOverlay({
    required this.coordinates,
    required this.topFaceColor,
    required this.sideFaceColor,
    this.height,
    int zIndex: 0,
    bool visible: true,
  })  : assert(coordinates != null),
        assert(coordinates!.length > 3),
        super(zIndex: zIndex, visible: visible);

  /// 3d棱柱纹理构造方法
  BMFPrismOverlay.texturePrismOverlay({
    required this.coordinates,
    required this.topFaceColor,
    required this.sideFacTexture,
    this.height,
    int zIndex: 0,
    bool visible: true,
  })  : assert(coordinates != null),
        assert(coordinates!.length > 3),
        super(zIndex: zIndex, visible: visible);

  /// 地图建筑物颜色构造方法
  BMFPrismOverlay.buildingForColor({
    required this.buildInfo,
    required this.topFaceColor,
    required this.sideFaceColor,
    this.height,
    int zIndex: 0,
    bool visible: true,
  })  : assert(buildInfo != null),
        super(zIndex: zIndex, visible: visible);

  /// 地图建筑物纹理构造方法
  BMFPrismOverlay.buildingForTexture({
    required this.buildInfo,
    required this.topFaceColor,
    required this.sideFacTexture,
    this.height,
    int zIndex: 0,
    bool visible: true,
  })  : assert(buildInfo != null),
        super(zIndex: zIndex, visible: visible);

  /// map => BMFPrismOverlay
  BMFPrismOverlay.fromMap(Map map)
      : assert(map['coordinates'] != null),
        assert(map['topFaceColor'] != null),
        super.fromMap(map) {
    if (map['coordinates'] != null) {
      coordinates = <BMFCoordinate>[];
      map['coordinates'].forEach((v) {
        coordinates?.add(BMFCoordinate.fromMap(v as Map));
      });
    }

    topFaceColor = ColorUtil.hexToColor(map['topFaceColor']);
    sideFaceColor = ColorUtil.hexToColor(map['sideFaceColor']);
    height = map['height'] as int?;
  }

  @override
  fromMap(Map map) {
    return BMFPrismOverlay.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'id': this.Id,
      'coordinates': this.coordinates?.map((coord) => coord.toMap()).toList(),
      'buildInfo': this.buildInfo?.toMap(),
      'height': this.height,
      'topFaceColor': this.topFaceColor?.value.toRadixString(16),
      'sideFaceColor': this.sideFaceColor?.value.toRadixString(16),
      'sideFacTexture': this.sideFacTexture,
      'zIndex': this.zIndex,
      'visible': this.visible
    };
  }
}
