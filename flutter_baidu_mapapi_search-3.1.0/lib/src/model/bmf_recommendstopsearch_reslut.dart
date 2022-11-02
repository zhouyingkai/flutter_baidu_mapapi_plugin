import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFModel, BMFCoordinate;

/// 推荐上车点返回结果类
class BMFRecommendStopSearchResult implements BMFModel {
  /// 推荐上车点返回结果列表
  List<BMFRecommendStopInfo>? recommendStopInfoList;

  /// 有参构造
  BMFRecommendStopSearchResult({this.recommendStopInfoList});

  /// map => BMFRecommendStopSearchResult
  BMFRecommendStopSearchResult.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFRecommendStopSearchResult，The parameter map cannot be null !') {
    if (map['recommendStopInfoList'] != null) {
      List<BMFRecommendStopInfo> tmpRecommendStopInfoList = [];
      map['recommendStopInfoList'].forEach((v) {
        tmpRecommendStopInfoList.add(BMFRecommendStopInfo.fromMap(v as Map));
      });
      recommendStopInfoList = tmpRecommendStopInfoList;
    }
  }

  @override
  fromMap(Map map) {
    return BMFRecommendStopSearchResult.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'recommendStopInfoList':
          this.recommendStopInfoList?.map((e) => e.toMap()).toList()
    };
  }
}

/// 推荐上车点信息类
class BMFRecommendStopInfo implements BMFModel {
  /// 推荐上车点名称
  String? name;

  /// 推荐上车点地址
  String? address;

  /// 推荐上车点经纬度
  BMFCoordinate? location;

  /// 推荐点poi的uid
  String? uid;

  /// 距查找点的距离，单位米
  double? distance;

  /// 有参构造
  BMFRecommendStopInfo(
      {this.name, this.address, this.location, this.uid, this.distance});

  /// map => BMFRecommendStopInfo
  BMFRecommendStopInfo.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFRecommendStopInfo，The parameter map cannot be null !') {
    name = map['name'];
    address = map['address'];
    location =
        map['location'] == null ? null : BMFCoordinate.fromMap(map['location']);
    uid = map['uid'];
    distance = map['distance'];
  }

  @override
  fromMap(Map map) {
    return BMFRecommendStopInfo.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'name': this.name,
      'address': this.address,
      'location': this.location?.toMap(),
      'uid': this.uid,
      'distance': this.distance
    };
  }
}
