import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFModel, BMFCoordinate;

/// 调起客户端的导航类型
enum BMFOpenRouteType {
  ///<调起百度地图步行路线
  WalkingRoute,

  ///<调起百度地图驾车路线
  DrivingRoute,

  ///<调起百度地图公共交通路线
  TransitRoute,
}

/// 交通路线策略
enum BMFOpenTransitPolicy {
  ///<推荐
  RECOMMAND,

  ///<少换乘
  TRANSFER_FIRST,

  ///<少步行
  WALK_FIRST,

  ///<不坐地铁
  NO_SUBWAY,

  ///<时间短
  TIME_FIRST,
}

/// 调起客户端路线参数
class BMFOpenRouteOption implements BMFModel {
  /// 路线起点， 经纬度坐标
  BMFCoordinate? startCoord;

  /// 路线起点名称
  String? startName;

  /// 路线终点， 经纬度坐标
  BMFCoordinate? endCoord;

  /// 路线终点名称
  String? endName;

  /// 调起路线类型
  BMFOpenRouteType? routeType;

  /// 交通路线策略 默认T: RANSIT_RECOMMAND
  /// 异常值时: 强制使用RECOMMAND
  /// 调起百度地图公共交通路线时必填参数
  BMFOpenTransitPolicy? transitPolicy;

  /// 指定返回自定义scheme (ios)
  String? appScheme;

  /// 调起百度地图客户端失败后，是否支持调起web地图，默认：true
  bool? isSupportWeb;

  /// BMFOpenRouteOption 构造方法
  BMFOpenRouteOption({
    required this.startCoord,
    this.startName,
    required this.endCoord,
    this.endName,
    required this.routeType,
    this.transitPolicy = BMFOpenTransitPolicy.RECOMMAND,
    this.appScheme,
    this.isSupportWeb = true,
  });

  /// map => BMFOpenRouteOption
  BMFOpenRouteOption.fromMap(Map map)
      : assert(
            map != null, //ignore: unnecessary_null_comparison
            'Construct a BMFOpenRouteOption，The parameter map cannot be null !'),
        assert(map.containsKey('startCoord')),
        assert(map.containsKey('endCoord')),
        assert(map.containsKey('routeTyp')) {
    startCoord = map['startCoord'] != null
        ? BMFCoordinate.fromMap(map['startCoord'])
        : null;
    endCoord =
        map['endCoord'] != null ? BMFCoordinate.fromMap(map['endCoord']) : null;
    startName = map['startName'];
    endName = map['endName'];
    routeType = map['routeType'] != null
        ? BMFOpenRouteType.values[map['routeType'] as int]
        : null;
    transitPolicy = map['transitPolicy'] != null
        ? BMFOpenTransitPolicy.values[(map['transitPolicy'] as int) - 3]
        : null;
    appScheme = map['appScheme'];
    isSupportWeb = map['isSupportWeb'] as bool?;
  }

  @override
  fromMap(Map map) {
    return BMFOpenRouteOption.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'startCoord': this.startCoord?.toMap(),
      'startName': this.startName,
      'endCoord': this.endCoord?.toMap(),
      'endName': this.endName,
      'routeType': this.routeType != null ? this.routeType!.index : null,
      'transitPolicy': this.transitPolicy != null
          ? this.transitPolicy!.index + 3
          : null, // native 初始值为3
      'appScheme': this.appScheme,
      'isSupportWeb': this.isSupportWeb
    };
  }
}
