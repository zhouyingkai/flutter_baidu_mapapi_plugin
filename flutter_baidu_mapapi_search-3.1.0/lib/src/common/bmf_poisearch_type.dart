/// poi公共类型定义

import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFModel, BMFCoordinate;

/// POI详情子节点信息类，需要权限（使用带有此权限的AK）
class BMFPOIDetailChildrenInfo implements BMFModel {
  /// poi子点uid
  String? uid;

  /// poi子点名称
  String? name;

  /// poi子点简称
  String? showName;

  /// poi子点类别
  String? tag;

  /// poi子节点经纬度
  BMFCoordinate? pt;

  /// poi子点地址
  String? address;

  /// BMFPOIDetailChildrenInfo构造方法
  BMFPOIDetailChildrenInfo({
    this.uid,
    this.name,
    this.showName,
    this.tag,
    this.pt,
    this.address,
  });

  /// map => BMFPOIDetailChildrenInfo
  BMFPOIDetailChildrenInfo.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFPOIDetailChildrenInfo，The parameter map cannot be null !') {
    name = map['name'];
    uid = map['uid'];
    tag = map['tag'];
    showName = map['showName'];
    address = map['address'];
    pt = map['pt'] == null ? null : BMFCoordinate.fromMap(map['pt']);
  }
  @override
  fromMap(Map map) {
    return BMFPOIDetailChildrenInfo.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'name': this.name,
      'uid': this.uid,
      'tag': this.tag,
      'showName': this.showName,
      'address': this.address,
      'pt': this.pt?.toMap()
    };
  }
}

/// POI信息类
class BMFPoiInfo implements BMFModel {
  /// POI名称
  String? name;

  /// POI坐标
  BMFCoordinate? pt;

  /// POI地址信息
  String? address;

  /// POI电话号码
  String? phone;

  /// POI唯一标识符uid
  String? uid;

  /// POI所在省份
  String? province;

  /// POI所在城市
  String? city;

  /// POI所在行政区域
  String? area;

  /// POI对应的街景图ID
  String? streetID;

  /// POI类别  注：逆地理编码检索会返回此值，其他检索可能返回为空，请参考detailInfo中的tag值。
  String? tag;

  /// POI是否有详情信息
  bool? hasDetailInfo;

  /// POI详情信息
  BMFPOIDetailInfo? detailInfo;

  /// 和当前坐标点的方向，注：此字段只对逆地理检索有效
  String? direction;

  /// 距离坐标点距离，注：此字段只对逆地理检索有效
  int? distance;

  /// 邮编，注：此字段只对逆地理检索有效
  String? zipCode;

  /// 该POI对应的父POI，注：此字段只对逆地理检索有效
  BMFPoiInfo? parentPOI;

  /// BMFPoiInfo构造方法
  BMFPoiInfo({
    this.name,
    this.pt,
    this.address,
    this.phone,
    this.uid,
    this.province,
    this.city,
    this.area,
    this.streetID,
    this.tag,
    this.hasDetailInfo,
    this.detailInfo,
    this.direction,
    this.distance,
    this.zipCode,
    this.parentPOI,
  });

  /// map => BMFPoiInfo
  BMFPoiInfo.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFPoiInfo，The parameter map cannot be null !') {
    name = map['name'];
    pt = map['pt'] == null ? null : BMFCoordinate.fromMap(map['pt']);
    address = map['address'];
    phone = map['phone'];
    uid = map['uid'];
    province = map['province'];
    city = map['city'];
    area = map['area'];
    streetID = map['streetID'];
    tag = map['tag'];
    hasDetailInfo = map['hasDetailInfo'] as bool?;
    detailInfo = map['detailInfo'] == null
        ? null
        : BMFPOIDetailInfo.fromMap(map['detailInfo']);
    direction = map['direction'];
    distance = map['distance'];
    zipCode = map['zipCode'];
    parentPOI =
        map['parentPOI'] == null ? null : BMFPoiInfo.fromMap(map['parentPOI']);
  }
  @override
  fromMap(Map map) {
    return BMFPoiInfo.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'name': this.name,
      'pt': this.pt?.toMap(),
      'address': this.address,
      'phone': this.phone,
      'uid': this.uid,
      'province': this.province,
      'city': this.city,
      'area': this.area,
      'streetID': this.streetID,
      'tag': this.tag,
      'hasDetailInfo': this.hasDetailInfo,
      'detailInfo': this.detailInfo?.toMap(),
      'direction': this.direction,
      'distance': this.distance,
      'zipCode': this.zipCode,
      'parentPOI': this.parentPOI?.toMap()
    };
  }
}

/// POI详情信息类
class BMFPOIDetailInfo implements BMFModel {
  /// 距离中心点的距离，圆形区域检索时返回
  int? distance;

  /// POI类型："hotel","cater","life"等
  String? type;

  /// POI标签
  String? tag;

  /// POI对应的导航引导点坐标。大型面状POI的导航引导点，一般为各类出入口，方便结合导航、路线规划等服务使用
  BMFCoordinate? naviLocation;

  /// POI详情页URL
  String? detailURL;

  /// POI商户的价格
  double? price;

  /// POI营业时间
  String? openingHours;

  /// POI总体评分
  double? overallRating;

  /// POI口味评分
  double? tasteRating;

  /// POI服务评分
  double? serviceRating;

  /// POI环境评分
  double? environmentRating;

  /// POI星级（设备）评分
  double? facilityRating;

  /// POI卫生评分
  double? hygieneRating;

  /// POI技术评分
  double? technologyRating;

  /// POI图片数目
  int? imageNumber;

  /// POI团购数目
  int? grouponNumber;

  /// POI优惠数目
  int? discountNumber;

  /// POI评论数目
  int? commentNumber;

  /// POI收藏数目
  int? favoriteNumber;

  /// POI签到数目
  int? checkInNumber;

  /// POI详情子节点信息，默认不返回，需要权限。
  List<BMFPOIDetailChildrenInfo>? children;

  /// BMFPOIDetailInfo构造方法
  BMFPOIDetailInfo({
    this.imageNumber,
    this.grouponNumber,
    this.checkInNumber,
    this.overallRating,
    this.favoriteNumber,
    this.facilityRating,
    this.tasteRating,
    this.commentNumber,
    this.discountNumber,
    this.serviceRating,
    this.tag,
    this.children,
    this.type,
    this.hygieneRating,
    this.naviLocation,
    this.distance,
    this.environmentRating,
    this.technologyRating,
    this.detailURL,
    this.price,
    this.openingHours,
  });

  /// map => BMFPOIDetailInfo
  BMFPOIDetailInfo.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFPOIDetailInfo，The parameter map cannot be null !') {
    imageNumber = map['imageNumber'];
    grouponNumber = map['grouponNumber'];
    checkInNumber = map['checkInNumber'];
    overallRating = map['overallRating'];
    favoriteNumber = map['favoriteNumber'];
    facilityRating = map['facilityRating'];
    tasteRating = map['tasteRating'];
    commentNumber = map['commentNumber'];
    discountNumber = map['discountNumber'];
    serviceRating = map['serviceRating'];
    tag = map['tag'];
    if (map['children'] != null) {
      List<BMFPOIDetailChildrenInfo> tmpChildren = [];
      map['children'].forEach((v) {
        tmpChildren.add(BMFPOIDetailChildrenInfo.fromMap(v as Map));
      });
      children = tmpChildren;
    }
    type = map['type'];
    hygieneRating = map['hygieneRating'];
    naviLocation = map['naviLocation'] == null
        ? null
        : BMFCoordinate.fromMap(map['naviLocation']);
    distance = map['distance'];
    environmentRating = map['environmentRating'];
    technologyRating = map['technologyRating'];
    detailURL = map['detailURL'];
    price = map['price'];
    openingHours = map['openingHours'];
  }
  @override
  fromMap(Map map) {
    return BMFPOIDetailInfo.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'imageNumber': this.imageNumber,
      'grouponNumber': this.grouponNumber,
      'checkInNumber': this.checkInNumber,
      'overallRating': this.overallRating,
      'favoriteNumber': this.favoriteNumber,
      'facilityRating': this.facilityRating,
      'tasteRating': this.tasteRating,
      'commentNumber': this.commentNumber,
      'discountNumber': this.discountNumber,
      'serviceRating': this.serviceRating,
      'tag': this.tag,
      'children': this.children?.map((v) => v.toMap()).toList(),
      'type': this.type,
      'hygieneRating': this.hygieneRating,
      'naviLocation': this.naviLocation?.toMap(),
      'distance': this.distance,
      'environmentRating': this.environmentRating,
      'technologyRating': this.technologyRating,
      'detailURL': this.detailURL,
      'price': this.price,
      'openingHours': this.openingHours,
    };
  }
}

/// 室内POI信息类
class BMFPoiIndoorInfo implements BMFModel {
  /// POI名称
  String? name;

  /// POI唯一标识符
  String? uid;

  /// 该室内POI所在 室内ID
  String? indoorID;

  /// 该室内POI所在楼层
  String? floor;

  /// POI地址
  String? address;

  /// POI所在城市
  String? city;

  /// POI电话号码
  String? phone;

  /// POI坐标
  BMFCoordinate? pt;

  /// POI标签
  String? tag;

  /// 价格
  double? price;

  /// 星级（0-50），50表示五星
  int? starLevel;

  /// 是否有团购
  bool? grouponFlag;

  /// 是否有外卖
  bool? takeoutFlag;

  /// 是否排队
  bool? waitedFlag;

  /// 团购数,-1表示没有团购信息
  int? grouponNum;

  /// 折扣信息FIXME
  int? discount;

  BMFPoiIndoorInfo({
    this.name,
    this.uid,
    this.indoorID,
    this.floor,
    this.address,
    this.city,
    this.phone,
    this.pt,
    this.tag,
    this.price,
    this.starLevel,
    this.grouponFlag,
    this.takeoutFlag,
    this.waitedFlag,
    this.grouponNum,
    this.discount,
  });

  /// map => BMFPoiIndoorInfo
  BMFPoiIndoorInfo.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFPoiIndoorInfo，The parameter map cannot be null !') {
    name = map['name'];
    uid = map['uid'];
    indoorID = map['indoorID'];
    floor = map['floor'];
    address = map['address'];
    city = map['city'];
    phone = map['phone'];
    pt = map['pt'] == null ? null : BMFCoordinate.fromMap(map['pt']);
    tag = map['tag'];
    price = map['price'];
    starLevel = map['starLevel'];
    grouponFlag = map['grouponFlag'] as bool?;
    takeoutFlag = map['takeoutFlag'] as bool?;
    waitedFlag = map['waitedFlag'] as bool?;
    grouponNum = map['grouponNum'] as int?;
    discount = map['discount'] as int?;
  }

  @override
  fromMap(Map map) {
    return BMFPoiIndoorInfo.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'name': this.name,
      'uid': this.uid,
      'indoorID': this.indoorID,
      'floor': this.floor,
      'address': this.address,
      'city': this.city,
      'phone': this.phone,
      'pt': this.pt?.toMap(),
      'tag': this.tag,
      'price': this.price,
      'starLevel': this.starLevel,
      'grouponFlag': this.grouponFlag,
      'takeoutFlag': this.takeoutFlag,
      'waitedFlag': this.waitedFlag,
      'grouponNum': this.grouponNum,
      'discount': this.discount
    };
  }
}
