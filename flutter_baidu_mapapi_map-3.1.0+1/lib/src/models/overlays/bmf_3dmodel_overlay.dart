import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFModel, BMFCoordinate;

import 'bmf_overlay.dart';

/// 3d模型 since 3.1.0
class BMF3DModelOverlay extends BMFOverlay {
  /// 模型中心经纬度坐标
  late BMFCoordinate center;

  /// 3d模型option
  late BMF3DModelOption option;

  /// 3d模型构造方法
  BMF3DModelOverlay({
    required this.center,
    required this.option,
    int zIndex: 0,
    bool visible: true,
  }) : super(zIndex: zIndex, visible: visible);

  /// map => BMF3DModelOverlay
  BMF3DModelOverlay.fromMap(Map map)
      : assert(map['center'] != null),
        assert(map['option'] != null),
        super.fromMap(map) {
    center = BMFCoordinate.fromMap(map['center']);
    option = BMF3DModelOption.fromMap(map['option']);
  }

  @override
  fromMap(Map map) {
    return BMF3DModelOverlay.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'id': this.Id,
      'center': this.center.toMap(),
      'option': this.option.toMap(),
      'zIndex': this.zIndex,
      'visible': this.visible
    };
  }
}

/// 3d模型option
class BMF3DModelOption implements BMFModel {
  /// 模型文件路径
  late String modelPath;

  /// 模型名
  late String modelName;

  /// 缩放比例，默认1.0
  double? scale;

  /// scale不随地图缩放而变化，默认为NO
  bool? zoomFixed;

  /// 旋转角度，取值范围为[0.0f, 360.0f]，默认为0.0
  double? rotateX;

  double? rotateY;

  double? rotateZ;

  /// 偏移像素，默认为0.0
  double? offsetX;

  double? offsetY;

  double? offsetZ;

  /// 3D模型文件格式，默认BMF3DModelTypeObj
  BMF3DModelType? type;

  /// 3d模型option构造方法
  BMF3DModelOption(
      {required this.modelPath,
      required this.modelName,
      this.scale,
      this.zoomFixed,
      this.rotateX,
      this.rotateY,
      this.rotateZ,
      this.offsetX,
      this.offsetY,
      this.offsetZ,
      this.type});

  /// map =>> BMF3DModelOption
  BMF3DModelOption.fromMap(Map map)
      : assert(map['modelPath'] != null),
        assert(map['modelName'] != null) {
    modelPath = map['modelPath'];
    modelName = map['modelName'];
    scale = map['scale'] as double;
    zoomFixed = map['zoomFixed'] as bool;
    rotateX = map['rotateX'] as double;
    rotateY = map['rotateY'] as double;
    rotateZ = map['rotateZ'] as double;
    offsetX = map['offsetX'] as double;
    offsetY = map['offsetY'] as double;
    offsetZ = map['offsetZ'] as double;
    type = BMF3DModelType.values[map['type'] as int];
  }

  @override
  fromMap(Map map) {
    return BMF3DModelOption.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'modelPath': this.modelPath,
      'modelName': this.modelName,
      'scale': this.scale,
      'zoomFixed': this.zoomFixed,
      'rotateX': this.rotateX,
      'rotateY': this.rotateY,
      'rotateZ': this.rotateZ,
      'offsetX': this.offsetX,
      'offsetY': this.offsetY,
      'type': this.type?.index
    };
  }
}

/// 3D模型文件格式枚举
enum BMF3DModelType {
  /// .obj
  BMF3DModelTypeObj,

  /// .glTF
  BMF3DModelTypeGLTF,
}
