import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFModel, BMFCoordinate;

///  推荐上车点参数信息类
class BMFRecommendStopSearchOption implements BMFModel {
  /// 推荐上车点经纬度 （必选）
  BMFCoordinate? location;

  /// 有参构造
  BMFRecommendStopSearchOption({required this.location});

  /// map => BMFRecommendStopSearchOption
  BMFRecommendStopSearchOption.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFRecommendStopSearchOption，The parameter map cannot be null !') {
    location =
        map['location'] == null ? null : BMFCoordinate.fromMap(map['location']);
  }

  @override
  fromMap(Map map) {
    return BMFRecommendStopSearchOption.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {'location': this.location?.toMap()};
  }
}
