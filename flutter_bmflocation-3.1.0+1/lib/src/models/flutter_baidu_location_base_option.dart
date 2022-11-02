abstract class BMFLocationBaseOption {
  BMFLocationCoordType? coordType;

  BMFLocationBaseOption({required this.coordType});
}

/// 枚举：坐标类型
enum BMFLocationCoordType {
  ///<国测局坐标
  gcj02,

  ///<WGS84
  wgs84,

  ///<百度经纬度坐标
  bd09ll,
}
