import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFModel;

/// 分享URL结果类
class BMFShareURLResult implements BMFModel {
  /// 返回结果url
  String? url;

  /// 构造方法
  BMFShareURLResult({this.url});

  /// map => BMFShareURLResult
  BMFShareURLResult.fromMap(Map map)
      : assert(
            map != null, // ignore: unnecessary_null_comparison
            'Construct a BMFShareURLResult，The parameter map cannot be null !') {
    url = map['url'];
  }
  @override
  fromMap(Map map) {
    return BMFShareURLResult.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {'url': this.url};
  }
}
