import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFModel, BMFCoordinate, ColorUtil;

/// 热力图瓦片提供者
class BMFHeatMap implements BMFModel {
  /// 用户传入的热力图数据,数组,成员类型为BMFHeatMapNode
  late List<BMFHeatMapNode> data;

  /// 设置热力图点半径
  int? radius;

  /// 设置热力图层透明度，默认 0.6
  double? opacity;

  /// 设置热力图渐变
  BMFGradient? gradient;

  /// BMFHeatMap构造方法
  BMFHeatMap({
    required this.data,
    this.radius,
    this.opacity: 0.6,
    this.gradient,
  }) : assert(data.length > 0);

  @override
  Map<String, Object?> toMap() {
    return {
      'data': this
          .data
          .map((weightedCoordinate) => weightedCoordinate.toMap())
          .toList(),
      'radius': this.radius,
      'opacity': this.opacity,
      'gradient': this.gradient?.toMap()
    };
  }

  /// map => BMFHeatMap
  BMFHeatMap.fromMap(Map map) : assert(map.containsKey('data')) {
    if (map['data'] != null) {
      data = [];
      map['data'].forEach((v) {
        data.add(BMFHeatMapNode.fromMap(v as Map));
      });
    }

    radius = map['radius'];
    opacity = map['opacity'];
    gradient =
        map['gradient'] == null ? null : BMFGradient.fromMap(map['gradient']);
  }

  /// map -> dynamic
  @override
  fromMap(Map map) {
    return new BMFHeatMap.fromMap(map);
  }
}

/// 热力图节点信息
class BMFHeatMapNode implements BMFModel {
  /// 点的强度权值
  late double intensity;

  /// 点的位置坐标
  late BMFCoordinate pt;

  BMFHeatMapNode({required this.intensity, required this.pt}) {
    this.intensity = this.intensity > 1 ? this.intensity : 1.0;
  }

  /// map => BMFHeatMapNode
  BMFHeatMapNode.fromMap(Map map) {
    intensity = map['intensity'];
    pt = BMFCoordinate.fromMap(map['pt']);
  }

  @override
  fromMap(Map map) {
    return BMFHeatMapNode.fromMap(map);
  }

  @override
  Map<String, Object> toMap() {
    return {'intensity': this.intensity, 'pt': this.pt.toMap()};
  }
}

/// 热力图渐变色定义类
class BMFGradient implements BMFModel {
  /// 渐变色用到的所有颜色数组 colors与startPoints必须对应
  List<Color>? colors;

  /// 每一个颜色的起始点数组,数组成员类型为 【0,1】的double值,
  /// 个数和mColors的个数必须相同，
  /// 数组内元素必须时递增的 例 【0.1, 0.5, 1】;
  List<double>? startPoints;

  /// 有参构造
  BMFGradient({required this.colors, required this.startPoints});

  /// map => BMFGradient
  BMFGradient.fromMap(Map map) {
    if (map['colors'] != null) {
      List<Color> tmpColors = [];
      map['colors'].forEach((v) {
        tmpColors.add(ColorUtil.hexToColor(v as String));
      });
      colors = tmpColors;
    }

    if (map['startPoints'] != null) {
      List<double> tmpStartPoints = [];
      map['startPoints'].forEach((v) {
        tmpStartPoints.add(v as double);
      });
      startPoints = tmpStartPoints;
    }
  }

  @override
  fromMap(Map map) {
    return BMFGradient.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'colors':
          this.colors?.map((color) => color.value.toRadixString(16)).toList(),
      'startPoints': this.startPoints?.map((p) => p).toList()
    };
  }
}
