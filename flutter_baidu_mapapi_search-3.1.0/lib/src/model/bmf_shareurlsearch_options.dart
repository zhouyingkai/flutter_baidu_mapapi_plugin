import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFModel, BMFCoordinate;
import 'package:flutter_baidu_mapapi_search/src/common/bmf_routesearch_type.dart'
    show BMFPlanNode;

/// poi详情短串分享检索信息类
class BMFPoiDetailShareURLOption implements BMFModel {
  /// poi的uid
  String? uid;

  /// 构造方法
  BMFPoiDetailShareURLOption({required this.uid});

  /// map => BMFPoiDetailShareURLOption
  BMFPoiDetailShareURLOption.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFPoiDetailShareURLOption，The parameter map cannot be null !') {
    uid = map['uid'];
  }

  @override
  fromMap(Map map) {
    return BMFPoiDetailShareURLOption.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {'uid': this.uid};
  }
}

/// 反geo短串分享检索信息类
class BMFReverseGeoShareURLOption implements BMFModel {
  /// 名称
  String? name;

  /// 通过短URL调起客户端时作为附加信息显示在名称下面
  String? snippet;

  /// 经纬度
  BMFCoordinate? location;

  /// 构造方法
  BMFReverseGeoShareURLOption({
    required this.location,
    this.name,
    this.snippet,
  });

  /// map => BMFReverseGeoShareURLOption
  BMFReverseGeoShareURLOption.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFReverseGeoShareURLOption，The parameter map cannot be null !') {
    location =
        map['location'] == null ? null : BMFCoordinate.fromMap(map['location']);
    name = map['name'];
    snippet = map['snippet'];
  }

  @override
  fromMap(Map map) {
    return BMFReverseGeoShareURLOption.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'location': this.location?.toMap(),
      'name': this.name,
      'snippet': this.snippet
    };
  }
}

/// 路线规划短串分享
enum BMFRoutePlanShareURLType {
  ///<驾车路线规划短串分享
  DRIVE,

  ///<步行路线规划短串分享
  WALK,

  ///<骑行路线规划短串分享
  RIDE,

  ///<公交路线规划短串分享
  TRANSIT,
}

/// 路线规划短串分享检索信息类
class BMFRoutePlanShareURLOption implements BMFModel {
  /// 路线规划短串分享类型
  BMFRoutePlanShareURLType? routePlanType;

  /// 起点，可通过关键字、坐标两种方式指定，使用关键字时必须指定from.cityID
  BMFPlanNode? from;

  /// 终点，可通过关键字、坐标两种方式指定，使用关键字时必须指定to.cityID
  BMFPlanNode? to;

  /// cityID，当进行公交路线规划短串分享且起终点通过关键字指定时，必须指定
  int? cityID;

  /// 公交路线规划短串分享时使用，分享的是第几条线路
  int? routeIndex;

  /// 有参构造
  BMFRoutePlanShareURLOption({
    this.from,
    this.to,
    this.routePlanType,
    this.cityID,
    this.routeIndex,
  });

  /// map => BMFRoutePlanShareURLOption
  BMFRoutePlanShareURLOption.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFRoutePlanShareURLOption，The parameter map cannot be null !') {
    from = map['from'] == null ? null : BMFPlanNode.fromMap(map['from']);
    to = map['to'] == null ? null : BMFPlanNode.fromMap(map['to']);
    routePlanType =
        BMFRoutePlanShareURLType.values[map['routePlanType'] as int];
    cityID = map['cityID'];
    routeIndex = map['routeIndex'];
  }

  @override
  fromMap(Map map) {
    return BMFRoutePlanShareURLOption.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'from': this.from?.toMap(),
      'to': this.to?.toMap(),
      'routePlanType': this.routePlanType?.index,
      'cityID': this.cityID,
      'routeIndex': this.routeIndex
    };
  }
}
