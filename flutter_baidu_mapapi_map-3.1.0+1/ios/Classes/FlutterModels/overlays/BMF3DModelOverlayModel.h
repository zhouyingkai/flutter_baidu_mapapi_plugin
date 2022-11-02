//
//  BMF3DModelOverlayModel.h
//  flutter_baidu_mapapi_map
//
//  Created by zhangbaojin on 2021/12/29.
//

#import <flutter_baidu_mapapi_base/BMFModel.h>

@class BMFCoordinate;
@class BMF3DModelOption;
@class BMK3DModelOption;

NS_ASSUME_NONNULL_BEGIN

@interface BMF3DModelOverlayModel : BMFModel

/// flutter层3DModelOverlay的唯一id(用于区别哪个3DModelOverlay)
@property (nonatomic, copy) NSString *Id;

/// 中心点坐标
@property (nonatomic, strong) BMFCoordinate *center;

/// 模型options
@property (nonatomic, strong) BMF3DModelOption *option;

@end

@interface BMF3DModelOption : BMFModel

/// 缩放比例，默认1.0
@property (nonatomic, assign) float scale;

/// scale不随地图缩放而变化，默认为NO
@property (nonatomic, assign) BOOL zoomFixed;

/// 旋转角度，取值范围为[0.0f, 360.0f]，默认为0.0
@property (nonatomic, assign) float rotateX;

@property (nonatomic, assign) float rotateY;

@property (nonatomic, assign) float rotateZ;
/// 偏移像素，默认为0.0
@property (nonatomic, assign) float offsetX;

@property (nonatomic, assign) float offsetY;

@property (nonatomic, assign) float offsetZ;

/// 3D模型文件格式，默认BMK3DModelTypeObj
@property (nonatomic, assign) int type;

/// 模型文件路径
@property (nonatomic, copy) NSString *modelPath;

/// 模型名
@property (nonatomic, copy) NSString *modelName;

- (nullable BMK3DModelOption *)toBMK3DModelOption;

@end

NS_ASSUME_NONNULL_END
