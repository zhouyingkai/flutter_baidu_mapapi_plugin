import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFModel;
import 'package:flutter_baidu_mapapi_search/src/common/bmf_routeline.dart';
import 'package:flutter_baidu_mapapi_search/src/common/bmf_routesearch_type.dart';

/// 步行路线规划结果类
class BMFWalkingRouteResult implements BMFModel {
  /// 返回起点或终点的地址信息结果
  BMFSuggestAddrInfo? suggestAddrResult;

  /// 步行结果,现在只返回一条。成员类型为BMFWalkingRouteLine
  List<BMFWalkingRouteLine>? routes;

  /// 打车信息,Android独有
  BMFTaxiInfo? taxiInfo;

  /// 有参构造
  BMFWalkingRouteResult({this.suggestAddrResult, this.routes});

  /// map => BMFWalkingRouteResult
  BMFWalkingRouteResult.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFWalkingRouteResult，The parameter map cannot be null !') {
    suggestAddrResult = map['suggestAddrResult'] == null
        ? null
        : BMFSuggestAddrInfo.fromMap(map['suggestAddrResult']);
    if (map['routes'] != null) {
      List<BMFWalkingRouteLine> tmpRoutes = [];
      map['routes'].forEach((v) {
        tmpRoutes.add(BMFWalkingRouteLine.fromMap(v as Map));
      });
      routes = tmpRoutes;
    }

    if (map['BMFTaxiInfo'] != null) {
      taxiInfo = BMFTaxiInfo.fromMap(map['BMFTaxiInfo']);
    }
  }

  @override
  fromMap(Map map) {
    return BMFWalkingRouteResult.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'suggestAddrResult': this.suggestAddrResult?.toMap(),
      'routes': this.routes?.map((e) => e.toMap()).toList(),
      'taxiInfo': this.taxiInfo?.toMap()
    };
  }
}

///  驾车路线规划结果类
class BMFDrivingRouteResult implements BMFModel {
  /// 返回起点或终点的地址信息结果
  BMFSuggestAddrInfo? suggestAddrResult;

  /// 驾车结果,支持多路线。成员类型为BMFDrivingRouteLine
  List<BMFDrivingRouteLine>? routes;

  /// 打车信息，Android独有
  List<BMFTaxiInfo>? taxiInfos;

  /// 有参构造
  BMFDrivingRouteResult({this.suggestAddrResult, this.routes, this.taxiInfos});

  /// map => BMFDrivingRouteResult
  BMFDrivingRouteResult.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFDrivingRouteResult，The parameter map cannot be null !') {
    suggestAddrResult = map['suggestAddrResult'] == null
        ? null
        : BMFSuggestAddrInfo.fromMap(map['suggestAddrResult']);
    if (map['routes'] != null) {
      List<BMFDrivingRouteLine> tmpRoutes = [];
      map['routes'].forEach((v) {
        tmpRoutes.add(BMFDrivingRouteLine.fromMap(v as Map));
      });
      routes = tmpRoutes;
    }

    if (map['taxiInfos'] != null) {
      List<BMFTaxiInfo> tmpTaxiInfos = [];
      map['taxiInfos'].forEach((v) {
        tmpTaxiInfos.add(BMFTaxiInfo.fromMap(v as Map));
      });
      taxiInfos = tmpTaxiInfos;
    }
  }

  @override
  fromMap(Map map) {
    return BMFDrivingRouteResult.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'suggestAddrResult': this.suggestAddrResult?.toMap(),
      'routes': this.routes?.map((e) => e.toMap()).toList(),
      'taxiInfos': this.taxiInfos?.map((e) => e.toMap()).toList()
    };
  }
}

/// 骑行路线规划结果类
class BMFRidingRouteResult implements BMFModel {
  /// 返回起点或终点的地址信息结果
  BMFSuggestAddrInfo? suggestAddrResult;

  /// 骑行路线结果,成员类型为BMFRidingRouteLine
  List<BMFRidingRouteLine>? routes;

  /// 有参构造
  BMFRidingRouteResult({this.suggestAddrResult, this.routes});

  /// map =>  BMFRidingRouteResult
  BMFRidingRouteResult.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFRidingRouteResult，The parameter map cannot be null !') {
    suggestAddrResult = map['suggestAddrResult'] == null
        ? null
        : BMFSuggestAddrInfo.fromMap(map['suggestAddrResult']);
    if (map['routes'] != null) {
      List<BMFRidingRouteLine> tmpRoutes = [];
      map['routes'].forEach((v) {
        tmpRoutes.add(BMFRidingRouteLine.fromMap(v as Map));
      });
      routes = tmpRoutes;
    }
  }

  @override
  fromMap(Map map) {
    return BMFRidingRouteResult.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'suggestAddrResult': this.suggestAddrResult?.toMap(),
      'routes': this.routes?.map((e) => e.toMap()).toList()
    };
  }
}

/// 公交路线规划结果类
class BMFTransitRouteResult implements BMFModel {
  /// 该路线打车信息
  BMFTaxiInfo? taxiInfo;

  /// 返回起点或终点的地址信息结果
  BMFSuggestAddrInfo? suggestAddrResult;

  /// 方案数组,成员类型为BMFTransitRouteLine
  List<BMFTransitRouteLine>? routes;

  /// 有参构造
  BMFTransitRouteResult({this.taxiInfo, this.suggestAddrResult, this.routes});

  /// map => BMFTransitRouteResult
  BMFTransitRouteResult.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFTransitRouteResult，The parameter map cannot be null !') {
    taxiInfo =
        map['taxiInfo'] == null ? null : BMFTaxiInfo.fromMap(map['taxiInfo']);
    suggestAddrResult = map['suggestAddrResult'] == null
        ? null
        : BMFSuggestAddrInfo.fromMap(map['suggestAddrResult']);
    if (map['routes'] != null) {
      List<BMFTransitRouteLine> tmpRoutes = [];
      map['routes'].forEach((v) {
        tmpRoutes.add(BMFTransitRouteLine.fromMap(v as Map));
      });
      routes = tmpRoutes;
    }
  }
  @override
  fromMap(Map map) {
    return BMFTransitRouteResult.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'taxiInfo': this.taxiInfo?.toMap(),
      'suggestAddrResult': this.suggestAddrResult?.toMap(),
      'routes': this.routes?.map((e) => e.toMap()).toList()
    };
  }
}

/// 跨城路线规划结果类
class BMFMassTransitRouteResult implements BMFModel {
  /// 返回起点或终点的地址信息结果
  BMFSuggestAddrInfo? suggestAddrResult;

  /// 方案数组,成员类型为BMKMassTransitRouteLine
  List<BMFMassTransitRouteLine>? routes;

  /// 总方案数
  int? totalRoutes;

  /// 该路线打车信息(只有起终点是大陆地区且是同城的请求时才返回此字段, 否则此字段为nil)
  BMFTaxiInfo? taxiInfo;

  /// 起点，Android
  BMFPlanNode? origin;

  /// 终点，Android独有
  BMFPlanNode? destination;

  /// 有参构造
  BMFMassTransitRouteResult({
    this.suggestAddrResult,
    this.routes,
    this.totalRoutes,
    this.taxiInfo,
    this.origin,
    this.destination,
  });

  /// map => BMFMassTransitRouteResult
  BMFMassTransitRouteResult.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFMassTransitRouteResult，The parameter map cannot be null !') {
    suggestAddrResult = map['suggestAddrResult'] == null
        ? null
        : BMFSuggestAddrInfo.fromMap(map['suggestAddrResult']);
    if (map['routes'] != null) {
      List<BMFMassTransitRouteLine> tmpRoutes = [];
      map['routes'].forEach((v) {
        tmpRoutes.add(BMFMassTransitRouteLine.fromMap(v as Map));
      });
      routes = tmpRoutes;
    }
    totalRoutes = map['totalRoutes'];
    taxiInfo =
        map['taxiInfo'] == null ? null : BMFTaxiInfo.fromMap(map['taxiInfo']);

    origin = map['origin'] == null ? null : BMFPlanNode.fromMap(map['origin']);

    destination = map['destination'] == null
        ? null
        : BMFPlanNode.fromMap(map['destination']);
  }

  @override
  fromMap(Map map) {
    return BMFMassTransitRouteResult.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'suggestAddrResult': this.suggestAddrResult?.toMap(),
      'routes': this.routes?.map((e) => e.toMap()).toList(),
      'totalRoutes': this.totalRoutes,
      'taxiInfo': this.taxiInfo?.toMap(),
      'origin': this.origin?.toMap(),
      'destination': this.destination?.toMap()
    };
  }
}

/// 室内路线规划结果类
class BMFIndoorRouteResult implements BMFModel {
  /// 方案数组,成员类型为BMFIndoorRouteLine
  List<BMFIndoorRouteLine>? routes;

  /// 有参构造
  BMFIndoorRouteResult({this.routes});

  /// map => BMFIndoorRouteResult
  BMFIndoorRouteResult.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFIndoorRouteResult，The parameter map cannot be null !') {
    if (map['routes'] != null) {
      List<BMFIndoorRouteLine> tmpRoutes = [];
      map['routes'].forEach((v) {
        tmpRoutes.add(BMFIndoorRouteLine.fromMap(v as Map));
      });
      routes = tmpRoutes;
    }
  }
  @override
  fromMap(Map map) {
    return BMFIndoorRouteResult.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {'routes': this.routes?.map((e) => e.toMap()).toList()};
  }
}
