/// routeVehicleInfo类型定义
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFModel;

/// 路线换乘方案里的交通工具信息类
class BMFVehicleInfo implements BMFModel {
  /// 该交通路线的标识
  String? uid;

  /// 该交通路线的名称
  String? title;

  /// 该交通路线的所乘站数
  int? passStationNum;

  /// 该交通路线的全程价格
  int? totalPrice;

  /// 该交通路线的所乘区间的区间价格
  int? zonePrice;

  /// 有参构造
  BMFVehicleInfo({
    this.uid,
    this.title,
    this.passStationNum,
    this.totalPrice,
    this.zonePrice,
  });

  /// map => BMFVehicleInfo
  BMFVehicleInfo.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFVehicleInfo，The parameter map cannot be null !') {
    uid = map['uid'];
    title = map['title'];
    passStationNum = map['passStationNum'];
    totalPrice = map['totalPrice'];
    zonePrice = map['zonePrice'];
  }

  @override
  fromMap(Map map) {
    return BMFVehicleInfo.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'uid': this.uid,
      'title': this.title,
      'passStationNum': this.passStationNum,
      'totalPrice': this.totalPrice,
      'zonePrice': this.zonePrice
    };
  }
}

/// 公共交通方案里的交通工具信息基类类
class BMFBaseVehicleInfo implements BMFModel {
  /// 该交通路线的名称
  String? name;

  /// 出发站
  String? departureStation;

  /// 到达站
  String? arriveStation;

  /// 出发时间(BMFBusVehicleInfo时departureTime为空)
  String? departureTime;

  /// 到达时间(BMFBusVehicleInfo时arriveTime为空)
  String? arriveTime;

  /// 有参构造
  BMFBaseVehicleInfo({
    this.name,
    this.departureStation,
    this.arriveStation,
    this.departureTime,
    this.arriveTime,
  });

  /// map => BMFBaseVehicleInfo
  BMFBaseVehicleInfo.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFBaseVehicleInfo，The parameter map cannot be null !') {
    name = map['name'];
    departureStation = map['departureStation'];
    arriveTime = map['arriveTime'];
    departureTime = map['departureTime'];
    arriveStation = map['arriveStation'];
  }
  @override
  fromMap(Map map) {
    return BMFBaseVehicleInfo.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'name': this.name,
      'departureStation': this.departureStation,
      'arriveTime': this.arriveTime,
      'departureTime': this.departureTime,
      'arriveStation': this.arriveStation
    };
  }
}

/// 公共交通方案里的交通工具信息类- 公交车、地铁
class BMFBusVehicleInfo extends BMFBaseVehicleInfo implements BMFModel {
  /// 该交通路线的所乘站数
  int? passStationNum;

  /// 始发车发车时间
  String? firstTime;

  /// 末班车发车时间
  String? lastTime;

  /// 市内公交的具体类型
  ///
  /// Android独有
  int? type;

  /// 有参构造
  BMFBusVehicleInfo({
    String? name,
    String? departureStation,
    String? arriveStation,
    String? departureTime,
    String? arriveTime,
    this.passStationNum,
    this.firstTime,
    this.lastTime,
    this.type,
  }) : super(
          name: name,
          departureStation: departureStation,
          arriveStation: arriveStation,
          departureTime: departureTime,
          arriveTime: arriveTime,
        );

  /// map => BMFBusVehicleInfo
  BMFBusVehicleInfo.fromMap(Map map) : super.fromMap(map) {
    passStationNum = map['passStationNum'];
    firstTime = map['firstTime'];
    lastTime = map['lastTime'];
    type = map['type'];
  }

  @override
  fromMap(Map map) {
    return BMFBusVehicleInfo.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'name': this.name,
      'departureStation': this.departureStation,
      'arriveTime': this.arriveTime,
      'departureTime': this.departureTime,
      'arriveStation': this.arriveStation,
      'passStationNum': this.passStationNum,
      'firstTime': this.firstTime,
      'lastTime': this.lastTime,
      'type': this.type,
    };
  }
}

/// 公共交通方案里的交通工具信息类 - 飞机
class BMFPlaneVehicleInfo extends BMFBaseVehicleInfo implements BMFModel {
  /// 价格（单位：元）
  double? price;

  /// 折扣
  double? discount;

  /// 航空公司
  String? airlines;

  /// 订票网址
  String? bookingUrl;

  /// 有参构造
  BMFPlaneVehicleInfo({
    String? name,
    String? departureStation,
    String? arriveStation,
    String? departureTime,
    String? arriveTime,
    this.price,
    this.discount,
    this.airlines,
    this.bookingUrl,
  }) : super(
          name: name,
          departureStation: departureStation,
          arriveStation: arriveStation,
          departureTime: departureTime,
          arriveTime: arriveTime,
        );

  /// map => BMFPlaneVehicleInfo
  BMFPlaneVehicleInfo.fromMap(Map map) : super.fromMap(map) {
    price = map['price'];
    discount = map['discount'];
    airlines = map['airlines'];
    bookingUrl = map['bookingUrl'];
  }

  @override
  fromMap(Map map) {
    return BMFPlaneVehicleInfo.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'name': this.name,
      'departureStation': this.departureStation,
      'arriveTime': this.arriveTime,
      'departureTime': this.departureTime,
      'arriveStation': this.arriveStation,
      'price': this.price,
      'discount': this.discount,
      'airlines': this.airlines,
      'bookingUrl': this.bookingUrl
    };
  }
}

/// 公共交通方案里的交通工具信息类 - 火车
class BMFTrainVehicleInfo extends BMFBaseVehicleInfo implements BMFModel {
  /// 价格（单位：元）
  double? price;

  /// 订票电话
  String? booking;

  /// 有参构造
  BMFTrainVehicleInfo({
    String? name,
    String? departureStation,
    String? arriveStation,
    String? departureTime,
    String? arriveTime,
    this.price,
    this.booking,
  }) : super(
          name: name,
          departureStation: departureStation,
          arriveStation: arriveStation,
          departureTime: departureTime,
          arriveTime: arriveTime,
        );

  /// map => BMFTrainVehicleInfo
  BMFTrainVehicleInfo.fromMap(Map map) : super.fromMap(map) {
    price = map['price'];
    booking = map['booking'];
  }
  @override
  fromMap(Map map) {
    return BMFTrainVehicleInfo.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'name': this.name,
      'departureStation': this.departureStation,
      'arriveTime': this.arriveTime,
      'departureTime': this.departureTime,
      'arriveStation': this.arriveStation,
      'price': this.price,
      'booking': this.booking
    };
  }
}

/// 公共交通方案里的交通工具信息类 - 大巴
class BMFCoachVehicleInfo extends BMFBaseVehicleInfo implements BMFModel {
  /// 价格（单位：元）
  double? price;

  /// 订票网址
  String? bookingUrl;

  /// 合作方名称
  String? providerName;

  /// 合作方官网
  String? providerUrl;

  /// 有参构造
  BMFCoachVehicleInfo({
    String? name,
    String? departureStation,
    String? arriveStation,
    String? departureTime,
    String? arriveTime,
    this.price,
    this.bookingUrl,
    this.providerName,
    this.providerUrl,
  }) : super(
          name: name,
          departureStation: departureStation,
          arriveStation: arriveStation,
          departureTime: departureTime,
          arriveTime: arriveTime,
        );

  /// map => BMFCoachVehicleInfo
  BMFCoachVehicleInfo.fromMap(Map map) : super.fromMap(map) {
    price = map['price'];
    bookingUrl = map['bookingUrl'];
    providerName = map['providerName'];
    providerUrl = map['providerUrl'];
  }
  @override
  fromMap(Map map) {
    return BMFCoachVehicleInfo.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'name': this.name,
      'departureStation': this.departureStation,
      'arriveTime': this.arriveTime,
      'departureTime': this.departureTime,
      'arriveStation': this.arriveStation,
      'price': this.price,
      'bookingUrl': this.bookingUrl,
      'providerName': this.providerName,
      'providerUrl': this.providerUrl
    };
  }
}
