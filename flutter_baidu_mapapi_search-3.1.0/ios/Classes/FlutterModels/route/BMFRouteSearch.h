//
//  BMFRouteSearch.h
//  flutter_baidu_mapapi_base
//
//  Created by zhangbaojin on 2020/4/15.
//

#import <flutter_baidu_mapapi_base/BMFModel.h>
#import "BMFRouteSearchType.h"

@class BMFPlanNode;
@class BMFIndoorPlanNode;

@class BMKWalkingRoutePlanOption;
@class BMKDrivingRoutePlanOption;
@class BMKRidingRoutePlanOption;
@class BMKTransitRoutePlanOption;
@class BMKMassTransitRoutePlanOption;
@class BMKIndoorRoutePlanOption;

@class BMKWalkingRouteResult;
@class BMKRidingRouteResult;
@class BMKDrivingRouteResult;
@class BMKTransitRouteResult;
@class BMKMassTransitRouteResult;
@class BMKIndoorRouteResult;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 步行查询基础信息类

/// 步行查询基础信息类
@interface BMFWalkingRoutePlanOption : BMFModel

/// 检索的起点
@property (nonatomic, strong) BMFPlanNode *from;

/// 检索的终点
@property (nonatomic, strong) BMFPlanNode *to;

- (BMKWalkingRoutePlanOption *)toBMKWalkingRoutePlanOption;

@end

#pragma mark - 骑行查询基础信息类
/// 骑行查询基础信息类
@interface BMFRidingRoutePlanOption : BMFModel

/// 检索的起点
@property (nonatomic, strong) BMFPlanNode *from;

/// 检索的终点
@property (nonatomic, strong) BMFPlanNode *to;
///  骑行类型（0：普通骑行，1：电动车骑行），默认是普通骑行
@property (nonatomic, assign) NSInteger ridingType;

- (BMKRidingRoutePlanOption *)toBMKRidingRoutePlanOption;

@end

#pragma mark - 驾车查询基础信息类

/// 驾车查询基础信息类
@interface  BMFDrivingRoutePlanOption : BMFModel

/// 检索的起点
@property (nonatomic, strong) BMFPlanNode *from;

/// 检索的终点
@property (nonatomic, strong) BMFPlanNode *to;

/// 驾车途经点
@property (nonatomic, copy) NSArray <BMFPlanNode *> *wayPointsArray;

/// 驾车检索策略，默认使用BMF_DRIVING_TIME_FIRST
@property (nonatomic, assign) int drivingPolicy;

/// 驾车检索获取路线每一个step的路况，默认使用BMF_DRIVING_REQUEST_TRAFFICE_TYPE_NONE
@property (nonatomic, assign) int drivingRequestTrafficType;

- (BMKDrivingRoutePlanOption *)toBMKDrivingRoutePlanOption;

@end

#pragma mark - 公交查询基础信息类

/// 公交查询基础信息类
@interface BMFTransitRoutePlanOption : BMFModel

///检索的起点
@property (nonatomic, strong) BMFPlanNode *from;

/// 检索的终点
@property (nonatomic, strong) BMFPlanNode *to;

/// 城市名，用于在哪个城市内进行检索
@property (nonatomic, copy) NSString *city;

/// 公交检索策略，默认使用BMF_TRANSIT_TIME_FIRST
@property (nonatomic, assign) int transitPolicy;

- (BMKTransitRoutePlanOption *)toBMKTransitRoutePlanOption;

@end


#pragma mark - 公共交通路线查询基础信息类

/// 公共交通路线查询基础信息类（支持市内和跨城）(注：起终点城市不支持cityId)
@interface BMFMassTransitRoutePlanOption : BMFModel

/// 检索的起点
@property (nonatomic, strong) BMFPlanNode *from;

/// 检索的终点
@property (nonatomic, strong) BMFPlanNode *to;

/// 分页索引，可选，默认为0(从0开始)
@property (nonatomic, assign) NSUInteger pageIndex;

/// 分页数量，可选，默认为10，取值范围[1,10]
@property (nonatomic, assign) NSUInteger pageCapacity;

/// 市内公交换乘策略策略，可选，默认使用BMF_MASS_TRANSIT_INCITY_RECOMMEND
@property (nonatomic, assign) int incityPolicy;

/// 跨城公交换乘策略，可选，默认使用BMF_MASS_TRANSIT_INTERCITY_TIME_FIRST
@property (nonatomic, assign) int intercityPolicy;

/// 跨城交通方式策略，可选，默认使用BMF_MASS_TRANSIT_INTERCITY_TRANS_TRAIN_FIRST
@property (nonatomic, assign) int intercityTransPolicy;

- (BMKMassTransitRoutePlanOption *)toBMKMassTransitRoutePlanOption;

@end

#pragma mark - 室内路线规划

/// 室内路线规划查询基础信息类
@interface BMFIndoorRoutePlanOption : BMFModel

/// 检索的起点
@property (nonatomic, strong) BMFIndoorPlanNode *from;

/// 检索的终点
@property (nonatomic, strong) BMFIndoorPlanNode *to;

- (BMKIndoorRoutePlanOption *)toBMKIndoorRoutePlanOption;

@end

#pragma mark - 规划结果类

#pragma mark - 步行路线规划结果类
/// 步行路线规划结果类
@interface BMFWalkingRouteResult : BMFModel

/// 该路线打车信息
//@property (nonatomic, strong) BMFTaxiInfo *taxiInfo __deprecated_msg("预留字段，现为空");

/// 返回起点或终点的地址信息结果
@property (nonatomic, strong) BMFSuggestAddrInfo *suggestAddrResult;

/// 步行结果,现在只返回一条。成员类型为BMFWalkingRouteLine
@property (nonatomic, copy) NSArray <BMFWalkingRouteLine *> *routes;

+ (instancetype)fromBMKWalkingRouteResult:(BMKWalkingRouteResult *)result;

@end

#pragma mark - 骑行路线规划结果类
/// 骑行路线规划结果类
@interface BMFRidingRouteResult : BMFModel

/// 返回起点或终点的地址信息结果
@property (nonatomic, strong) BMFSuggestAddrInfo *suggestAddrResult;

/// 骑行路线结果,成员类型为BMFRidingRouteLine
@property (nonatomic, copy) NSArray <BMFRidingRouteLine *> *routes;

+ (instancetype)fromBMKRidingRouteResult:(BMKRidingRouteResult *)result;

@end

#pragma mark - 驾车路线规划结果类

/// 驾车路线规划结果类
@interface BMFDrivingRouteResult : BMFModel

/// 该路线打车信息
//@property (nonatomic, strong) BMFTaxiInfo *taxiInfo __deprecated_msg("预留字段，现为空");

/// 返回起点或终点的地址信息结果
@property (nonatomic, strong) BMFSuggestAddrInfo *suggestAddrResult;

/// 驾车结果,支持多路线。成员类型为BMFDrivingRouteLine
@property (nonatomic, copy) NSArray <BMFDrivingRouteLine *> *routes;

+ (instancetype)fromBMKDrivingRouteResult:(BMKDrivingRouteResult *)result;

@end

#pragma mark - 公交路线规划结果类

/// 公交路线规划结果类
@interface BMFTransitRouteResult : BMFModel

/// 该路线打车信息
@property (nonatomic, strong) BMFTaxiInfo *taxiInfo;

/// 返回起点或终点的地址信息结果
@property (nonatomic, strong) BMFSuggestAddrInfo *suggestAddrResult;

/// 方案数组,成员类型为BMFTransitRouteLine
@property (nonatomic, copy) NSArray <BMFTransitRouteLine *> *routes;

+ (instancetype)fromBMKTransitRouteResult:(BMKTransitRouteResult *)result;

@end

#pragma mark - 跨城路线规划结果类

/// 跨城路线规划结果类
@interface BMFMassTransitRouteResult : BMFModel

/// 返回起点或终点的地址信息结果
@property (nonatomic, strong) BMFSuggestAddrInfo *suggestAddrResult;

/// 方案数组,成员类型为BMFMassTransitRouteLine
@property (nonatomic, copy) NSArray <BMFMassTransitRouteLine *> *routes;

/// 总方案数
@property (nonatomic, assign) NSInteger totalRoutes;

/// 该路线打车信息(只有起终点是大陆地区且是同城的请求时才返回此字段, 否则此字段为nil)
@property (nonatomic, strong) BMFTaxiInfo *taxiInfo;

+ (instancetype)fromBMKMassTransitRouteResult:(BMKMassTransitRouteResult *)result;

@end

#pragma mark - 室内路线规划结果类

/// 室内路线规划结果类
@interface BMFIndoorRouteResult : BMFModel

/// 方案数组,成员类型为BMFIndoorRouteLine
@property (nonatomic, copy) NSArray <BMFIndoorRouteLine *> *routes;

+ (instancetype)fromBMKIndoorRouteResult:(BMKIndoorRouteResult *)result;

@end

NS_ASSUME_NONNULL_END
