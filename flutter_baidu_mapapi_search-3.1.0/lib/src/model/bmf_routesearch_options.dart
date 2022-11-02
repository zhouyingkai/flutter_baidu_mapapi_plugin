import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFModel;
import 'package:flutter_baidu_mapapi_search/src/common/bmf_routesearch_type.dart';

/// 路线查询基础信息类
class BMFBaseRoutePlanOption implements BMFModel {
  ///  路线规划的起点
  ///
  /// 可通过关键字、坐标两种方式指定。cityID可参考官方网站-开发文档-开发资源
  /// 优先级：pt > cityID+name > cityName+name
  BMFPlanNode? from;

  /// 路线规划的终点
  ///
  /// 可通过关键字、坐标两种方式指定。cityID可参考官方网站-开发文档-开发资源
  /// 优先级：pt > cityID+name > cityName+name
  BMFPlanNode? to;

  /// 有参构造
  BMFBaseRoutePlanOption({required this.from, required this.to});

  /// map => BMFBaseRoutePlanOption
  BMFBaseRoutePlanOption.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFBaseRoutePlanOption，The parameter map cannot be null !') {
    from = map['from'] == null ? null : BMFPlanNode.fromMap(map['from']);
    to = map['to'] == null ? null : BMFPlanNode.fromMap(map['to']);
  }

  @override
  fromMap(Map map) {
    return BMFBaseRoutePlanOption.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {'from': this.from?.toMap(), 'to': this.to?.toMap()};
  }
}

/// 步行查询基础信息类
class BMFWalkingRoutePlanOption extends BMFBaseRoutePlanOption
    implements BMFModel {
  /// 有参构造
  BMFWalkingRoutePlanOption({
    required BMFPlanNode from,
    required BMFPlanNode to,
  }) : super(from: from, to: to);

  /// map => BMFWalkingRoutePlanOption
  BMFWalkingRoutePlanOption.fromMap(Map map) : super.fromMap(map);

  @override
  fromMap(Map map) {
    return BMFWalkingRoutePlanOption.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {'from': this.from?.toMap(), 'to': this.to?.toMap()};
  }
}

/// 驾车查询基础信息类
class BMFDrivingRoutePlanOption extends BMFBaseRoutePlanOption
    implements BMFModel {
  /// 驾车途经点
  List<BMFPlanNode>? wayPointsArray;

  /// 驾车检索策略
  /// 默认使用BMFDrivingPolicy.TIME_FIRST
  BMFDrivingPolicy? drivingPolicy;

  /// 驾车检索获取路线每一个step的路况
  ///
  /// 默认使用BMFDrivingRequestTrafficType.NONE
  BMFDrivingRequestTrafficType? drivingRequestTrafficType;

  /// 有参构造
  BMFDrivingRoutePlanOption({
    required BMFPlanNode from,
    required BMFPlanNode to,
    this.wayPointsArray,
    this.drivingPolicy: BMFDrivingPolicy.TIME_FIRST,
    this.drivingRequestTrafficType: BMFDrivingRequestTrafficType.NONE,
  }) : super(from: from, to: to);

  /// map => BMFDrivingRoutePlanOption
  BMFDrivingRoutePlanOption.fromMap(Map map) : super.fromMap(map) {
    if (map['wayPointsArray'] != null) {
      List<BMFPlanNode> tmpWayPointsArray = [];
      map['wayPointsArray'].forEach((v) {
        tmpWayPointsArray.add(BMFPlanNode.fromMap(v as Map));
      });
      wayPointsArray = tmpWayPointsArray;
    }
    drivingPolicy = BMFDrivingPolicy.values[map['drivingPolicy'] as int];
    drivingRequestTrafficType = BMFDrivingRequestTrafficType
        .values[map['drivingRequestTrafficType'] as int];
  }
  @override
  fromMap(Map map) {
    return BMFDrivingRoutePlanOption.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'from': this.from?.toMap(),
      'to': this.to?.toMap(),
      'wayPointsArray': this.wayPointsArray?.map((e) => e.toMap()).toList(),
      'drivingPolicy': this.drivingPolicy?.index,
      'drivingRequestTrafficType': this.drivingRequestTrafficType?.index
    };
  }
}

/// 骑行查询基础信息类
class BMFRidingRoutePlanOption extends BMFBaseRoutePlanOption
    implements BMFModel {
  /// 骑行类型（0：普通骑行，1：电动车骑行）
  ///
  /// 默认是普通骑行
  int? ridingType;

  /// 有参构造
  BMFRidingRoutePlanOption({
    required BMFPlanNode from,
    required BMFPlanNode to,
    this.ridingType: 0,
  }) : super(from: from, to: to);

  /// map => BMFRidingRoutePlanOption
  BMFRidingRoutePlanOption.fromMap(Map map) : super.fromMap(map) {
    ridingType = map['ridingType'] as int?;
  }

  @override
  fromMap(Map map) {
    return BMFRidingRoutePlanOption.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'from': this.from?.toMap(),
      'to': this.to?.toMap(),
      'ridingType': this.ridingType
    };
  }
}

/// 公交查询基础信息类
class BMFTransitRoutePlanOption extends BMFBaseRoutePlanOption
    implements BMFModel {
  /// 城市名，用于在哪个城市内进行检索
  String? city;

  /// 公交检索策略，
  ///
  /// 默认使用 BMFTransitPolicy.TIME_FIRST
  BMFTransitPolicy? transitPolicy;

  /// 有参构造
  BMFTransitRoutePlanOption({
    required BMFPlanNode from,
    required BMFPlanNode to,
    this.city,
    this.transitPolicy: BMFTransitPolicy.TIME_FIRST,
  }) : super(from: from, to: to);

  /// map => BMFTransitRoutePlanOption
  BMFTransitRoutePlanOption.fromMap(Map map) : super.fromMap(map) {
    city = map['city'];
    transitPolicy = BMFTransitPolicy.values[map['transitPolicy'] as int];
  }

  @override
  fromMap(Map map) {
    return BMFTransitRoutePlanOption.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'from': this.from?.toMap(),
      'to': this.to?.toMap(),
      'city': this.city,
      'transitPolicy': this.transitPolicy!.index
    };
  }
}

/// 公共交通路线查询基础信息类（支持市内和跨城）(注：起终点城市不支持cityId)
class BMFMassTransitRoutePlanOption extends BMFBaseRoutePlanOption
    implements BMFModel {
  /// 分页索引，可选，
  ///
  /// 默认为0(从0开始)
  int? pageIndex;

  /// 分页数量，可选，
  ///
  /// 默认为10，取值范围 1~10
  int? pageCapacity;

  /// 市内公交换乘策略，可选，
  ///
  /// 默认使用BMFMassTransitIncityPolicy.RECOMMEND
  BMFMassTransitIncityPolicy? incityPolicy;

  /// 跨城公交换乘策略，可选，
  ///
  /// 默认使用BMFMassTransitIntercityPolicy.TIME_FIRST
  BMFMassTransitIntercityPolicy? intercityPolicy;

  /// 跨城交通方式策略，可选，
  ///
  /// 默认使用BMFMassTransitIntercityTransPolicy.TRAIN_FIRST
  BMFMassTransitIntercityTransPolicy? intercityTransPolicy;

  /// 有参构造
  BMFMassTransitRoutePlanOption({
    required BMFPlanNode from,
    required BMFPlanNode to,
    this.pageCapacity: 10,
    this.pageIndex: 0,
    this.incityPolicy: BMFMassTransitIncityPolicy.RECOMMEND,
    this.intercityPolicy: BMFMassTransitIntercityPolicy.TIME_FIRST,
    this.intercityTransPolicy: BMFMassTransitIntercityTransPolicy.TRAIN_FIRST,
  }) : super(from: from, to: to);

  /// map => BMFMassTransitRoutePlanOption
  BMFMassTransitRoutePlanOption.fromMap(Map map) : super.fromMap(map) {
    pageCapacity = map['pageCapacity'] as int?;
    pageIndex = map['pageIndex'] as int?;
    incityPolicy =
        BMFMassTransitIncityPolicy.values[map['incityPolicy'] as int];
    intercityPolicy =
        BMFMassTransitIntercityPolicy.values[map['intercityPolicy'] as int];
    intercityTransPolicy = BMFMassTransitIntercityTransPolicy
        .values[map['intercityTransPolicy'] as int];
  }

  @override
  fromMap(Map map) {
    return BMFMassTransitRoutePlanOption.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'from': this.from?.toMap(),
      'to': this.to?.toMap(),
      'pageCapacity': this.pageCapacity,
      'pageIndex': this.pageIndex,
      'incityPolicy': this.incityPolicy?.index,
      'intercityPolicy': this.intercityPolicy?.index,
      'intercityTransPolicy': this.intercityTransPolicy?.index
    };
  }
}

/// 室内路线规划查询基础信息类
class BMFIndoorRoutePlanOption implements BMFModel {
  /// 规划的起点
  BMFIndoorPlanNode? from;

  /// 规划的终点
  BMFIndoorPlanNode? to;

  /// 有参构造
  BMFIndoorRoutePlanOption({required this.from, required this.to});

  /// map => BMFIndoorRoutePlanOption
  BMFIndoorRoutePlanOption.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFIndoorRoutePlanOption，The parameter map cannot be null !') {
    from = map['from'] == null ? null : BMFIndoorPlanNode.fromMap(map['from']);
    to = map['to'] == null ? null : BMFIndoorPlanNode.fromMap(map['to']);
  }
  @override
  fromMap(Map map) {
    return BMFIndoorRoutePlanOption.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {'from': this.from?.toMap(), 'to': this.to?.toMap()};
  }
}
