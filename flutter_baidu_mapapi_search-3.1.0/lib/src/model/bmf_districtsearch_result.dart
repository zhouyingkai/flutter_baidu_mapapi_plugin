import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFCoordinate, BMFModel;

/// 行政区域检索结果
class BMFDistrictSearchResult implements BMFModel {
  /// 行政区域编码
  int? code;

  /// 行政区边界坐标点数据
  List<List<BMFCoordinate>>? paths;

  /// 行政区域名称
  String? name;

  /// 行政区域中心点
  BMFCoordinate? center;

  /// BMFDistrictSearchResult构造方法
  BMFDistrictSearchResult({this.code, this.paths, this.name, this.center});

  /// map => BMFDistrictSearchResult
  BMFDistrictSearchResult.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFDistrictSearchResult，The parameter map cannot be null !') {
    code = map['code'];
    name = map['name'];
    center =
        map['center'] == null ? null : BMFCoordinate.fromMap(map['center']);

    if (map['paths'] != null) {
      List<List<BMFCoordinate>> tmpPaths = [];
      for (List item in (map['paths'] as List)) {
        List<BMFCoordinate> list = [];
        for (var ite in item) {
          BMFCoordinate coordinate = BMFCoordinate.fromMap(ite as Map);
          list.add(coordinate);
        }
        tmpPaths.add(list);
      }
      paths = tmpPaths;
    }
  }

  @override
  fromMap(Map map) {
    return BMFDistrictSearchResult.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'code': this.code,
      'name': this.name,
      'center': this.center?.toMap(),
      'paths': this
          .paths
          ?.map((list) => list.map((coord) => coord.toMap()).toList())
          .toList()
    };
  }
}
