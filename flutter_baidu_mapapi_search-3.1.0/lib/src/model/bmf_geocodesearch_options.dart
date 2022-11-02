import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFModel, BMFCoordinate;
// 本文件中包含了 正/反地理编码服务 的请求参数信息类

/// 正地理编码参数信息类
class BMFGeoCodeSearchOption implements BMFModel {
  /// 待解析的地址。必选。
  ///
  /// 可以输入2种样式的值，分别是：
  /// 1、标准的结构化地址信息，如北京市海淀区上地十街十号 【推荐，地址结构越完整，解析精度越高】
  ///  2、支持“*路与*路交叉口”描述方式，如北一环路和阜阳路的交叉路口
  /// 注意：第二种方式并不总是有返回结果，只有当地址库中存在该地址描述时才有返回。
  String? address;

  ///  地址所在的城市名。可选。
  ///
  /// 用于指定上述地址所在的城市，当多个城市都有上述地址时，该参数起到过滤作用。
  /// 注意：指定该字段，不会限制坐标召回城市。
  String? city;

  /// 有参构造
  BMFGeoCodeSearchOption({required this.address, required this.city});

  /// map => BMFGeoCodeSearchOption
  BMFGeoCodeSearchOption.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFGeoCodeSearchOption，The parameter map cannot be null !') {
    address = map['address'];
    city = map['city'];
  }

  @override
  fromMap(Map map) {
    return BMFGeoCodeSearchOption.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {'address': this.address, 'city': this.city};
  }
}

/// 反地理编码参数信息类
class BMFReverseGeoCodeSearchOption implements BMFModel {
  /// 待解析的经纬度坐标（必选）
  BMFCoordinate? location;

  /// 是否访问最新版行政区划数据（仅对中国数据生效）
  bool? isLatestAdmin;

  /// 设置POI召回半径，允许设置区间为0-1000米，超过1000米按1000米召回，默认为1000米
  int? radius;

  /// 设置每页容量，允许设置区间为0-100，默认为10条
  int? pageSize;

  /// 分页编号
  int? pageNum;

  /// 有参构造
  BMFReverseGeoCodeSearchOption({
    required this.location,
    this.isLatestAdmin,
    this.radius,
    this.pageSize,
    this.pageNum,
  });

  /// map = > BMFReverseGeoCodeSearchOption
  BMFReverseGeoCodeSearchOption.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFReverseGeoCodeSearchOption，The parameter map cannot be null !') {
    location =
        map['location'] == null ? null : BMFCoordinate.fromMap(map['location']);
    isLatestAdmin = map['isLatestAdmin'];
    radius = map['radius'];
    pageSize = map['pageSize'];
    pageNum = map['pageNum'];
  }

  @override
  fromMap(Map map) {
    return BMFReverseGeoCodeSearchOption.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'location': this.location?.toMap(),
      'isLatestAdmin': this.isLatestAdmin,
      'radius': this.radius,
      'pageSize': this.pageSize,
      'pageNum': this.pageNum
    };
  }
}
