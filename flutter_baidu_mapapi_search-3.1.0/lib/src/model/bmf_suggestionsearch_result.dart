import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFModel, BMFCoordinate;

/// Sug检索子节点结果类
class BMFSuggestionChildrenInfo implements BMFModel {
  /// poi子点uid
  String? uid;

  /// poi子点名称
  String? name;

  /// poi子点简称
  String? showName;

  /// 有参构造
  BMFSuggestionChildrenInfo({this.uid, this.name, this.showName});

  /// map => BMFSuggestionChildrenInfo
  BMFSuggestionChildrenInfo.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFSuggestionChildrenInfo，The parameter map cannot be null !') {
    uid = map['uid'];
    name = map['name'];
    showName = map['showName'];
  }
  @override
  fromMap(Map map) {
    return BMFSuggestionChildrenInfo.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {'uid': this.uid, 'name': this.name, 'showName': this.showName};
  }
}

/// Sug检索结果类
class BMFSuggestionInfo implements BMFModel {
  /// 联想词联想词名称
  String? key;

  /// 联想结果经纬度坐标
  BMFCoordinate? location;

  /// 联想结果唯一标示，ID
  String? uid;

  /// 联想结果所在城市
  String? city;

  /// 联想结果所在区县
  String? district;

  /// 联想结果分类。
  String? tag;

  /// 联想结果地址。
  String? address;

  /// 联想结果子节点。
  List<BMFSuggestionChildrenInfo>? children;

  /// 有参构造
  BMFSuggestionInfo({
    this.key,
    this.location,
    this.uid,
    this.city,
    this.district,
    this.tag,
    this.address,
    this.children,
  });

  /// map => BMFSuggestionInfo
  BMFSuggestionInfo.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFSuggestionInfo，The parameter map cannot be null !') {
    key = map['key'];
    location =
        map['location'] == null ? null : BMFCoordinate.fromMap(map['location']);
    uid = map['uid'];
    city = map['city'];
    district = map['district'];
    tag = map['tag'];
    address = map['address'];
    if (map['children'] != null) {
      List<BMFSuggestionChildrenInfo> tmpChildren = [];
      map['children'].forEach((v) {
        tmpChildren.add(BMFSuggestionChildrenInfo.fromMap(v as Map));
      });
      children = tmpChildren;
    }
  }

  @override
  fromMap(Map map) {
    return BMFSuggestionInfo.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'key': this.key,
      'location': this.location?.toMap(),
      'uid': this.uid,
      'city': this.city,
      'district': this.district,
      'tag': this.tag,
      'address': this.address,
      'children': this.children?.map((c) => c.toMap()).toList()
    };
  }
}

/// Sug检索结果列表
class BMFSuggestionSearchResult implements BMFModel {
  /// Sug检索结果列表
  List<BMFSuggestionInfo>? suggestionList;

  /// 有参构造
  BMFSuggestionSearchResult({this.suggestionList});

  /// map => BMFSuggestionSearchResult
  BMFSuggestionSearchResult.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFSuggestionSearchResult，The parameter map cannot be null !') {
    if (map['suggestionList'] != null) {
      List<BMFSuggestionInfo> tmpSuggestionList = [];
      map['suggestionList'].forEach((v) {
        tmpSuggestionList.add(BMFSuggestionInfo.fromMap(v as Map));
      });
      suggestionList = tmpSuggestionList;
    }
  }
  @override
  fromMap(Map map) {
    return BMFSuggestionSearchResult.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'suggestionList': this.suggestionList?.map((s) => s.toMap()).toList()
    };
  }
}
