// 设备朝向类，用于存储设备朝向结果信息
class BaiduHeading {
  /// 表示角度方向，其中0度为真北。参考方向
  ///
  /// 不考虑设备的方向以及设备的方向
  ///
  /// 范围: 0.0 - 359.9度，0为正北
  double? trueHeading;

  /// 航向精度
  ///
  /// 表示磁头可能与实际地磁头偏差的最大度数。负值表示无效的标题。
  double? headingAccuracy;

  /// 磁头（仅iOS返回）
  ///
  /// 表示度方向，其中0度为磁北。无论设备的方向以及用户界面的方向如何，方向都是从设备的顶部引用的。
  ///
  /// 范围: 0.0 - 359.9度，0度为地磁北极
  double? magneticHeading;

  /// x轴测量的地磁的原始值
  /// 仅iOS返回
  double? x;

  /// y轴测量的地磁的原始值
  /// 仅iOS返回
  double? y;

  /// z轴测量的地磁的原始值
  /// 仅iOS返回
  double? z;

  /// 时间戳
  String? timestamp;

  BaiduHeading({
    this.magneticHeading,
    this.trueHeading,
    this.headingAccuracy,
    this.x,
    this.y,
    this.z,
    this.timestamp,
  });

  BaiduHeading.fromMap(Map map) {
    magneticHeading = map['magneticHeading'];
    trueHeading = map['trueHeading'];
    headingAccuracy = map['headingAccuracy'];
    x = map['x'];
    y = map['y'];
    z = map['z'];
    timestamp = map['timestamp'];
  }

  Map getMap() {
    return {
      'magneticHeading': magneticHeading,
      'trueHeading': trueHeading,
      'headingAccuracy': headingAccuracy,
      'x': x,
      'y': y,
      'z': z,
      'timestamp': timestamp,
    };
  }
}
