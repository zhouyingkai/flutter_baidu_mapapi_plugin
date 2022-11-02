//
//  BMFOpenRouteModel.h
// flutter_baidu_mapapi_utils
//
//  Created by zhangbaojin on 2020/4/13.
//

#import <flutter_baidu_mapapi_base/BMFModel.h>

@class BMFCoordinate;
@class BMKOpenWalkingRouteOption;
@class BMKOpenDrivingRouteOption;
@class BMKOpenTransitRouteOption;
/// 调起百度地图路线类型
typedef NS_ENUM(NSUInteger, BMFRouteType) {
    kBMFWalkingRoute = 0,     ///<调起百度地图步行路线
    kBMFDrivingRoute,        ///<调起百度地图驾车路线
    kBMFTransitRoute,       ///<调起百度地图公共交通路线

};
/// 交通路线策略
typedef NS_ENUM(NSUInteger, BMFOpenTransitPolicy) {
    BMF_OPEN_TRANSIT_RECOMMAND = 3,     ///<推荐
    BMF_OPEN_TRANSIT_TRANSFER_FIRST,    ///<少换乘
    BMF_OPEN_TRANSIT_WALK_FIRST,        ///<少步行
    BMF_OPEN_TRANSIT_NO_SUBWAY,         ///<不坐地铁
    BMF_OPEN_TRANSIT_TIME_FIRST,        ///<时间短
};


NS_ASSUME_NONNULL_BEGIN

@interface BMFOpenRouteModel : BMFModel

/// 起点坐标
@property (nonatomic, strong) BMFCoordinate *startCoord;

/// 起点名称
@property (nonatomic, copy) NSString *startName;

/// 终点坐标
@property (nonatomic, strong) BMFCoordinate *endCoord;

/// 终点名称
@property (nonatomic, copy) NSString *endName;

/// 调起路线类型
@property (nonatomic, assign) NSUInteger routeType;

/// 策略，默认：BMF_OPEN_TRANSIT_RECOMMAND(异常值，强制使用BMF_OPEN_TRANSIT_RECOMMAND)
@property (nonatomic, assign) NSUInteger openTransitPolicy;


/// 应用返回scheme，用于调起后返回，没有不能返回
@property (nonatomic, copy) NSString *appScheme;

/// 调起百度地图客户端失败后，是否支持调起web地图，默认：YES
@property (nonatomic, assign) BOOL isSupportWeb;

- (BMKOpenWalkingRouteOption *)toBMKOpenWalkingRouteOption;

- (BMKOpenDrivingRouteOption *)toBMKOpenDrivingRouteOption;

- (BMKOpenTransitRouteOption *)toBMKOpenTransitRouteOption;

@end



NS_ASSUME_NONNULL_END
