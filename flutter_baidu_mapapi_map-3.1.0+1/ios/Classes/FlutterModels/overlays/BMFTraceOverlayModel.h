//
//  BMFTraceOverlayModel.h
//  flutter_baidu_mapapi_map
//
//  Created by zhangbaojin on 2021/12/29.
//

#import <flutter_baidu_mapapi_base/BMFModel.h>

@class BMFCoordinate;
@class BMFTraceOverlayOption;
@class BMKTraceOverlayOption;

NS_ASSUME_NONNULL_BEGIN

@interface BMFTraceOverlayModel : BMFModel

/// flutter层traceOverlay的唯一id(用于区别哪个traceOverlay)
@property (nonatomic, copy) NSString *Id;

/// 经纬度数组
@property (nonatomic, copy) NSArray<BMFCoordinate *> *coordinates;

/// traceOverlay动画参数
@property (nonatomic, strong) BMFTraceOverlayOption *traceOverlayAnimateOption;

/// 线宽
@property (nonatomic, assign) int width;

/// 画笔颜色
@property (nonatomic, copy) NSString *strokeColor;

/// 填充颜色
@property (nonatomic, copy) NSString *fillColor;

@end

@interface BMFTraceOverlayOption : BMFModel

/// traceOverlay是否做动画, 默认YES
@property (nonatomic, assign) BOOL animate;

/// 动画延时开始，单位s
@property (nonatomic, assign) double delay;

/// 动画时间，单位s
@property (nonatomic, assign) double duration;

/// 0~1， 默认0
@property (nonatomic, assign) float fromValue;

/// 0~1，默认1
@property (nonatomic, assign) float toValue;

/// 动画类型
@property (nonatomic, assign) int easingCurve;

/// 是否跟踪轨迹, 默认YES
@property (nonatomic, assign) BOOL trackMove;

- (nullable BMKTraceOverlayOption *)toBMKTraceOverlayOption;

@end

NS_ASSUME_NONNULL_END
