import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFBuildInfo, BMFModel;

/// 地图建筑物返回结果类
class BMFBuildingSearchResult implements BMFModel {
  /// 地图建筑物返回结果列表
  List<BMFBuildInfo>? buildingList;

  /// 有参构造
  BMFBuildingSearchResult({this.buildingList});

  /// map => BMFBuildingSearchResult
  BMFBuildingSearchResult.fromMap(Map map) {
    if (map['buildingList'] != null) {
      List<BMFBuildInfo> tmpBuildingList = [];
      map['buildingList'].forEach((v) {
        tmpBuildingList.add(BMFBuildInfo.fromMap(v as Map));
      });
      buildingList = tmpBuildingList;
    }
  }

  @override
  fromMap(Map map) {
    return BMFBuildingSearchResult.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {'buildingList': this.buildingList?.map((e) => e.toMap()).toList()};
  }
}
