import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFModel, BMFCoordinate;
import 'package:flutter_baidu_mapapi_search/src/common/bmf_poisearch_type.dart';
import 'package:flutter_baidu_mapapi_search/src/common/bmf_routesearch_type.dart';

/// 地址编码结果类
class BMFGeoCodeSearchResult implements BMFModel {
  /// 地址对应的经纬度坐标
  BMFCoordinate? location;

  /// 是否是精准查找，1为精确查找，即准确打点，0为不精确，即模糊打点
  int? precise;

  /// 可信度，值范围0-100，数值越大，可信度越高，误差范围越小
  ///
  /// 大于80误差小于100m，该字段仅作参考，返回结果准确度主要参考precise参数
  int? confidence;

  /// 地址类型，包含：UNKNOWN、国家、省、商圈、生活服务等等
  String? level;

  /// 有参构造
  BMFGeoCodeSearchResult({
    this.location,
    this.precise,
    this.confidence,
    this.level,
  });

  /// map => BMFGeoCodeSearchResult
  BMFGeoCodeSearchResult.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFGeoCodeSearchResult，The parameter map cannot be null !') {
    location =
        map['location'] == null ? null : BMFCoordinate.fromMap(map['location']);
    precise = map['precise'];
    confidence = map['confidence'];
    level = map['level'];
  }

  @override
  fromMap(Map map) {
    return BMFGeoCodeSearchResult.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'location': this.location?.toMap(),
      'precise': this.precise,
      'confidence': this.confidence,
      'level': this.level
    };
  }
}

/// 反地理编码结果类
class BMFReverseGeoCodeSearchResult implements BMFModel {
  /// 地址坐标
  BMFCoordinate? location;

  /// 地址名称
  String? address;

  /// 商圈名称
  String? businessCircle;

  /// 层次化地址信息
  BMFAddressComponent? addressDetail;

  /// 可信度，值范围0-100，数值越大，可信度越高，误差范围越小
  /// 大于80误差小于100m，该字段仅作参考，返回结果准确度主要参考precise参数
  int? confidence;

  /// 地址周边POI信息，成员类型为BMKPoiInfo
  List<BMFPoiInfo>? poiList;

  /// 地址所属区域面信息
  List<BMFSearchRGCRegionInfo>? poiRegions;

  /// 结合当前位置POI的语义化结果描述
  String? sematicDescription;

  /// 有参构造
  BMFReverseGeoCodeSearchResult({
    this.location,
    this.address,
    this.businessCircle,
    this.addressDetail,
    this.confidence,
    this.poiList,
    this.poiRegions,
    this.sematicDescription,
  });

  /// map => BMFReverseGeoCodeSearchResult
  BMFReverseGeoCodeSearchResult.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFReverseGeoCodeSearchResult，The parameter map cannot be null !') {
    location =
        map['location'] == null ? null : BMFCoordinate.fromMap(map['location']);
    address = map['address'];
    businessCircle = map['businessCircle'];
    addressDetail = map['addressDetail'] == null
        ? null
        : BMFAddressComponent.fromMap(map['addressDetail']);
    confidence = map['confidence'];
    if (map['poiList'] != null) {
      List<BMFPoiInfo> tmpPoiList = [];
      map['poiList'].forEach((v) {
        tmpPoiList.add(BMFPoiInfo.fromMap(v as Map));
      });
      poiList = tmpPoiList;
    }

    if (map['poiRegions'] != null) {
      List<BMFSearchRGCRegionInfo> tmpPoiRegions = [];
      map['poiRegions'].forEach((v) {
        tmpPoiRegions.add(BMFSearchRGCRegionInfo.fromMap(v as Map));
      });
      poiRegions = tmpPoiRegions;
    }
    sematicDescription = map['sematicDescription'];
  }

  @override
  fromMap(Map map) {
    return BMFReverseGeoCodeSearchResult.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'location': this.location?.toMap(),
      'address': this.address,
      'businessCircle': this.businessCircle,
      'addressDetail': this.addressDetail?.toMap(),
      'confidence': this.confidence,
      'poiList': this.poiList?.map((p) => p.toMap()).toList(),
      'poiRegions': this.poiRegions?.map((p) => p.toMap()).toList(),
      'sematicDescription': this.sematicDescription
    };
  }
}

/// RGC检索结果归属区域面信息类
class BMFSearchRGCRegionInfo implements BMFModel {
  /// 请求坐标与所归属区域面的相对位置关系
  String? regionDescription;

  /// 归属区域面名称
  String? regionName;

  /// 归属区域面类型
  String? regionTag;

  /// 归属区域面唯一标识
  String? regionUID;

  /// 有参构造
  BMFSearchRGCRegionInfo({
    this.regionDescription,
    this.regionName,
    this.regionTag,
    this.regionUID,
  });

  /// map => BMFSearchRGCRegionInfo
  BMFSearchRGCRegionInfo.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFSearchRGCRegionInfo，The parameter map cannot be null !') {
    regionDescription = map['regionDescription'];
    regionName = map['regionName'];
    regionTag = map['regionTag'];
    regionUID = map['regionUID'];
  }

  @override
  fromMap(Map map) {
    return BMFSearchRGCRegionInfo.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'regionDescription': this.regionDescription,
      'regionName': this.regionName,
      'regionTag': this.regionTag,
      'regionUID': this.regionUID
    };
  }
}
