import 'package:flutter/services.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFModel, BMFCoordinateBounds;

/// overlay的外接矩形 since 3.1.0
/// 仅iOS支持
abstract class BMFOverlayBoundsInterface {
  /// 返回overlay外接矩形 since 3.1.0
  Future<BMFCoordinateBounds?> get bounds async {}
}

/// 地图覆盖物基类
class BMFOverlay implements BMFModel {
  /// overlay 唯一标识id
  late String _id;

  /// overlay是否可见
  ///
  /// Android独有
  bool? visible;

  /// 元素的堆叠顺序
  ///
  /// Android独有
  int? zIndex;

  late MethodChannel _methodChannel;

  BMFOverlay({this.visible, this.zIndex}) {
    var timeStamp = DateTime.now().millisecondsSinceEpoch;
    _id = '$timeStamp' '_' '$hashCode';
  }

  /// map => BMFOverlay
  BMFOverlay.fromMap(Map map) : assert(map.containsKey('id')) {
    _id = map['id'];
    visible = map['visible'];
    zIndex = map['zIndex'];
  }

  /// 获取id
  String get Id => _id;

  /// 设置channel
  void set methodChannel(MethodChannel methodChannel) =>
      _methodChannel = methodChannel;

  /// 获取channel
  MethodChannel get methodChannel => _methodChannel;

  @override
  Map<String, Object?> toMap() {
    return {'id': this.Id, 'visible': visible, 'zIndex': zIndex};
  }

  @override
  fromMap(Map map) {
    return BMFOverlay.fromMap(map);
  }
}
