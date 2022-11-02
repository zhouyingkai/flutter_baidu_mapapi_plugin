import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFModel;

/// 调起百度地图全景图
class BMFOpenPanoramaOption implements BMFModel {
  /// poi的uid
  String? poiUid;

  /// 指定返回自定义scheme
  ///
  /// 仅iOS支持，Android不支持
  String? appScheme;

  /// 调起百度地图客户端失败后，是否支持调起web地图，默认：true
  bool? isSupportWeb;

  /// BMFOpenPanoramaOption构造方法
  BMFOpenPanoramaOption(
      {required this.poiUid, this.appScheme, this.isSupportWeb = true});

  /// map => BMFOpenPanoramaOption
  BMFOpenPanoramaOption.fromMap(Map map)
      : assert(
            map != null, //ignore: unnecessary_null_comparison
            'Construct a BMFOpenPanoramaOption，The parameter map cannot be null !'),
        assert(map.containsKey('poiUid')) {
    poiUid = map['poiUid'];
    appScheme = map['appScheme'];
    isSupportWeb = map['isSupportWeb'] as bool?;
  }
  @override
  fromMap(Map map) {
    return BMFOpenPanoramaOption.fromMap(map);
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
