import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFModel, BMFCoordinate;

/// 调起百度地图： poi详情参数类
class BMFOpenPoiDetailOption implements BMFModel {
  /// poi的uid
  String? poiUid;

  /// 指定返回自定义scheme
  ///
  /// 仅iOS支持，Android不支持
  String? appScheme;

  /// 调起百度地图客户端失败后，是否支持调起web地图，默认：true
  bool? isSupportWeb;

  /// BMFOpenPoiDetailOption构造方法
  BMFOpenPoiDetailOption(
      {required this.poiUid, this.appScheme, this.isSupportWeb = true});

  /// map => BMFOpenPoiDetailOption
  BMFOpenPoiDetailOption.fromMap(Map map)
      : assert(
            map != null, //ignore: unnecessary_null_comparison
            'Construct a BMFOpenPoiDetailOption，The parameter map cannot be null !'),
        assert(map.containsKey('poiUid')) {
    poiUid = map['poiUid'];
    appScheme = map['appScheme'];
    isSupportWeb = map['isSupportWeb'] as bool?;
  }
  @override
  fromMap(Map map) {
    return BMFOpenPoiDetailOption.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'poiUid': this.poiUid,
      'appScheme': this.appScheme,
      'isSupportWeb': this.isSupportWeb
    };
  }
}

/// 调起百度地图： poi周边参数类
class BMFOpenPoiNearOption implements BMFModel {
  /// 中心点（经纬度）
  BMFCoordinate? location;

  /// 半径
  int? radius;

  /// 关键词
  String? keyword;

  /// 指定返回自定义scheme  (ios)
  String? appScheme;

  /// 调起百度地图客户端失败后，是否支持调起web地图，默认：true  (ios)
  bool? isSupportWeb;

  /// BMFOpenPoiNearOption 构造方法
  BMFOpenPoiNearOption({
    required this.location,
    this.radius,
    this.keyword,
    this.appScheme,
    this.isSupportWeb = true,
  });

  /// map => BMFOpenPoiNearOption
  BMFOpenPoiNearOption.fromMap(Map map)
      : assert(
            map != null, //ignore: unnecessary_null_comparison
            'Construct a BMFOpenPoiNearOption，The parameter map cannot be null !'),
        assert(map.containsKey('location')) {
    location =
        map['location'] == null ? null : BMFCoordinate.fromMap(map['location']);
    radius = map['radius'] as int?;
    keyword = map['keyword'];
    appScheme = map['appScheme'];
    isSupportWeb = map['isSupportWeb'] as bool?;
  }

  @override
  fromMap(Map map) {
    return BMFOpenPoiNearOption.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'location': this.location?.toMap(),
      'radius': this.radius,
      'keyword': this.keyword,
      'appScheme': this.appScheme,
      'isSupportWeb': this.isSupportWeb
    };
  }
}
