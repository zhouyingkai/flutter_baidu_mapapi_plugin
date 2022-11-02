/// route公共类型定义

import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFModel, BMFCoordinate;
import 'package:flutter_baidu_mapapi_search/src/common/bmf_poisearch_type.dart'
    show BMFPoiInfo;

///路段类型枚举
enum BMFTransitStepType {
  ///<公交
  BUSLINE,

  ///<地铁
  SUBWAY,

  ///<步行
  WAKLING,
}

/// 交通方式枚举
enum BMFMassTransitType {
  ///<地铁
  SUBWAY,

  ///<火车
  TRAIN,

  ///<飞机
  PLANE,

  ///<公交
  BUSLINE,

  ///<驾车
  DRIVING,

  ///<步行
  WAKLING,

  ///<大巴
  COACH,
}

/// 室内路线结点类型
enum BMFIndoorStepNodeType {
  ///<直梯
  ELEVATOR,

  ///<扶梯
  ESCALATOR,

  ///<楼梯
  STAIR,

  ///<安检
  SECURITY_CHECK,
}

/// 公交策略
enum BMFTransitPolicy {
  ///<较快捷(公交)
  TIME_FIRST,

  ///<少换乘(公交)
  TRANSFER_FIRST,

  ///<少步行(公交)
  WALK_FIRST,

  ///<不坐地铁
  NO_SUBWAY,
}

/// 公共交通：市内公交换乘策略
enum BMFMassTransitIncityPolicy {
  ///<推荐
  RECOMMEND,

  ///<少换乘
  TRANSFER_FIRST,

  ///<少步行
  WALK_FIRST,

  ///<不坐地铁
  NO_SUBWAY,

  ///<较快捷
  TIME_FIRST,

  ///<地铁优先
  SUBWAY_FIRST,
}

/// 公共交通：跨城公交换乘策略
enum BMFMassTransitIntercityPolicy {
  /// 较快捷
  TIME_FIRST,

  /// 出发早
  START_EARLY,

  /// 价格低
  PRICE_FIRST,
}

/// 公共交通：跨城交通方式策略
enum BMFMassTransitIntercityTransPolicy {
  ///火车优先
  TRAIN_FIRST,

  ///<飞机优先
  PLANE_FIRST,

  ///<大巴优先
  BUS_FIRST,
}

/// 驾车策略
enum BMFDrivingPolicy {
  ///<躲避拥堵(自驾)
  BLK_FIRST,

  ///<最短时间(自驾)
  TIME_FIRST,

  ///<最短路程(自驾)
  DIS_FIRST,

  ///<少走高速(自驾)
  FEE_FIRST,
}

enum BMFDrivingRequestTrafficType {
  ///<不带路况
  NONE,

  ///<道路和路况
  PATH_AND_TRAFFICE,
}

/// 打车信息类
class BMFTaxiInfo implements BMFModel {
  ///路线打车描述信息
  String? desc;

  ///总路程，单位： 米
  int? distance;

  ///总耗时，单位： 秒
  int? duration;

  ///每千米单价(白天)，单位 元
  double? perKMPrice;

  ///起步价(白天)，单位 元
  double? startPrice;

  ///总价(预估) , 单位： 元
  double? totalPrice;

  /// 有参构造
  BMFTaxiInfo({
    this.desc,
    this.distance,
    this.duration,
    this.perKMPrice,
    this.startPrice,
    this.totalPrice,
  });

  /// map => BMFTaxiInfo
  BMFTaxiInfo.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFTaxiInfo，The parameter map cannot be null !') {
    desc = map['desc'];
    distance = map['distance'];
    duration = map['duration'];
    perKMPrice = map['perKMPrice'];
    startPrice = map['startPrice'];
    totalPrice = map['totalPrice'];
  }
  @override
  fromMap(Map map) {
    return BMFTaxiInfo.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'desc': this.desc,
      'distance': this.distance,
      'duration': this.duration,
      'perKMPrice': this.perKMPrice,
      'startPrice': this.startPrice,
      'totalPrice': this.totalPrice
    };
  }
}

/// 此类代表一个时间段，每个属性都是一个时间段。
class BMFTime implements BMFModel {
  /// 时间段，单位（天）
  int? dates;

  /// 时间段，单位（小时）
  int? hours;

  /// 时间段，单位（分）
  int? minutes;

  /// 时间段，单位（秒）
  int? seconds;

  /// 有参构造
  BMFTime({this.dates, this.hours, this.minutes, this.seconds});

  /// map => BMFTime
  BMFTime.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFTime，The parameter map cannot be null !') {
    dates = map['dates'];
    hours = map['hours'];
    minutes = map['minutes'];
    seconds = map['seconds'];
  }
  @override
  fromMap(Map map) {
    return BMFTime.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'dates': this.dates,
      'hours': this.hours,
      'minutes': this.minutes,
      'seconds': this.seconds
    };
  }
}

/// 此类表示路线中的一节点，节点包括：路线起终点，公交站点等
class BMFRouteNode implements BMFModel {
  /// 该节点uid
  String? uid;

  /// 该节点的名称
  String? title;

  /// 该节点的坐标
  BMFCoordinate? location;

  /// 有参构造
  BMFRouteNode({this.uid, this.title, this.location});

  /// map => BMFRouteNode
  BMFRouteNode.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFRouteNode，The parameter map cannot be null !') {
    uid = map['uid'];
    title = map['title'];
    location =
        map['location'] == null ? null : BMFCoordinate.fromMap(map['location']);
  }
  @override
  fromMap(Map map) {
    return BMFRouteNode.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'uid': this.uid,
      'title': this.title,
      'location': this.location?.toMap()
    };
  }
}

/// 此类表示公交站点信息
class BMFBusStation extends BMFRouteNode implements BMFModel {
  /// 有参构造
  BMFBusStation({
    String? uid,
    String? title,
    BMFCoordinate? location,
  }) : super(uid: uid, title: title, location: location);

  /// map => BMFBusStation
  BMFBusStation.fromMap(Map map) : super.fromMap(map);

  @override
  fromMap(Map map) {
    return BMFBusStation.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'uid': this.uid,
      'title': this.title,
      'location': this.location?.toMap()
    };
  }
}

/// 室内路线结点
class BMFIndoorStepNode implements BMFModel {
  /// 坐标
  BMFCoordinate? coordinate;

  /// 类型
  BMFIndoorStepNodeType? type;

  /// 描述
  String? desc;

  /// 有参构造
  BMFIndoorStepNode({this.coordinate, this.type, this.desc});

  /// map => BMFIndoorStepNode
  BMFIndoorStepNode.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFIndoorStepNode，The parameter map cannot be null !') {
    coordinate = map['coordinate'] == null
        ? null
        : BMFCoordinate.fromMap(map['coordinate']);
    type = BMFIndoorStepNodeType.values[map['type'] as int];
    desc = map['desc'];
  }

  @override
  fromMap(Map map) {
    return BMFIndoorStepNode.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'coordinate': this.coordinate?.toMap(),
      'type': this.type?.index,
      'desc': this.desc
    };
  }
}

/// 路线搜索地址结果类.当输入的起点或终点有多个地点选择时，或者选定的城市没有此地点，但其它城市有(驾乘或步行)，返回该类的实例
class BMFSuggestAddrInfo implements BMFModel {
  /// 起点POI列表，成员类型为BMFPoiInfo
  List<BMFPoiInfo>? startPoiList;

  /// 起点城市列表，成员类型为BMFCityListInfo,如果输入的地点在本城市没有而在其它城市有，则返回其它城市的信息
  List<BMFCityListInfo>? startCityList;

  /// 终点POI列表，成员类型为BMFPoiInfo
  List<BMFPoiInfo>? endPoiList;

  /// 终点城市列表，成员类型为BMFCityListInfo,如果输入的地点在本城市没有而在其它城市有，则返回其它城市的信息
  List<BMFCityListInfo>? endCityList;

  /// 途经点POI列表，成员类型为NSArray<BMFPoiInfo*>
  List<List<BMFPoiInfo>>? wayPointPoiList;

  /// 途经点城市列表，成员类型为NSArray<BMFCityListInfo*>,如果输入的地点在本城市没有而在其它城市有，则返回其它城市的信息
  List<List<BMFCityListInfo>>? wayPointCityList;

  /// 有参构造
  BMFSuggestAddrInfo({
    this.startPoiList,
    this.startCityList,
    this.endPoiList,
    this.endCityList,
    this.wayPointPoiList,
    this.wayPointCityList,
  });

  /// map => BMFSuggestAddrInfo
  BMFSuggestAddrInfo.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFSuggestAddrInfo，The parameter map cannot be null !') {
    if (map['startPoiList'] != null) {
      List<BMFPoiInfo> tmpStartPoiList = [];

      map['startPoiList'].forEach((v) {
        tmpStartPoiList.add(BMFPoiInfo.fromMap(v as Map));
      });
      startPoiList = tmpStartPoiList;
    }

    if (map['startCityList'] != null) {
      List<BMFCityListInfo> tmpStartCityList = [];

      map['startCityList'].forEach((v) {
        tmpStartCityList.add(BMFCityListInfo.fromMap(v as Map));
      });
      startCityList = tmpStartCityList;
    }

    if (map['endPoiList'] != null) {
      List<BMFPoiInfo> tmpEndPoiList = [];
      map['endPoiList'].forEach((v) {
        tmpEndPoiList.add(BMFPoiInfo.fromMap(v as Map));
      });
      endPoiList = tmpEndPoiList;
    }

    if (map['endCityList'] != null) {
      List<BMFCityListInfo> tmpEndCityList = [];
      map['endCityList'].forEach((v) {
        tmpEndCityList.add(BMFCityListInfo.fromMap(v as Map));
      });
      endCityList = tmpEndCityList;
    }

    if (map['wayPointPoiList'] != null) {
      List<List<BMFPoiInfo>> tmpWayPointPoiList = [];
      for (List item in (map['wayPointPoiList'] as List)) {
        List<BMFPoiInfo> list = [];
        for (var ite in item) {
          BMFPoiInfo info = BMFPoiInfo.fromMap(ite as Map);
          list.add(info);
        }
        tmpWayPointPoiList.add(list);
      }
      wayPointPoiList = tmpWayPointPoiList;
    }

    if (map['wayPointCityList'] != null) {
      List<List<BMFCityListInfo>> tmpWayPointCityList = [];
      for (List item in (map['wayPointCityList'] as List)) {
        List<BMFCityListInfo> list = [];
        for (var ite in item) {
          BMFCityListInfo cityListInfo = BMFCityListInfo.fromMap(ite as Map);
          list.add(cityListInfo);
        }
        tmpWayPointCityList.add(list);
      }
      wayPointCityList = tmpWayPointCityList;
    }
  }
  @override
  fromMap(Map map) {
    return BMFSuggestAddrInfo.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'startPoiList': this.startPoiList?.map((e) => e.toMap()).toList(),
      'startCityList': this.startCityList?.map((e) => e.toMap()).toList(),
      'endPoiList': this.endPoiList?.map((e) => e.toMap()).toList(),
      'endCityList': this.endCityList?.map((e) => e.toMap()).toList(),
      'wayPointPoiList': this
          .wayPointPoiList
          ?.map((list) => list.map((info) => info.toMap()).toList())
          .toList(),
      'wayPointCityList': this
          .wayPointCityList
          ?.map((list) => list.map((cityInfo) => cityInfo.toMap()).toList())
          .toList()
    };
  }
}

/// 城市列表信息类
class BMFCityListInfo implements BMFModel {
  /// 城市名称
  String? city;

  /// 该城市所含搜索结果数目
  int? count;

  /// 有参构造
  BMFCityListInfo({this.city, this.count});

  /// map => BMFCityListInfo
  BMFCityListInfo.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFCityListInfo，The parameter map cannot be null !') {
    city = map['city'];
    count = map['count'];
  }

  @override
  fromMap(Map map) {
    return BMFCityListInfo.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {'city': this.city, 'count': this.count};
  }
}

/// 线路检索节点信息,一个路线检索节点可以通过经纬度坐标或城市名加地名确定
class BMFPlanNode implements BMFModel {
  /// 节点所在城市
  String? cityName;

  /// 节点所在城市ID
  ///
  /// Android不支持该属性
  int? cityID;

  /// 节点名称
  String? name;

  /// 节点坐标
  BMFCoordinate? pt;

  /// 有参构造
  BMFPlanNode({this.cityName, this.cityID, this.name, this.pt});

  /// map => BMFPlanNode
  BMFPlanNode.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFPlanNode，The parameter map cannot be null !') {
    cityName = map['cityName'];
    cityID = map['cityID'];
    name = map['name'];
    pt = map['pt'] == null ? null : BMFCoordinate.fromMap(map['pt']);
  }
  @override
  fromMap(Map map) {
    return BMFPlanNode.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'cityName': this.cityName,
      'cityID': this.cityID,
      'name': this.name,
      'pt': this.pt?.toMap()
    };
  }
}

/// 室内路线检索节点信息
class BMFIndoorPlanNode implements BMFModel {
  /// 节点所在楼层
  String? floor;

  /// 节点坐标
  BMFCoordinate? pt;

  /// 有参构造
  BMFIndoorPlanNode({this.floor, this.pt});

  /// map => BMFIndoorPlanNode
  BMFIndoorPlanNode.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFIndoorPlanNode，The parameter map cannot be null !') {
    floor = map['floor'];
    pt = map['pt'] == null ? null : BMFCoordinate.fromMap(map['pt']);
  }
  @override
  fromMap(Map map) {
    return BMFIndoorPlanNode.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {'floor': this.floor, 'pt': this.pt?.toMap()};
  }
}

/// 此类表示地址结果的层次化信息
class BMFAddressComponent implements BMFModel {
  /// 国家
  String? country;

  /// 省份名称
  String? province;

  /// 城市名称
  String? city;

  /// 区县名称
  String? district;

  /// 乡镇
  String? town;

  /// 街道名称
  String? streetName;

  /// 街道号码
  String? streetNumber;

  /// 行政区域编码
  String? adCode;

  /// 国家代码
  String? countryCode;

  /// 相对当前坐标点的方向，当有门牌号的时候返回数据
  String? direction;

  /// 相对当前坐标点的距离，当有门牌号的时候返回数据
  String? distance;

  /// 有参构造
  BMFAddressComponent({
    this.country,
    this.province,
    this.city,
    this.district,
    this.town,
    this.streetName,
    this.streetNumber,
    this.adCode,
    this.countryCode,
    this.direction,
    this.distance,
  });

  /// map => BMFAddressComponent
  BMFAddressComponent.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFAddressComponent，The parameter map cannot be null !') {
    country = map['country'];
    province = map['province'];
    city = map['city'];
    district = map['district'];
    town = map['town'];
    streetName = map['streetName'];
    streetNumber = map['streetNumber'];
    adCode = map['adCode'];
    countryCode = map['countryCode'];
    direction = map['direction'];
    distance = map['distance'];
  }
  @override
  fromMap(Map map) {
    return BMFAddressComponent.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'country': this.country,
      'province': this.province,
      'city': this.city,
      'district': this.district,
      'town': this.town,
      'streetName': this.streetName,
      'adCode': this.adCode,
      'countryCode': this.countryCode,
      'direction': this.direction,
      'distance': this.distance
    };
  }
}
