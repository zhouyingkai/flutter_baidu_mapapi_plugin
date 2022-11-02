import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'bmf_overlay.dart' show BMFOverlay;

/// 海量点overlay since 3.1.0
class BMFMultiPointOverlay extends BMFOverlay {
  /// 点对象集合
  late List<BMFMultiPointItem> items;

  /// 标注纹理图片
  late String icon;

  /// 纹理渲染大小，默认为icon图片大小
  BMFSize? pointSize;

  /// 经纬度对应图片中的位置，默认为(0.5,0.5)，范围[0-1] 负值自动取其绝对值 左上角为 (0,0) 右下角为 (1,1)
  BMFPoint? anchor;

  /// 海量点overlay单个点对象构造方法
  BMFMultiPointOverlay({
    required this.items,
    required this.icon,
    this.pointSize,
    BMFPoint? anchor,
    int zIndex: 0,
    bool visible: true,
  })  : assert(items.length > 0),
        super(zIndex: zIndex, visible: visible) {
    this.anchor = anchor != null ? anchor : BMFPoint(0.5, 0.5);
  }

  /// map => BMFMultiPointOverlay
  BMFMultiPointOverlay.fromMap(Map map)
      : assert(map['items'] != null),
        assert(map['icon'] != null),
        super.fromMap(map) {
    if (map['items'] != null) {
      items = <BMFMultiPointItem>[];
      map['coordinates'].forEach((v) {
        items.add(BMFMultiPointItem.fromMap(v as Map));
      });
    }
    icon = map['icon'];
    pointSize = BMFSize.fromMap(map['pointSize']);
    anchor = BMFPoint.fromMap(map['anchor']);
  }

  @override
  fromMap(Map map) {
    return BMFMultiPointItem.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'id': this.Id,
      'items': this.items.map((coord) => coord.toMap()).toList(),
      'icon': this.icon,
      'pointSize': this.pointSize?.toMap(),
      'anchor': this.anchor?.toMap(),
      'zIndex': this.zIndex,
      'visible': this.visible
    };
  }
}

/// 海量点overlay单个点对象
class BMFMultiPointItem implements BMFModel {
  /// 经纬度
  late BMFCoordinate coordinate;

  /// 标题
  String? title;

  /// 副标题
  /// IOS 独有参数
  String? subtitle;

  /// 海量点overlay单个点对象构造方法
  BMFMultiPointItem({required this.coordinate, this.title, this.subtitle});

  BMFMultiPointItem.fromMap(Map map) : assert(map['coordinates'] != null) {
    coordinate = BMFCoordinate.fromMap(map['coordinate']);
    title = map['title'];
    subtitle = map['subtitle'];
  }

  @override
  fromMap(Map map) {
    return BMFMultiPointItem.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'coordinate': this.coordinate.toMap(),
      'title': this.title,
      'subtitle': this.subtitle
    };
  }
}
