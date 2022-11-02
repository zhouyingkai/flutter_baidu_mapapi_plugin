import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';

/// 检索过滤条件中的POI的行业类型
enum BMFPoiIndustryType {
  ///<宾馆
  HOTEL,

  ///<餐饮
  CATER,

  ///<生活娱乐
  LIFE,
}

/// 检索过滤条件中的排序依据类型
/// 类型整体分为宾馆行业、餐饮行业、生活娱乐行业3大类
enum BMFPoiSortBasisType {
  ///<宾馆行业，默认排序
  HOTEL_DEFAULT,

  ///<宾馆行业，按价格排序
  HOTEL_PRICE,

  ///<宾馆行业，按距离排序（只对周边检索有效）
  HOTEL_DISTANCE,

  ///<宾馆行业，按好评排序
  HOTEL_TOTAL_SCORE,

  ///<宾馆行业，按星级排序
  HOTEL_LEVEL,

  ///<宾馆行业，按卫生排序
  HOTEL_HEALTH_SCORE,

  ///<餐饮行业，默认排序
  CATER_DEFAULT,

  ///<餐饮行业，按价格排序
  CATER_PRICE,

  ///<餐饮行业，按距离排序（只对周边检索有效）
  CATER_DISTANCE,

  ///<餐饮行业，按口味排序
  CATER_TASTE_RATING,

  ///<餐饮行业，按好评排序
  CATER_OVERALL_RATING,

  ///<餐饮行业，按服务排序
  CATER_SERVICE_RATING,

  ///<生活娱乐行业，默认排序
  LIFE_DEFAULT,

  ///<生活娱乐行业，按价格排序
  LIFE_PRICE,

  ///<生活娱乐行业，按距离排序（只对周边检索有效）
  LIFE_DISTANCE,

  ///<生活娱乐行业，按好评排序
  LIFE_OVERALL_RATING,

  ///<生活娱乐行业，按服务排序
  LIFE_COMMENT_NUMBER,
}

/// POI检索排序规则
enum BMFPoiSortRuleType {
  ///<从高到底，降序排列
  DESCENDING,

  ///<从低到高，升序排列
  ASCENDING
}

/// POI检索结果详细程度
enum BMFPoiSearchScopeType {
  ///<基本信息
  BASIC_INFORMATION,

  ///<详细信息
  DETAIL_INFORMATION,
}

/// POI检索过滤条件类
class BMFPoiSearchFilter implements BMFModel {
  /// POI所属行业类型，设置该字段可提高检索速度和过滤经度
  BMFPoiIndustryType? industryType;

  /// 排序依据，根据industryType字段指定的行业类型不同，此字段应设置为对应行业的依据值
  ///
  /// 比如industryType字段的值为CATER，则此字段应选择CATER_XXX对应的枚举值
  BMFPoiSortBasisType? sortBasis;

  /// 排序规则
  BMFPoiSortRuleType? sortRule;

  /// 是否有团购
  bool? isGroupon;

  /// 是否有打折
  bool? isDiscount;

  /// 有参构造
  BMFPoiSearchFilter({
    this.industryType,
    this.sortBasis,
    this.sortRule,
    this.isGroupon,
    this.isDiscount,
  });

  /// map => BMFPoiSearchFilter
  BMFPoiSearchFilter.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFPoiSearchFilter，The parameter map cannot be null !') {
    industryType = BMFPoiIndustryType.values[map['industryType'] as int];
    sortBasis = BMFPoiSortBasisType.values[map['sortBasis'] as int];
    sortRule = BMFPoiSortRuleType.values[map['sortRule'] as int];
    isGroupon = map['isGroupon'] as bool?;
    isDiscount = map['isDiscount'] as bool?;
  }

  @override
  fromMap(Map map) {
    return BMFPoiSearchFilter.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'industryType': this.industryType?.index,
      'sortBasis': this.sortBasis?.index,
      'sortRule': this.sortRule?.index,
      'isGroupon': this.isGroupon,
      'isDiscount': this.isDiscount
    };
  }
}

/// POI城市检索
class BMFPoiCitySearchOption implements BMFModel {
  /// 检索关键字，必选。举例：天安门
  String? keyword;

  /// 检索分类，与keyword字段组合进行检索，多个分类以","分隔。举例：美食,酒店
  List<String>? tags;

  /// 区域名称(市或区的名字，如北京市，海淀区)或区域编码，必选
  String? city;

  /// 区域数据返回限制，可选，为true时，仅返回city对应区域内数据
  bool? isCityLimit;

  /// 检索结果详细程度 默认为BMFPoiSearchScopeType.BASIC_INFORMATION
  BMFPoiSearchScopeType? scope;

  /// 检索过滤条件。scope字段为BMFPoiSearchScopeType.DETAIL_INFORMATION时，filter字段才有效
  BMFPoiSearchFilter? filter;

  /// 分页页码，默认为0,0代表第一页，1代表第二页，以此类推
  int? pageIndex;

  /// 单次召回POI数量，默认为10条记录，最大返回20条。
  int? pageSize;

  /// 有参构造
  BMFPoiCitySearchOption({
    required this.keyword,
    this.tags,
    required this.city,
    this.isCityLimit: false,
    this.scope: BMFPoiSearchScopeType.BASIC_INFORMATION,
    this.filter,
    this.pageIndex: 0,
    this.pageSize: 10,
  });

  /// map => BMFPoiCitySearchOption
  BMFPoiCitySearchOption.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFPoiCitySearchOption，The parameter map cannot be null !') {
    keyword = map['keyword'];
    if (map['tags'] != null) {
      List<String> tmpTags = [];
      map['tags'].forEach((v) {
        tmpTags.add(v as String);
      });
      tags = tmpTags;
    }
    city = map['city'];
    isCityLimit = map['isCityLimit'] as bool?;
    scope = BMFPoiSearchScopeType.values[map['scope'] as int];
    filter = map['filter'] == null
        ? null
        : BMFPoiSearchFilter.fromMap(map['filter']);
    pageIndex = map['pageIndex'];
    pageSize = map['pageSize'];
  }

  @override
  fromMap(Map map) {
    return BMFPoiCitySearchOption.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'keyword': this.keyword,
      'tags': this.tags?.map((e) => e).toList(),
      'city': this.city,
      'isCityLimit': this.isCityLimit,
      'scope': this.scope?.index,
      'filter': this.filter?.toMap(),
      'pageIndex': this.pageIndex,
      'pageSize': this.pageSize
    };
  }
}

/// POI周边检索
class BMFPoiNearbySearchOption implements BMFModel {
  /// 检索关键字，必选。
  ///
  /// 在周边检索中关键字为数组类型，可以支持多个关键字并集检索，如银行和酒店。每个关键字对应数组一个元素。
  /// 最多支持10个关键字。
  List<String>? keywords;

  /// 检索分类，可选。
  ///
  /// 该字段与keywords字段组合进行检索。
  /// 支持多个分类，如美食和酒店。每个分类对应数组中一个元素
  List<String>? tags;

  /// 检索中心点的经纬度，必选
  BMFCoordinate? location;

  /// 检索半径，可选，单位是米。
  ///
  /// 当半径过大，超过中心点所在城市边界时，会变为城市范围检索，检索范围为中心点所在城市
  int? radius;

  /// 是否严格限定召回结果在设置检索半径范围内。默认值为false。
  ///
  /// 值为true代表检索结果严格限定在半径范围内；值为false时不严格限定。
  /// 注意：值为true时会影响返回结果中total准确性及每页召回poi数量，我们会逐步解决此类问题。
  bool? isRadiusLimit;

  /// 检索结果详细程度 默认为BMFPoiSearchScopeType.BASIC_INFORMATION
  BMFPoiSearchScopeType? scope;

  /// 检索过滤条件。scope字段为BMFPoiSearchScopeType.DETAIL_INFORMATION时，filter字段才有效
  BMFPoiSearchFilter? filter;

  /// 分页页码，默认为0,0代表第一页，1代表第二页，以此类推
  int? pageIndex;

  /// 单次召回POI数量，默认为10条记录，最大返回20条。
  int? pageSize;

  /// 有参构造
  BMFPoiNearbySearchOption({
    required this.keywords,
    this.tags,
    required this.location,
    this.radius,
    this.isRadiusLimit: false,
    this.scope: BMFPoiSearchScopeType.BASIC_INFORMATION,
    this.filter,
    this.pageIndex: 0,
    this.pageSize: 10,
  });

  /// map => BMFPoiNearbySearchOption
  BMFPoiNearbySearchOption.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFPoiNearbySearchOption，The parameter map cannot be null !') {
    if (map['keywords'] != null) {
      List<String> tmpKeywords = [];
      map['keywords'].forEach((v) {
        tmpKeywords.add(v as String);
      });
      keywords = tmpKeywords;
    }

    if (map['tags'] != null) {
      List<String> tmpTags = [];
      map['tags'].forEach((v) {
        tmpTags.add(v as String);
      });
      tags = tmpTags;
    }

    location =
        map['location'] == null ? null : BMFCoordinate.fromMap(map['location']);
    radius = map['radius'];
    isRadiusLimit = map['isRadiusLimit'];
    scope = BMFPoiSearchScopeType.values[map['scope'] as int];
    filter = map['filter'] == null
        ? null
        : BMFPoiSearchFilter.fromMap(map['filter']);
    pageIndex = map['pageIndex'];
    pageSize = map['pageSize'];
  }

  @override
  fromMap(Map map) {
    return BMFPoiNearbySearchOption.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'keywords': this.keywords?.map((e) => e).toList(),
      'tags': this.tags?.map((e) => e).toList(),
      'location': this.location?.toMap(),
      'radius': this.radius,
      'isRadiusLimit': this.isRadiusLimit,
      'scope': this.scope!.index,
      'filter': this.filter?.toMap(),
      'pageIndex': this.pageIndex,
      'pageSize': this.pageSize
    };
  }
}

/// POI矩形区域检索
class BMFPoiBoundSearchOption implements BMFModel {
  /// 检索关键字，必选。
  ///
  /// 在矩形检索中关键字为数组类型，可以支持多个关键字并集检索，如银行和酒店。每个关键字对应数组一个元素。
  /// 最多支持10个关键字。
  List<String>? keywords;

  /// 检索分类，可选。
  ///
  /// 该字段与keywords字段组合进行检索。
  /// 支持多个分类，如美食和酒店。每个分类对应数组中一个元素
  List<String>? tags;

  /// 矩形检索区域的左下角经纬度坐标，必选
  BMFCoordinate? leftBottom;

  /// 矩形检索区域的右上角经纬度坐标，必选
  BMFCoordinate? rightTop;

  /// 检索结果详细程度 默认为BMFPoiSearchScopeType.BASIC_INFORMATION
  BMFPoiSearchScopeType? scope;

  /// 检索过滤条件。scope字段为BMFPoiSearchScopeType.DETAIL_INFORMATION时，filter字段才有效
  BMFPoiSearchFilter? filter;

  /// 分页页码，默认为0,0代表第一页，1代表第二页，以此类推
  int? pageIndex;

  /// 单次召回POI数量，默认为10条记录，最大返回20条。
  int? pageSize;

  /// 有参构造
  BMFPoiBoundSearchOption({
    required this.keywords,
    this.tags,
    required this.leftBottom,
    required this.rightTop,
    this.scope: BMFPoiSearchScopeType.BASIC_INFORMATION,
    this.filter,
    this.pageIndex: 0,
    this.pageSize: 10,
  });

  /// map => BMFPoiBoundSearchOption
  BMFPoiBoundSearchOption.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFPoiNearbySearchOption，The parameter map cannot be null !') {
    if (map['keywords'] != null) {
      List<String> tmpKeywords = [];
      map['keywords'].forEach((v) {
        tmpKeywords.add(v as String);
      });
      keywords = tmpKeywords;
    }

    if (map['tags'] != null) {
      List<String> tmpTags = [];
      map['tags'].forEach((v) {
        tmpTags.add(v as String);
      });
      tags = tmpTags;
    }
    leftBottom = map['leftBottom'] == null
        ? null
        : BMFCoordinate.fromMap(map['leftBottom']);
    rightTop =
        map['rightTop'] == null ? null : BMFCoordinate.fromMap(map['rightTop']);
    scope = BMFPoiSearchScopeType.values[map['scope'] as int];
    filter = map['filter'] == null
        ? null
        : BMFPoiSearchFilter.fromMap(map['filter']);
    pageIndex = map['pageIndex'];
    pageSize = map['pageSize'];
  }

  @override
  fromMap(Map map) {
    return BMFPoiBoundSearchOption.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'keywords': this.keywords?.map((e) => e).toList(),
      'tags': this.tags?.map((e) => e).toList(),
      'leftBottom': this.leftBottom?.toMap(),
      'rightTop': this.rightTop?.toMap(),
      'scope': this.scope!.index,
      'filter': this.filter?.toMap(),
      'pageIndex': this.pageIndex,
      'pageSize': this.pageSize
    };
  }
}

/// POI详情检索信息类
class BMFPoiDetailSearchOption implements BMFModel {
  /// POI的唯一标识符集合，必选 注：从POI检索的返回结果BMFPoiInfo里获取。
  List<String>? poiUIDs;

  /// 检索结果详细程度 默认为BMFPoiSearchScopeType.BASIC_INFORMATION
  BMFPoiSearchScopeType? scope;

  /// 有参构造
  BMFPoiDetailSearchOption({
    required this.poiUIDs,
    this.scope: BMFPoiSearchScopeType.BASIC_INFORMATION,
  });

  /// map => BMFPoiDetailSearchOption
  BMFPoiDetailSearchOption.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFPoiDetailSearchOption，The parameter map cannot be null !') {
    if (map['poiUIDs'] != null) {
      List<String> tmpPoiUIDs = [];
      map['poiUIDs'].forEach((v) {
        tmpPoiUIDs.add(v as String);
      });
      poiUIDs = tmpPoiUIDs;
    }
    scope = BMFPoiSearchScopeType.values[map['scope'] as int];
  }

  @override
  fromMap(Map map) {
    return BMFPoiDetailSearchOption.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'poiUIDs': this.poiUIDs?.map((e) => e).toList(),
      'scope': this.scope!.index,
    };
  }
}

/// 室内POI检索
class BMFPoiIndoorSearchOption implements BMFModel {
  /// 室内检索唯一标识符，必选 注：从进入/移出室内图的回调方法中获取。
  String? indoorID;

  /// 室内检索关键字，必选
  String? keyword;

  /// 楼层（可选），设置后，会优先获取该楼层的室内POI，然后是其它楼层的。如“F3”,"B3"等。
  String? floor;

  /// 分页页码，默认为0,0代表第一页，1代表第二页，以此类推
  int? pageIndex;

  /// 单次召回POI数量，默认为10条记录，最大返回20条。
  int? pageSize;

  /// 有参构造
  BMFPoiIndoorSearchOption({
    required this.indoorID,
    required this.keyword,
    this.floor,
    this.pageIndex: 0,
    this.pageSize: 10,
  });

  /// map => BMFPoiIndoorSearchOption
  BMFPoiIndoorSearchOption.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFPoiIndoorSearchOption，The parameter map cannot be null !') {
    indoorID = map['indoorID'];
    keyword = map['keyword'];
    floor = map['floor'];
    pageIndex = map['pageIndex'];
    pageSize = map['pageSize'];
  }
  @override
  fromMap(Map map) {
    return BMFPoiIndoorSearchOption.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'indoorID': this.indoorID,
      'keyword': this.keyword,
      'floor': this.floor,
      'pageInde': this.pageIndex,
      'pageSize': this.pageSize
    };
  }
}
