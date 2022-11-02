import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFModel, BMFCoordinate;

/// sug检索信息类
class BMFSuggestionSearchOption implements BMFModel {
  /// 搜索关键字，必选
  String? keyword;

  /// 城市名，参数也可以传入citycode，必选
  String? cityname;

  /// 指定位置，可选，注：会影响关键字不在设置城市范围内时的检索结果，故不建议使用。
  BMFCoordinate? location;

  /// 是否只返回指定城市检索结果（默认：false）（提示：海外区域暂不支持设置cityLimit）
  bool? cityLimit;

  /// 有参构造
  BMFSuggestionSearchOption({
    this.keyword,
    this.cityname,
    this.location,
    this.cityLimit: false,
  });

  /// map => BMFSuggestionSearchOption
  BMFSuggestionSearchOption.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFSuggestionSearchOption，The parameter map cannot be null !') {
    keyword = map['keyword'];
    cityname = map['cityname'];
    location =
        map['location'] == null ? null : BMFCoordinate.fromMap(map['location']);
    cityLimit = map['cityLimit'] as bool?;
  }

  @override
  fromMap(Map map) {
    return BMFSuggestionSearchOption.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'keyword': this.keyword,
      'cityname': this.cityname,
      'location': this.location?.toMap(),
      'cityLimit': this.cityLimit
    };
  }
}
