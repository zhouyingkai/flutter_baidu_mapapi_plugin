import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFModel;

/// 公交线路检索信息类
class BMFBusLineSearchOption implements BMFModel {
  /// 城市名
  String? city;

  /// 公交线路的uid 注：从Sug检索或者POI城市检索中搜索公交线路,得到的结果中获取。
  String? busLineUid;

  /// 有参构造
  BMFBusLineSearchOption({required this.city, required this.busLineUid});

  /// map => BMFBusLineSearchOption
  BMFBusLineSearchOption.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFBusLineSearchOption，The parameter map cannot be null !') {
    city = map['city'];
    busLineUid = map['busLineUid'];
  }

  @override
  fromMap(Map map) {
    return BMFBusLineSearchOption.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {'city': this.city, 'busLineUid': this.busLineUid};
  }
}
