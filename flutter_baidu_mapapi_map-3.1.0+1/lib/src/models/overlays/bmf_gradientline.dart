import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFCoordinate, ColorUtil, BMFCoordinateBounds;
import 'package:flutter_baidu_mapapi_map/src/map/bmf_map_linedraw_types.dart';
import 'package:flutter_baidu_mapapi_map/src/private/mapdispatcher/bmf_map_dispatcher_factory.dart';
import 'bmf_overlay.dart';

/// 渐变线 since 3.1.0
class BMFGradientLine extends BMFOverlay implements BMFOverlayBoundsInterface {
  /// 经纬度数组
  late List<BMFCoordinate> coordinates;

  /// 分段索引
  late List<int> indexs;

  /// 线宽
  int? width;

  /// 渐变线的colors
  late List<Color> colors;

  /// 是否抽稀 默认ture
  bool? isThined;

  /// 渐变线经度跨180所需字段
  ///
  /// 默认BMFLineDirectionCross180Type.None, 不跨经度180.
  BMFLineDirectionCross180Type? lineDirectionCross180;

  /// 渐变线构造方法
  BMFGradientLine({
    required this.coordinates,
    required this.indexs,
    required this.colors,
    this.width: 5,
    this.lineDirectionCross180: BMFLineDirectionCross180Type.None,
    this.isThined: true,
    int zIndex: 0,
    bool visible: true,
  })  : assert(coordinates.length > 1),
        assert(indexs.length > 0),
        assert(colors.length > 0),
        super(zIndex: zIndex, visible: visible);

  /// map => BMFGradientLine
  BMFGradientLine.fromMap(Map map)
      : assert(map['coordinates'] != null),
        assert(map['indexs'] != null),
        assert(map['colors'] != null),
        super.fromMap(map) {
    if (map['coordinates'] != null) {
      coordinates = <BMFCoordinate>[];
      map['coordinates'].forEach((v) {
        coordinates.add(BMFCoordinate.fromMap(v as Map));
      });
    }

    if (map['indexs'] != null) {
      indexs = <int>[];
      map['indexs'].forEach((v) {
        indexs.add(v as int);
      });
    }

    if (map['colors'] != null) {
      colors = <Color>[];
      map['colors'].forEach((v) {
        colors.add(ColorUtil.hexToColor(v as String));
      });
    }

    width = map['width'] as int?;
    lineDirectionCross180 = BMFLineDirectionCross180Type
        .values[map['lineDirectionCross180'] as int];
    isThined = map['isThined'] as bool?;
  }

  @override
  fromMap(Map map) {
    return BMFGradientLine.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'id': this.Id,
      'coordinates': this.coordinates.map((coord) => coord.toMap()).toList(),
      'indexs': this.indexs.map((index) => index).toList(),
      'width': this.width,
      'colors':
          this.colors.map((color) => color.value.toRadixString(16)).toList(),
      'lineDirectionCross180': this.lineDirectionCross180?.index,
      'isThined': this.isThined,
      'zIndex': this.zIndex,
      'visible': this.visible
    };
  }

  @override
  Future<BMFCoordinateBounds?> get bounds async {
    return await BMFMapDispatcherFactory.instance.overlayDispatcher
        .getBounds(this);
  }
}
