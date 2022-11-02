import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFModel, BMFCoordinate;

/// 调起客户端的导航类型
enum BMFNaviType {
  ///<调起百度地图客户端驾车导航页面(不支持调起web地图)
  DriveNavi,

  ///<调起百度地图客户端步行导航页面(不支持调起web地图)
  ///
  ///<客户端v8.8以后支持
  WalkNavi,

  ///<调起百度地图客户端骑行导航页面(不支持调起web地图)
  ///
  ///<客户端v8.8以后支持
  RideNavi,

  ///<调起百度地图AR步行导航
  ///
  ///<百度地图客户端v9.7.5以后支持AR步行导航，低于此版本，默认调用步行导航；注：客户端版本低于8.6.9，不支持步行导航。
  ARWalkNavi,
}

/// 调起客户端导航参数
class BMFOpenNaviOption implements BMFModel {
  /// 导航起点， 经纬度坐标
  BMFCoordinate? startCoord;

  /// 导航起点名称
  String? startName;

  /// 导航终点， 经纬度坐标
  BMFCoordinate? endCoord;

  /// 导航终点名称
  String? endName;

  /// 调起导航类型
  BMFNaviType? naviType;

  /// 指定返回自定义scheme
  ///
  /// iOS独有，iOS平台必传
  String? appScheme;

  /// 应用名称
  ///
  /// iOS独有，iOS平台必传
  String? appName;

  /// 调起百度地图客户端驾车导航失败后，是否支持调起web地图，
  ///
  /// 默认：true（步行、骑行导航设置该参数无效）
  bool? isSupportWeb;

  /// BMFOpenNaviOption构造方法
  BMFOpenNaviOption({
    required this.startCoord,
    this.startName,
    required this.endCoord,
    this.endName,
    required this.naviType,
    this.appScheme,
    this.appName,
    this.isSupportWeb = true,
  });

  /// map => BMFOpenNaviOption
  BMFOpenNaviOption.fromMap(Map map)
      : assert(
            map != null, //ignore: unnecessary_null_comparison
            'Construct a BMFOpenNaviOption，The parameter map cannot be null !'),
        assert(map.containsKey('startCoord')),
        assert(map.containsKey('endCoord')),
        assert(map.containsKey('naviType')) {
    startCoord = map['startCoord'] == null
        ? null
        : BMFCoordinate.fromMap(map['startCoord']);
    endCoord =
        map['endCoord'] == null ? null : BMFCoordinate.fromMap(map['endCoord']);
    startName = map['startName'];
    endName = map['endName'];
    naviType = map['naviType'] != null
        ? BMFNaviType.values[map['naviType'] as int]
        : null;
    appScheme = map['appScheme'];
    appName = map['appName'];
    isSupportWeb = map['isSupportWeb'] as bool?;
  }

  @override
  fromMap(Map map) {
    return BMFOpenNaviOption.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'startCoord': this.startCoord?.toMap(),
      'startName': this.startName,
      'endCoord': this.endCoord?.toMap(),
      'endName': this.endName,
      'naviType': this.naviType != null ? this.naviType!.index : null,
      'appScheme': this.appScheme,
      'appName': this.appName,
      'isSupportWeb': this.isSupportWeb
    };
  }
}
