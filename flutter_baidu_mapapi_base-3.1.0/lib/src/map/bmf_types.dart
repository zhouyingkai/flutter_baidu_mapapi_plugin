/// 枚举：坐标类型
enum BMF_COORD_TYPE {
  ///<GPS设备采集的原始GPS坐标（WGS-84）, 目前不支持设置该坐标类型为全局坐标类型
  GPS,

  ///<GCJ坐标，google地图、soso地图、aliyun地图、mapabc地图和amap地图所用坐标
  COMMON,

  ///<百度经纬度坐标
  BD09LL,
}

/// 枚举：地图类型 底图展示的地图类型
enum BMFMapType {
  /// 空白地图
  None,

  /// 标准地图
  Standard,

  /// 卫星地图
  ///
  /// 在某些Android机型上，卫星图无法正常展示
  Satellite,
}

/// 枚举：logo位置
enum BMFLogoPosition {
  ///<地图左下方
  LeftBottom,

  ///<地图左上方
  LeftTop,

  ///<地图中下方
  CenterBottom,

  ///<地图中上方
  CenterTop,

  ///<地图右下方
  RightBottom,

  ///<地图右上方
  RightTop,
}

/// 枚举：定位模式
enum BMFUserTrackingMode {
  ///<普通定位模式
  None,

  ///<定位方向模式
  Heading,

  ///<定位跟随模式
  Follow,

  ///<定位罗盘模式
  FollowWithHeading,
}

/// 枚举：室内图切换楼层结果
enum BMFSwitchIndoorFloorError {
  ///<切换楼层成功
  Success,

  ///<切换楼层失败
  Failed,

  ///<地图还未聚焦到传入的室内图
  NotFocused,

  ///<当前室内图不存在该楼层
  NotExist,

  ///<切换楼层, 室内ID信息错误 Android独有
  SwichFloorInfoError,
}

/// 枚举：地图区域改变原因
enum BMFRegionChangeReason {
  ///<手势触发导致地图区域变化，如双击、拖拽、滑动地图
  Gesture,

  ///<地图上控件事件，如点击指南针返回2D地图。
  Event,

  ///<开发者调用接口、设置地图参数等导致地图区域变化
  APIs,
}

/// native view类型,android独有
class BMFNativeViewType {
  /// 对应native端的MapView
  static const sMapView = 'flutter_bmfmap/map/BMKMapView';

  /// 对应native端的TextureMapView
  static const sTextureMapView = 'flutter_bmfmap/map/BMKTextureMapView';
}
