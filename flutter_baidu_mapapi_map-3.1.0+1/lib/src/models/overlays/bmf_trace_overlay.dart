import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFModel, BMFCoordinate, ColorUtil, BMFCoordinateBounds;
import 'package:flutter_baidu_mapapi_map/src/private/mapdispatcher/bmf_map_dispatcher_factory.dart';
import 'bmf_overlay.dart';

/// 动态轨迹 since 3.1.0
class BMFTraceOverlay extends BMFOverlay implements BMFOverlayBoundsInterface {
  /// 经纬度数组三个点确定一条弧线
  late List<BMFCoordinate> coordinates;

  /// 设置arclineView的线宽度
  int? width;

  /// 边框颜色
  /// IOS 独有参数
  Color? strokeColor;

  /// 填充色
  Color? fillColor;

  /// traceOverlay动画参数
  late BMFTraceOverlayAnimateOption traceOverlayAnimateOption;

  /// 动态轨迹构造方法
  BMFTraceOverlay({
    required this.coordinates,
    required this.traceOverlayAnimateOption,
    this.width: 5,
    this.strokeColor: Colors.blue,
    this.fillColor: Colors.green,
    int zIndex: 0,
    bool visible: true,
  })  : assert(coordinates.length > 1),
        super(zIndex: zIndex, visible: visible);

  /// map => BMFTraceOverlay
  BMFTraceOverlay.fromMap(Map map)
      : assert(map['coordinates'] != null),
        assert(map['traceOverlayAnimateOption'] != null),
        super.fromMap(map) {
    if (map['coordinates'] != null) {
      coordinates = <BMFCoordinate>[];
      map['coordinates'].forEach((v) {
        coordinates.add(BMFCoordinate.fromMap(v as Map));
      });
    }
    traceOverlayAnimateOption =
        BMFTraceOverlayAnimateOption.formMap(map['traceOverlayAnimateOption']);
    width = map['width'] as int;
    strokeColor = ColorUtil.hexToColor(map['strokeColor']);
    fillColor = ColorUtil.hexToColor(map['fillColor']);
  }

  @override
  fromMap(Map map) {
    return BMFTraceOverlay.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'id': this.Id,
      'coordinates': this.coordinates.map((coord) => coord.toMap()).toList(),
      'traceOverlayAnimateOption': this.traceOverlayAnimateOption.toMap(),
      'width': this.width,
      'strokeColor': this.strokeColor?.value.toRadixString(16),
      'fillColor': this.fillColor?.value.toRadixString(16),
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

/// traceOverlay动画参数
class BMFTraceOverlayAnimateOption implements BMFModel {
  /// traceOverlay是否做动画, 默认YES
  bool? animate;

  /// 动画延时开始，单位s
  double? delay;

  /// 动画时间，单位s
  double? duration;

  /// 0~1， 默认0
  /// IOS 独有参数
  double? fromValue;

  /// 0~1，默认1
  /// IOS 独有参数
  double? toValue;

  /// 动画类型
  BMFTraceOverlayAnimationEasingCurve? easingCurve;

  /// 是否跟踪轨迹, 默认YES
  bool? trackMove;

  /// traceOverlay动画参数构造方法
  BMFTraceOverlayAnimateOption(
      {this.animate,
      this.delay,
      this.duration,
      this.fromValue,
      this.toValue,
      this.easingCurve,
      this.trackMove});

  /// map => BMFTraceOverlayAnimateOption
  BMFTraceOverlayAnimateOption.formMap(Map map)
      : assert(map != null) // ignore: unnecessary_null_comparison
  {
    animate = map['animate'] as bool;
    delay = map['delay'] as double;
    duration = map['duration'] as double;
    fromValue = map['fromValue'] as double;
    toValue = map['toValue'] as double;
    easingCurve =
        BMFTraceOverlayAnimationEasingCurve.values[map['easingCurve'] as int];
    trackMove = map['trackMove'] as bool;
  }

  @override
  fromMap(Map map) {
    return BMFTraceOverlayAnimateOption.formMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'animate': this.animate,
      'delay': this.delay,
      'duration': this.duration,
      'fromValue': this.fromValue,
      'toValue': this.toValue,
      'easingCurve': this.easingCurve?.index,
      'trackMove': this.trackMove,
    };
  }
}

/// traceoverlay动画枚举
enum BMFTraceOverlayAnimationEasingCurve {
  /// 线性
  Linear,

  /// 淡入
  EaseIn,

  /// 淡出
  EaseOut,

  /// 淡入淡出
  EaseInOut
}
