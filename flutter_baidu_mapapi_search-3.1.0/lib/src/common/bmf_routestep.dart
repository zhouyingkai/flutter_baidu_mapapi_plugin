/// routeStep类型定义

import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFModel, BMFCoordinate;
import 'package:flutter_baidu_mapapi_search/src/common/bmf_routesearch_type.dart';
import 'package:flutter_baidu_mapapi_search/src/common/bmf_routevehicleInfo.dart';

/// 此类表示路线中的一个路段（基类）
class BMFRouteStep implements BMFModel {
  /// 路段长度 单位： 米
  int? distance;

  /// 路段耗时 单位： 秒
  int? duration;

  /// 路段所经过的坐标集合
  List<BMFCoordinate>? points;

  /// 路段所经过的地理坐标集合内点的个数
  ///
  /// Android 不支持
  int? pointsCount;

  /// 路段道路名称
  ///
  /// iOS 不支持
  String? name;

  /// 有参构造
  BMFRouteStep({
    this.distance,
    this.duration,
    this.points,
    this.pointsCount,
    this.name,
  });

  /// map => BMFRouteStep
  BMFRouteStep.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFRouteStep，The parameter map cannot be null !') {
    distance = map['distance'];
    duration = map['duration'];
    if (map['points'] != null) {
      List<BMFCoordinate> tmpPoints = [];
      map['points'].forEach((v) {
        tmpPoints.add(BMFCoordinate.fromMap(v as Map));
      });
      points = tmpPoints;
    }
    // points = points;
    pointsCount = map['pointsCount'];
    name = map['name'];
  }

  @override
  fromMap(Map map) {
    return BMFRouteStep.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'distance': this.distance,
      'duration': this.duration,
      'points': this.points?.map((e) => e.toMap()).toList(),
      'pointsCount': this.pointsCount,
      'name': this.name,
    };
  }
}

/// 此类表示公交线路中的一个路段
class BMFBusStep extends BMFRouteStep implements BMFModel {
  /// 有参构造
  BMFBusStep({
    int? distance,
    int? duration,
    List<BMFCoordinate>? points,
    int? pointsCount,
    String? name,
  }) : super(
          distance: distance,
          duration: duration,
          points: points,
          pointsCount: pointsCount,
          name: name,
        );

  /// map => BMFBusStep
  BMFBusStep.fromMap(Map map) : super.fromMap(map);

  @override
  fromMap(Map map) {
    return BMFBusStep.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'distance': this.distance,
      'duration': this.duration,
      'points': this.points?.map((e) => e.toMap()).toList(),
      'pointsCount': this.pointsCount,
      'name': this.name
    };
  }
}

/// 此类表示公交换乘路线中的一个路段
class BMFTransitStep extends BMFRouteStep implements BMFModel {
  /// 路段入口信息
  BMFRouteNode? entrace;

  /// 路段出口信息
  BMFRouteNode? exit;

  /// 路段换乘说明
  String? instruction;

  /// 路段类型
  BMFTransitStepType? stepType;

  /// 当路段为公交路段或地铁路段时，可以获取交通工具信息
  BMFVehicleInfo? vehicleInfo;

  /// 有参构造
  BMFTransitStep({
    int? distance,
    int? duration,
    List<BMFCoordinate>? points,
    int? pointsCount,
    String? name,
    this.entrace,
    this.exit,
    this.instruction,
    this.stepType,
    this.vehicleInfo,
  }) : super(
          distance: distance,
          duration: duration,
          points: points,
          pointsCount: pointsCount,
          name: name,
        );

  /// map => BMFTransitStep
  BMFTransitStep.fromMap(Map map) : super.fromMap(map) {
    entrace =
        map['entrace'] == null ? null : BMFRouteNode.fromMap(map['entrace']);
    exit = map['exit'] == null ? null : BMFRouteNode.fromMap(map['exit']);
    instruction = map['instruction'];
    stepType = BMFTransitStepType.values[map['stepType'] as int];
    vehicleInfo = map['vehicleInfo'] == null
        ? null
        : BMFVehicleInfo.fromMap(map['vehicleInfo']);
  }

  @override
  fromMap(Map map) {
    return BMFTransitStep.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'distance': this.distance,
      'duration': this.duration,
      'points': this.points?.map((e) => e.toMap()).toList(),
      'pointsCount': this.pointsCount,
      'name': this.name,
      'entrace': this.entrace?.toMap(),
      'exit': this.exit?.toMap(),
      'instruction': this.instruction,
      'stepType': this.stepType?.index,
      'vehicleInfo': this.vehicleInfo?.toMap()
    };
  }
}

/// 此类表示公共交通路线中的路段
class BMFMassTransitStep implements BMFModel {
  /// steps中是方案还是子路段
  ///
  /// ture:steps是BMFMassTransitStep的子路段（A到B需要经过多个steps）;
  /// false:steps是多个方案（A到B有多个方案选择）
  bool? isSubStep;

  /// 本BMFMassTransitStep中的有几个方案或几个子路段，成员类型为BMFMassTransitSubStep
  List<BMFMassTransitSubStep>? steps;

  /// 有参构造
  BMFMassTransitStep({this.isSubStep, this.steps});

  /// map => BMFMassTransitStep
  BMFMassTransitStep.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFMassTransitStep，The parameter map cannot be null !') {
    isSubStep = map['isSubStep'];
    if (map['steps'] != null) {
      List<BMFMassTransitSubStep> tmpSteps = [];
      map['steps'].forEach((v) {
        tmpSteps.add(BMFMassTransitSubStep.fromMap(v as Map));
      });
      steps = tmpSteps;
    }
  }

  @override
  fromMap(Map map) {
    return BMFMassTransitStep.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'isSubStep': this.isSubStep,
      'steps': this.steps?.map((e) => e.toMap()).toList()
    };
  }
}

/// 路况信息, Android独有
class BMFTrafficCondition implements BMFModel {
  /// 路况状态
  int? trafficStatus;

  int? trafficGeoCnt;

  BMFTrafficCondition.fromMap(Map map) {
    trafficStatus = map['trafficStatus'];
    trafficGeoCnt = map['trafficGeoCnt'];
  }

  @override
  fromMap(Map map) {
    return BMFTrafficCondition.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'trafficStatus': this.trafficStatus,
      'trafficGeoCnt': this.trafficGeoCnt
    };
  }
}

/// 此类表示公共交通路线中的一个路段
class BMFMassTransitSubStep extends BMFRouteStep implements BMFModel {
  /// 路段入口经纬度
  BMFCoordinate? entraceCoor;

  /// 路段出口经纬度
  BMFCoordinate? exitCoor;

  /// 路段说明
  String? instructions;

  /// 路段类型
  BMFMassTransitType? stepType;

  /// 该路段交通工具信息
  ///
  /// 当stepType为公交地铁时，BMFBusVehicleInfo对象；
  /// stepType为大巴时，BMFCoachVehicleInfo对象；
  /// stepType为飞机时，BMFPlaneVehicleInfo对象；
  /// stepType为火车时，BMFTrainVehicleInfo对象；其它为nil）
  BMFBaseVehicleInfo? vehicleInfo;

  /// 路况,Android独有
  List<BMFTrafficCondition>? trafficConditions;

  BMFMassTransitSubStep({
    int? distance,
    int? duration,
    List<BMFCoordinate>? points,
    int? pointsCount,
    String? name,
    this.entraceCoor,
    this.exitCoor,
    this.instructions,
    this.stepType,
    this.vehicleInfo,
    this.trafficConditions,
  }) : super(
          distance: distance,
          duration: duration,
          points: points,
          pointsCount: pointsCount,
          name: name,
        );

  /// map => BMFMassTransitSubStep
  BMFMassTransitSubStep.fromMap(Map map) : super.fromMap(map) {
    entraceCoor = map['entraceCoor'] == null
        ? null
        : BMFCoordinate.fromMap(map['entraceCoor']);
    exitCoor =
        map['exitCoor'] == null ? null : BMFCoordinate.fromMap(map['exitCoor']);
    instructions = map['instructions'];
    stepType = BMFMassTransitType.values[map['stepType'] as int];

    switch (stepType) {
      case BMFMassTransitType.BUSLINE:
      case BMFMassTransitType.SUBWAY:
        vehicleInfo = BMFBusVehicleInfo.fromMap(map['busAndSubwayVehicleInfo']);
        break;
      case BMFMassTransitType.COACH:
        vehicleInfo = BMFCoachVehicleInfo.fromMap(map['coachVehicleInfo']);
        break;
      case BMFMassTransitType.PLANE:
        vehicleInfo = BMFPlaneVehicleInfo.fromMap(map['planeVehicleInfo']);
        break;
      case BMFMassTransitType.TRAIN:
        vehicleInfo = BMFTrainVehicleInfo.fromMap(map['trainVehicleInfo']);
        break;
      default:
        break;
    }

    if (map['trafficConditions'] != null) {
      List<BMFTrafficCondition> tmpTrafficConditions = [];
      map['trafficConditions'].forEach((v) {
        tmpTrafficConditions.add(BMFTrafficCondition.fromMap(v as Map));
      });
      trafficConditions = tmpTrafficConditions;
    }
  }

  @override
  fromMap(Map map) {
    return BMFMassTransitSubStep.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'distance': this.distance,
      'duration': this.duration,
      'points': this.points?.map((e) => e.toMap()).toList(),
      'pointsCount': this.pointsCount,
      'name': this.name,
      'entraceCoor': this.entraceCoor?.toMap(),
      'exitCoor': this.exitCoor?.toMap(),
      'instructions': this.instructions,
      'stepType': this.stepType?.index,
      'vehicleInfo': this.vehicleInfo?.toMap(),
      'trafficConditions':
          this.trafficConditions?.map((e) => e.toMap()).toList(),
    };
  }
}

/// 此类表示步行路线中的一个路段
class BMFWalkingStep extends BMFRouteStep {
  /// 该路段起点方向值
  int? direction;

  /// 路段入口信息
  BMFRouteNode? entrace;

  /// 获取该路段入口指示信息
  String? entraceInstruction;

  /// 路段出口信息
  BMFRouteNode? exit;

  /// 获取该路段出口指示信息
  String? exitInstruction;

  /// 获取该路段指示信息
  String? instruction;

  /// 有参构造
  BMFWalkingStep({
    int? distance,
    int? duration,
    List<BMFCoordinate>? points,
    int? pointsCount,
    String? name,
    this.direction,
    this.entrace,
    this.entraceInstruction,
    this.exit,
    this.exitInstruction,
    this.instruction,
  }) : super(
          distance: distance,
          duration: duration,
          points: points,
          pointsCount: pointsCount,
          name: name,
        );

  /// map => BMFWalkingStep
  BMFWalkingStep.fromMap(Map map) : super.fromMap(map) {
    direction = map['direction'];
    entrace =
        map['entrace'] == null ? null : BMFRouteNode.fromMap(map['entrace']);
    entraceInstruction = map['entraceInstruction'];
    exit = map['exit'] == null ? null : BMFRouteNode.fromMap(map['exit']);
    exitInstruction = map['exitInstruction'];
    instruction = map['instruction'];
  }

  @override
  fromMap(Map map) {
    return BMFWalkingStep.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'distance': this.distance,
      'duration': this.duration,
      'points': this.points?.map((e) => e.toMap()).toList(),
      'pointsCount': this.pointsCount,
      'name': this.name,
      'direction': this.direction,
      'entrace': this.entrace?.toMap(),
      'entraceInstruction': this.entraceInstruction,
      'exit': this.exit?.toMap(),
      'exitInstruction': this.exitInstruction,
      'instruction': this.instruction
    };
  }
}

/// 此类表示骑行路线中的一个路段
class BMFRidingStep extends BMFRouteStep implements BMFModel {
  /// 该路段起点方向值
  int? direction;

  /// 路段入口信息
  BMFRouteNode? entrace;

  /// 获取该路段入口指示信息
  String? entraceInstruction;

  /// 路段出口信息
  BMFRouteNode? exit;

  /// 获取该路段出口指示信息
  String? exitInstruction;

  /// 获取该路段指示信息
  String? instruction;

  /// 路段转弯类型
  ///
  /// iOS 暂不支持
  String? turnType;

  /// 有参构造
  BMFRidingStep({
    int? distance,
    int? duration,
    List<BMFCoordinate>? points,
    int? pointsCount,
    String? name,
    this.direction,
    this.entrace,
    this.entraceInstruction,
    this.exit,
    this.exitInstruction,
    this.instruction,
    this.turnType,
  }) : super(
          distance: distance,
          duration: duration,
          points: points,
          pointsCount: pointsCount,
          name: name,
        );

  /// map => BMFRidingStep
  BMFRidingStep.fromMap(Map map) : super.fromMap(map) {
    direction = map['direction'];
    entrace =
        map['entrace'] == null ? null : BMFRouteNode.fromMap(map['entrace']);
    entraceInstruction = map['entraceInstruction'];
    exit = map['exit'] == null ? null : BMFRouteNode.fromMap(map['exit']);
    exitInstruction = map['exitInstruction'];
    instruction = map['instruction'];
    turnType = map['turnType'];
  }

  @override
  fromMap(Map map) {
    return BMFRidingStep.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'distance': this.distance,
      'duration': this.duration,
      'points': this.points?.map((e) => e.toMap()).toList(),
      'pointsCount': this.pointsCount,
      'name': this.name,
      'direction': this.direction,
      'entrace': this.entrace?.toMap(),
      'entraceInstruction': this.entraceInstruction,
      'exit': this.exit?.toMap(),
      'exitInstruction': this.exitInstruction,
      'instruction': this.instruction,
      'turnType': this.turnType,
    };
  }
}

/// 此类表示驾车路线中的一个路段
class BMFDrivingStep extends BMFRouteStep {
  /// 该路段起点方向值
  int? direction;

  /// 路段入口信息
  BMFRouteNode? entrace;

  /// 路段入口的指示信息
  String? entraceInstruction;

  /// 路段出口信息
  BMFRouteNode? exit;

  /// 路段出口指示信息
  String? exitInstruction;

  /// 路段总体指示信息
  String? instruction;

  /// 路段需要转弯数
  int? numTurns;

  /// 路段是否有路况信息
  bool? hasTrafficsInfo;

  /// 路段的路况信息，成员为NSNumber。0：无数据；1：畅通；2：缓慢；3：拥堵
  List<int>? traffics;

  /// 道路类型
  ///
  /// 枚举值：返回0-9之间的值
  /// 0：高速路  1：城市高速路  2:   国道  3：省道   4：县道    5：乡镇村道
  /// 6：其他道路  7：九级路  8：航线(轮渡)  9：行人道路
  int? roadLevel;

  /// 道路名称 Since 3.1.0
  String? roadName;

  BMFDrivingStep(
      {int? distance,
      int? duration,
      List<BMFCoordinate>? points,
      int? pointsCount,
      String? name,
      this.direction,
      this.entrace,
      this.entraceInstruction,
      this.exit,
      this.exitInstruction,
      this.instruction,
      this.numTurns,
      this.hasTrafficsInfo,
      this.traffics,
      this.roadLevel,
      this.roadName})
      : super(
          distance: distance,
          duration: duration,
          points: points,
          pointsCount: pointsCount,
          name: name,
        );

  /// map => BMFDrivingStep
  BMFDrivingStep.fromMap(Map map) : super.fromMap(map) {
    direction = map['direction'];
    entrace =
        map['entrace'] == null ? null : BMFRouteNode.fromMap(map['entrace']);
    entraceInstruction = map['entraceInstruction'];
    exit = map['exit'] == null ? null : BMFRouteNode.fromMap(map['exit']);
    exitInstruction = map['exitInstruction'];
    instruction = map['instruction'];
    numTurns = map['numTurns'];
    hasTrafficsInfo = map['hasTrafficsInfo'];
    if (map['traffics'] != null) {
      List<int> tmpTraffics = [];
      map['traffics'].forEach((v) {
        tmpTraffics.add(v as int);
      });
      traffics = tmpTraffics;
    }
    roadLevel = map['roadLevel'];
    roadName = map['roadName'];
  }

  @override
  fromMap(Map map) {
    return BMFDrivingStep.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'distance': this.distance,
      'duration': this.duration,
      'points': this.points?.map((e) => e.toMap()).toList(),
      'pointsCount': this.pointsCount,
      'name': this.name,
      'direction': this.direction,
      'entrace': this.entrace?.toMap(),
      'entraceInstruction': this.entraceInstruction,
      'exit': this.exit?.toMap(),
      'exitInstruction': this.exitInstruction,
      'instruction': this.instruction,
      'numTurns': this.numTurns,
      'hasTrafficsInfo': this.hasTrafficsInfo,
      'traffics': this.traffics?.map((e) => e).toList(),
      'roadLevel': this.roadLevel,
      'roadName': this.roadName
    };
  }
}

/// 此类表示室内路线的一个路段
class BMFIndoorRouteStep extends BMFRouteStep implements BMFModel {
  /// 入口信息
  BMFRouteNode? entrace;

  /// 出口信息
  BMFRouteNode? exit;

  /// 路段指示信息
  String? instructions;

  /// 建筑物id
  String? buildingid;

  /// 室内楼层id
  String? floorid;

  /// 结点数组，成员类型为：BMFIndoorStepNode
  List<BMFIndoorStepNode>? indoorStepNodes;

  /// 有参构造
  BMFIndoorRouteStep({
    int? distance,
    int? duration,
    List<BMFCoordinate>? points,
    int? pointsCount,
    String? name,
    this.entrace,
    this.exit,
    this.instructions,
    this.buildingid,
    this.floorid,
    this.indoorStepNodes,
  }) : super(
          distance: distance,
          duration: duration,
          points: points,
          pointsCount: pointsCount,
          name: name,
        );

  /// map => BMFIndoorRouteStep
  BMFIndoorRouteStep.fromMap(Map map) : super.fromMap(map) {
    entrace =
        map['entrace'] == null ? null : BMFRouteNode.fromMap(map['entrace']);
    exit = map['exit'] == null ? null : BMFRouteNode.fromMap(map['exit']);
    instructions = map['instructions'];
    buildingid = map['buildingid'];
    floorid = map['floorid'];
    if (map['indoorStepNodes'] != null) {
      List<BMFIndoorStepNode> tmpIndoorStepNodes = [];
      map['indoorStepNodes'].forEach((v) {
        tmpIndoorStepNodes.add(BMFIndoorStepNode.fromMap(v as Map));
      });
      indoorStepNodes = tmpIndoorStepNodes;
    }
  }

  @override
  fromMap(Map map) {
    return BMFIndoorRouteStep.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'distance': this.distance,
      'duration': this.duration,
      'points': this.points?.map((e) => e.toMap()).toList(),
      'pointsCount': this.pointsCount,
      'name': this.name,
      'entrace': this.entrace?.toMap(),
      'exit': this.exit?.toMap(),
      'instructions': this.instructions,
      'buildingid': this.buildingid,
      'floorid': this.floorid,
      'indoorStepNodes': this.indoorStepNodes?.map((e) => e.toMap()).toList()
    };
  }
}
