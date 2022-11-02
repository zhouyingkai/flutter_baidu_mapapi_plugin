import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFModel;
import 'package:flutter_baidu_mapapi_search/src/common/bmf_routesearch_type.dart';
import 'package:flutter_baidu_mapapi_search/src/common/bmf_routestep.dart';

/// 公共交通路线查询结果类
class BMFBusLineResult implements BMFModel {
  /// 公交线路名称
  String? busLineName;

  /// 公交线路方向
  String? busLineDirection;

  /// 公交线路uid
  String? uid;

  /// 公交路线首班车时间
  String? startTime;

  /// 公交路线末班车时间
  String? endTime;

  /// 公交路线是否有月票
  bool? isMonTicket;

  /// 起步票价
  double? basicPrice;

  /// 全程票价
  double? totalPrice;

  /// 所有公交站点信息,成员类型为BMKBusStation
  List<BMFBusStation>? busStations;

  /// 公交路线分段信息，成员类型为BMKBusStep
  List<BMFBusStep>? busSteps;

  /// 有参构造
  BMFBusLineResult({
    this.busLineName,
    this.busLineDirection,
    this.uid,
    this.startTime,
    this.endTime,
    this.isMonTicket,
    this.basicPrice,
    this.totalPrice,
    this.busStations,
    this.busSteps,
  });

  /// map => BMFBusLineResult
  BMFBusLineResult.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFBusLineResult，The parameter map cannot be null !') {
    busLineName = map['busLineName'];
    busLineDirection = map['busLineDirection'];
    uid = map['uid'];
    startTime = map['startTime'];
    endTime = map['endTime'];
    isMonTicket = map['isMonTicket'];
    basicPrice = map['basicPrice'];
    totalPrice = map['totalPrice'];
    if (map['busStations'] != null) {
      List<BMFBusStation> tmpBusStations = [];
      map['busStations'].forEach((v) {
        tmpBusStations.add(BMFBusStation.fromMap(v as Map));
      });
      busStations = tmpBusStations;
    }

    if (map['busSteps'] != null) {
      List<BMFBusStep> tmpBusSteps = [];
      map['busSteps'].forEach((v) {
        tmpBusSteps.add(BMFBusStep.fromMap(v as Map));
      });
      busSteps = tmpBusSteps;
    }
  }

  @override
  fromMap(Map map) {
    return BMFBusLineResult.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'busLineName': this.busLineName,
      'busLineDirection': this.busLineDirection,
      'uid': this.uid,
      'startTime': this.startTime,
      'endTime': this.endTime,
      'isMonTicket': this.isMonTicket,
      'basicPrice': this.basicPrice,
      'totalPrice': this.totalPrice,
      'busStations': this.busStations?.map((e) => e.toMap()).toList(),
      'busSteps': this.busSteps?.map((e) => e.toMap()).toList()
    };
  }
}
