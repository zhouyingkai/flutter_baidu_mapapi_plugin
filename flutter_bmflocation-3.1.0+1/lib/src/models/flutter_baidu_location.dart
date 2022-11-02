class BaiduPoiList {
  //poi标签
  String? tags;
  //uid（仅iOS返回）
  String? uid;
  //poi名称
  String? name;
  //poi地址
  String? addr;

  BaiduPoiList({this.tags, this.uid, this.name, this.addr});

  BaiduPoiList.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BaiduPoiList，The parameter map cannot be null !') {
    tags = map['tags'];
    uid = map['uid'];
    name = map['name'];
    addr = map['addr'];
  }

  Map<String, Object?> toMap() {
    return {
      'tags': tags,
      'uid': uid,
      'name': name,
      'addr': addr,
    };
  }
}

/// 百度定位结果类，用于存储各类定位结果信息
class BaiduLocation {
  ///定位id（仅iOS端会返回）
  String? locationID;

  /// 定位成功时间
  String? locTime;

  /// 定位结果类型(仅Android端返回)
  int? locType;

  /// 航向
  double? course;

  /// 水平精度（仅iOS端返回）
  double? horizontalAccuracy;

  /// 垂直精度（仅iOS端返回）
  double? verticalAccuracy;

  /// 定位精度（仅Android端返回）
  double? radius;

  /// 速度
  double? speed;

  /// 纬度
  double? latitude;

  /// 经度
  double? longitude;

  /// 高度
  double? altitude;

  /// 国家
  String? country;

  /// 省份
  String? province;

  /// 城市
  String? city;

  /// 区县
  String? district;

  //乡镇
  String? street;

  /// 街道
  String? town;

  /// 地址
  String? address;

  /// 行政区划编码
  String? adCode;

  /// 城市编码
  String? cityCode;

  /// 街道号码
  String? streetNumber;

  /// 位置语义化描述，例如"在百度大厦附近"
  String? locationDetail;

  /// 模拟定位概率
  BMFMockLocationProbability? probability;

  /// 周边poi信息
  List<BaiduPoiList>? pois;

  /// 周边poi信息，每个poi之间用"|"隔开
  @Deprecated('已废弃since3.0.0，推荐使用 `pois`')
  String? poiList;

  Map? poiRegion;

  /// 定位结果回调时间
  String? callbackTime;

  /// 错误码
  int? errorCode;

  /// 定位失败描述信息
  String? errorInfo;

  BaiduLocation(
      {this.town,
      this.course,
      this.speed,
      this.locationID,
      this.locTime,
      this.locType,
      this.radius,
      this.latitude,
      this.longitude,
      this.altitude,
      this.country,
      this.adCode,
      this.cityCode,
      this.streetNumber,
      this.province,
      this.city,
      this.horizontalAccuracy,
      this.verticalAccuracy,
      this.district,
      this.street,
      this.address,
      this.locationDetail,
      this.probability,
      this.poiList,
      this.pois,
      this.poiRegion,
      this.callbackTime,
      this.errorCode,
      this.errorInfo});

  /// 根据传入的map生成BaiduLocation对象
  BaiduLocation.fromMap(Map map) {
    town = map['town'];
    course = map['course'];
    locationID = map['locationID'];
    locTime = map['locTime'];
    locType = map['locType'];
    speed = map['speed'];
    radius = map['radius'];
    horizontalAccuracy = map['horizontalAccuracy'];
    verticalAccuracy = map['verticalAccuracy'];
    latitude = map['latitude'];
    longitude = map['longitude'];
    altitude = map['altitude'];
    country = map['country'];
    province = map['province'];
    city = map['city'];
    adCode = map["adCode"];
    cityCode = map["cityCode"];
    streetNumber = map["streetNumber"];
    district = map['district'];
    street = map['street'];
    address = map['address'];
    locationDetail = map['locationDetail'];
    poiList = map['poiList'];
    if (map['pois'] != null) {
      List<BaiduPoiList> tmpPoiInfoList = [];
      map['pois'].forEach((v) {
        tmpPoiInfoList.add(BaiduPoiList.fromMap(v as Map));
      });

      pois = List.from(tmpPoiInfoList);
    }
    if (map['probability'] != null) {
      probability = BMFMockLocationProbability
          .values[(map['probability'] < 0) ? 0 : map['probability'] as int];
    }
    if (map['poiRegion'] != null) {
      poiRegion = Map.from(map['poiRegion']);
    }
    callbackTime = map['callbackTime'];
    errorCode = map['errorCode'];
    errorInfo = map['errorInfo'];
  }

  /// 获取对本类所有变量赋值后的map键值对
  Map getMap() {
    return {
      'town': town,
      'course': course,
      'speed': speed,
      'locationID': locationID,
      "locTime": locTime,
      "locType": locType,
      "radius": radius,
      "latitude": latitude,
      "longitude": longitude,
      "altitude": altitude,
      "country": country,
      "province": province,
      "city": city,
      "district": district,
      "street": street,
      "adCode": adCode,
      "cityCode": cityCode,
      "streetNumber": streetNumber,
      "address": address,
      "verticalAccuracy": verticalAccuracy,
      "horizontalAccuracy": horizontalAccuracy,
      "locationDetail": locationDetail,
      "poiList": poiList,
      "pois": pois?.map((v) => v.toMap()).toList(),
      "poiRegion": poiRegion,
      "callbackTime": callbackTime,
      "probability": probability?.index,
      "errorCode": errorCode,
      "errorInfo": errorInfo,
    };
  }
}

// 模拟定位概率
enum BMFMockLocationProbability { none, low, mid, high }
