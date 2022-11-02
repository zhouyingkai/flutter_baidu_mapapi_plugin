import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFModel;

/// 行政区域检索信息
class BMFDistrictSearchOption implements BMFModel {
  /// 城市名字（必须）
  String? city;

  /// 区县名字（可选）
  String? district;

  /// BMFDistrictSearchOption构造方法
  BMFDistrictSearchOption({required this.city, this.district});

  /// map => BMFDistrictSearchOption
  BMFDistrictSearchOption.fromMap(Map map) {
    city = map['city'];
    district = map['district'];
  }

  @override
  fromMap(Map map) {
    return BMFDistrictSearchOption.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {'city': this.city, 'district': this.district};
  }
}
