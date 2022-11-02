/// 关于以下4个字段的解释：
/// 假如检索请求中 pageSize=10 且 pageIndex=2，即开发者期望检索结果每页10条，取第2页的结果。
/// 如果符合条件的检索结果总数为25条，检索结果总页数就是3，当前页结果个数为5，当前页的索引为3；
/// 如果符合条件的检索结果总数为8条，此时没有符合条件的检索结果。本对象为nil
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFModel;
import 'package:flutter_baidu_mapapi_search/src/common/bmf_poisearch_type.dart'
    show BMFPoiIndoorInfo, BMFPoiInfo;

/// POI检索结果类，城市检索、周边检索、矩形区域检索服务都使用此结果类。
class BMFPoiSearchResult implements BMFModel {
  /// 符合条件的检索结果总个数
  int? totalPageNum;

  /// 符合条件的检索结果总页数
  int? curPageIndex;

  /// 当前页的结果个数
  int? totalPOINum;

  /// 当前页的页数索引
  int? curPOINum;

  /// POI列表，成员是BMFPoiInfo
  List<BMFPoiInfo>? poiInfoList;

  /// BMFPoiSearchResult构造方法
  BMFPoiSearchResult({
    this.totalPageNum,
    this.curPageIndex,
    this.totalPOINum,
    this.curPOINum,
    this.poiInfoList,
  });

  /// map => BMFPoiSearchResult
  BMFPoiSearchResult.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFPoiSearchResult，The parameter map cannot be null !') {
    totalPageNum = map['totalPageNum'];
    curPageIndex = map['curPageIndex'];
    totalPOINum = map['totalPOINum'];
    curPOINum = map['curPOINum'];
    if (map['poiInfoList'] != null) {
      List<BMFPoiInfo> tmpPoiInfoList = [];
      map['poiInfoList'].forEach((v) {
        tmpPoiInfoList.add(BMFPoiInfo.fromMap(v as Map));
      });
      poiInfoList = tmpPoiInfoList;
    }
  }

  @override
  fromMap(Map map) {
    return BMFPoiSearchResult.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'totalPageNum': this.totalPageNum,
      'curPageIndex': this.curPageIndex,
      'totalPOINum': this.totalPOINum,
      'curPOINum': this.curPOINum,
      'poiInfoList': this.poiInfoList?.map((v) => v.toMap()).toList()
    };
  }
}

/// POI详情检索结果类
class BMFPoiDetailSearchResult implements BMFModel {
  /// 符合条件的检索结果总个数
  int? totalPOINum;

  /// POI列表，成员是BMFPoiInfo
  List<BMFPoiInfo>? poiInfoList;

  /// 有参构造
  BMFPoiDetailSearchResult({this.totalPOINum, this.poiInfoList});

  /// map => BMFPoiDetailSearchResult
  BMFPoiDetailSearchResult.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFPoiDetailSearchResult，The parameter map cannot be null !') {
    totalPOINum = map['totalPOINum'];
    if (map['poiInfoList'] != null) {
      List<BMFPoiInfo> tmpPoiInfoList = [];
      map['poiInfoList'].forEach((v) {
        tmpPoiInfoList.add(BMFPoiInfo.fromMap(v as Map));
      });
      poiInfoList = tmpPoiInfoList;
    }
  }

  @override
  fromMap(Map map) {
    return BMFPoiDetailSearchResult.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'totalPOINum': this.totalPOINum,
      'poiInfoList': this.poiInfoList?.map((e) => e.toMap()).toList()
    };
  }
}

/// POI室内搜索结果类
class BMFPoiIndoorSearchResult implements BMFModel {
  /// 符合条件的检索结果总个数
  int? totalPOINum;

  /// 符合条件的检索结果总页数
  int? totalPageNum;

  /// 当前页的结果个数
  int? curPOINum;

  /// 当前页的页数索引
  int? curPageIndex;

  /// 室内POI列表，成员是BMFPoiIndoorInfo
  List<BMFPoiIndoorInfo>? poiIndoorInfoList;

  ///有参构造
  BMFPoiIndoorSearchResult({
    this.totalPOINum,
    this.totalPageNum,
    this.curPOINum,
    this.curPageIndex,
    this.poiIndoorInfoList,
  });

  /// map => BMFPoiIndoorSearchResult
  BMFPoiIndoorSearchResult.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFPoiIndoorSearchResult，The parameter map cannot be null !') {
    totalPOINum = map['totalPOINum'];
    totalPageNum = map['totalPageNum'];
    curPOINum = map['curPOINum'];
    curPageIndex = map['curPageIndex'];
    if (map['poiIndoorInfoList'] != null) {
      List<BMFPoiIndoorInfo> tmpPoiIndoorInfoList = [];
      map['poiIndoorInfoList'].forEach((v) {
        tmpPoiIndoorInfoList.add(BMFPoiIndoorInfo.fromMap(v as Map));
      });
      poiIndoorInfoList = tmpPoiIndoorInfoList;
    }
  }

  @override
  fromMap(Map map) {
    return BMFPoiIndoorSearchResult.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'totalPOINum': this.totalPOINum,
      'totalPageNum': this.totalPageNum,
      'curPOINum': this.curPOINum,
      'curPageIndex': this.curPageIndex,
      'poiIndoorInfoList':
          this.poiIndoorInfoList?.map((e) => e.toMap()).toList()
    };
  }
}
