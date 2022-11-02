import 'package:flutter/material.dart';

/// 此文件定义flutter与native间的基础数据交互中间层model

/// flutter_bmfmap 抽象类
abstract class BMFModel {
  /// model -> map
  @required
  Map<String, Object?> toMap();

  /// map -> dynamic
  @required
  dynamic fromMap(Map map);
}

/// 代表经纬度
class BMFCoordinate implements BMFModel {
  /// 纬度
  late double latitude;

  /// 经度
  late double longitude;

  /// BMFCoordinate构造方法
  BMFCoordinate(this.latitude, this.longitude);

  /// map => BMFCoordinate
  BMFCoordinate.fromMap(Map map)
      : assert(map.containsKey('latitude'),
            'Construct a BMFCoordinate，The parameter latitude cannot be null'),
        assert(map.containsKey('longitude'),
            'Construct a BMFCoordinate，The parameter longitude cannot be null') {
    latitude = map['latitude'] as double;
    longitude = map['longitude'] as double;
  }

  @override
  Map<String, Object> toMap() {
    return {'latitude': this.latitude, 'longitude': this.longitude};
  }

  @override
  fromMap(Map map) {
    return BMFCoordinate.fromMap(map);
  }
}

/// 屏幕坐标
class BMFPoint implements BMFModel {
  /// 横坐标
  late double x;

  /// 纵坐标
  late double y;

  /// BMFPoint构造方法
  BMFPoint(this.x, this.y);

  /// map => BMFPoint
  BMFPoint.fromMap(Map map)
      : assert(map.containsKey('x'),
            'Construct a BMFPoint，The parameter x cannot be null'),
        assert(map.containsKey('y'),
            'Construct a BMFPoint，The parameter y cannot be null') {
    x = map['x'] as double;
    y = map['y'] as double;
  }

  /// 屏幕坐标 -> map
  @override
  Map<String, Object> toMap() {
    return {'x': this.x, 'y': this.y};
  }

  /// map ->屏幕坐标
  @override
  fromMap(Map map) {
    return BMFPoint.fromMap(map);
  }
}

/// 矩形大小，用直角地理坐标表示
class BMFSize implements BMFModel {
  /// 宽度
  late double width;

  /// 高度
  late double height;

  /// BMFSize构造方法
  BMFSize(this.width, this.height);

  /// map => BMFSize
  BMFSize.fromMap(Map map)
      : assert(map.containsKey('width'),
            'Construct a BMFSize，The parameter width cannot be null'),
        assert(map.containsKey('height'),
            'Construct a BMFSize，The parameter height cannot be null') {
    width = map['width'] as double;
    height = map['height'] as double;
  }

  /// BMFSize -> map
  @override
  Map<String, Object> toMap() {
    return {'width': this.width, 'height': this.height};
  }

  /// map -> BMFSize
  @override
  fromMap(Map map) {
    return BMFSize.fromMap(map);
  }
}

/// 矩形，用直角地理坐标表示
class BMFMapRect implements BMFModel {
  /// 屏幕左上点对应的直角地理坐标
  late BMFPoint origin;

  /// 坐标范围
  late BMFSize size;

  /// BMFMapRect构造方法
  BMFMapRect(this.origin, this.size);

  /// map => BMFMapRect
  BMFMapRect.fromMap(Map map)
      : assert(map.containsKey('origin'),
            'Construct a BMFMapRect，The parameter origin cannot be null'),
        assert(map.containsKey('size'),
            'Construct a BMFMapRect，The parameter size cannot be null') {
    origin = BMFPoint.fromMap(map['origin']);
    size = BMFSize.fromMap(map['size']);
  }

  /// map -> BMFMapRect
  @override
  fromMap(Map map) {
    return BMFMapRect.fromMap(map);
  }

  /// BMFMapRect -> map
  @override
  Map<String, Object> toMap() {
    return {'origin': this.origin.toMap(), 'size': this.size.toMap()};
  }
}

/// 表示一个经纬度范围
class BMFCoordinateSpan implements BMFModel {
  /// 纬度范围
  late double latitudeDelta;

  /// 经度范围
  late double longitudeDelta;

  /// BMFCoordinateSpan构造方法
  BMFCoordinateSpan(this.latitudeDelta, this.longitudeDelta);

  /// map => BMFCoordinateSpan
  BMFCoordinateSpan.fromMap(Map map)
      : assert(map.containsKey('latitudeDelta'),
            'Construct a BMFCoordinateSpan，The parameter latitudeDelta cannot be null'),
        assert(map.containsKey('longitudeDelta'),
            'Construct a BMFCoordinateSpan，The parameter longitudeDelta cannot be null') {
    latitudeDelta = map['latitudeDelta '] as double;
    longitudeDelta = map['longitudeDelta'] as double;
  }

  /// 经纬度范围 -> map
  @override
  Map<String, Object> toMap() {
    return {
      'latitudeDelta': this.latitudeDelta,
      'longitudeDelta': this.longitudeDelta
    };
  }

  /// map -> 经纬度范围
  @override
  fromMap(Map map) {
    return BMFCoordinateSpan.fromMap(map);
  }
}

/// 表示一个经纬度区域
class BMFCoordinateRegion implements BMFModel {
  /// 中心点经纬度坐标
  late BMFCoordinate center;

  /// 经纬度范围
  late BMFCoordinateSpan span;

  /// BMFCoordinateRegion构造方法
  BMFCoordinateRegion({
    required this.center,
    required this.span,
  });

  /// map => BMFCoordinateRegion
  BMFCoordinateRegion.fromMap(Map map)
      : assert(map.containsKey('center'),
            'Construct a BMFCoordinateRegion，The parameter center cannot be null'),
        assert(map.containsKey('span'),
            'Construct a BMFCoordinateRegion，The parameter span cannot be null') {
    center = BMFCoordinate.fromMap(map['center']);
    span = BMFCoordinateSpan.fromMap(map['span']);
  }

  /// 经纬度区域 -> map
  @override
  Map<String, Object> toMap() {
    return {'center': this.center.toMap(), 'span': this.span.toMap()};
  }

  /// map -> 经纬度区域
  @override
  fromMap(Map map) {
    return BMFCoordinateRegion.fromMap(map);
  }
}

/// 表示一个经纬度边界范围
class BMFCoordinateBounds implements BMFModel {
  /// 该地理范围东北坐标
  late BMFCoordinate northeast;

  /// 该地理范围西南坐标
  late BMFCoordinate southwest;

  /// BMFCoordinateBounds构造方法
  BMFCoordinateBounds({
    required this.northeast,
    required this.southwest,
  });

  /// map => BMFCoordinateBounds
  BMFCoordinateBounds.fromMap(Map map)
      : assert(map.containsKey('northeast'),
            'Construct a BMFCoordinateBounds，The parameter northeast cannot be null'),
        assert(map.containsKey('southwest'),
            'Construct a BMFCoordinateBounds，The parameter southwest cannot be null') {
    northeast = BMFCoordinate.fromMap(map['northeast']);
    southwest = BMFCoordinate.fromMap(map['southwest']);
  }

  /// 经纬度边界 -> map
  @override
  Map<String, Object> toMap() {
    return {'northeast': northeast.toMap(), 'southwest': southwest.toMap()};
  }

  /// map ->经纬度边界
  @override
  fromMap(Map map) {
    return BMFCoordinateBounds.fromMap(map);
  }
}

/// 边框的插入距离(正值就是往内缩.负值就是往外扩充)
class BMFEdgeInsets implements BMFModel {
  /// 上边距
  late double top;

  /// 左边距
  late double left;

  /// 下边距
  late double bottom;

  /// 右边距
  late double right;

  /// BMFEdgeInsets构造方法
  BMFEdgeInsets({
    required this.top,
    required this.left,
    required this.bottom,
    required this.right,
  });

  /// map => BMFEdgeInsets
  BMFEdgeInsets.fromMap(Map map)
      : assert(map.containsKey('top'),
            'Construct a BMFEdgeInsets，The parameter top cannot be null'),
        assert(map.containsKey('left'),
            'Construct a BMFEdgeInsets，The parameter left cannot be null'),
        assert(map.containsKey('bottom'),
            'Construct a BMFEdgeInsets，The parameter bottom cannot be null'),
        assert(map.containsKey('right'),
            'Construct a BMFEdgeInsets，The parameter right cannot be null') {
    top = map['top'] as double;
    left = map['left'] as double;
    bottom = map['bottom'] as double;
    right = map['right'] as double;
  }

  /// EdgeInsets => BMFEdgeInsets
  BMFEdgeInsets.fromEdgeInsets(EdgeInsets insets) {
    top = insets.top;
    left = insets.left;
    bottom = insets.bottom;
    right = insets.right;
  }

  @override
  fromMap(Map map) {
    return BMFEdgeInsets.fromMap(map);
  }

  @override
  Map<String, Object> toMap() {
    return {
      'top': this.top,
      'left': this.left,
      'bottom': this.bottom,
      'right': this.right
    };
  }
}

/// 地图建筑物信息 since 3.1.0
class BMFBuildInfo implements BMFModel {
  /// 高度
  late double height;

  /// 加密后的面
  late String paths;

  /// 加密后的中心点
  late String center;

  /// 准确度
  double? accuracy;

  /// BMFBuildInfo构造方法
  BMFBuildInfo(
      {required this.height,
      required this.paths,
      required this.center,
      this.accuracy});

  /// map => BMFBuildInfo
  BMFBuildInfo.fromMap(Map map)
      : assert(map.containsKey('height'),
            'Construct a BMFBuildInfo parameter height cannot be null'),
        assert(map.containsKey('paths'),
            'Construct a BMFBuildInfo，The parameter paths cannot be null'),
        assert(map.containsKey('center'),
            'Construct a BMFBuildInfo，The parameter center cannot be null') {
    height = map['height'];
    paths = map['paths'];
    center = map['center'];
    accuracy = map['accuracy'];
  }

  @override
  fromMap(Map map) {
    return BMFBuildInfo.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'height': this.height,
      'accuracy': this.accuracy,
      'paths': this.paths,
      'center': this.center
    };
  }
}
