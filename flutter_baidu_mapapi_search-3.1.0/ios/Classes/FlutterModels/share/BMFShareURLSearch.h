//
//  BMFShareURLSearch.h
//  flutter_baidu_mapapi_base
//
//  Created by zhangbaojin on 2020/4/15.
//

#import <flutter_baidu_mapapi_base/BMFModel.h>

@class BMFCoordinate;
@class BMFPlanNode;
@class BMKPoiDetailShareURLOption;
@class BMKLocationShareURLOption;
@class BMKRoutePlanShareURLOption;
@class BMKShareURLResult;

NS_ASSUME_NONNULL_BEGIN

/// poi详情短串分享检索信息类
@interface BMFPoiDetailShareURLOption : BMFModel

/// poi的uid
@property (nonatomic, copy) NSString *uid;

- (BMKPoiDetailShareURLOption *)toBMKPoiDetailShareURLOption;

@end

/// 反geo短串分享检索信息类
@interface BMFLocationShareURLOption : BMFModel

/// 名称
@property (nonatomic, copy) NSString *name;

/// 通过短URL调起客户端时作为附加信息显示在名称下面
@property (nonatomic, copy) NSString *snippet;

/// 经纬度
@property (nonatomic, strong) BMFCoordinate *location;

- (BMKLocationShareURLOption *)toBMKLocationShareURLOption;

@end


/// 路线规划短串分享检索信息类
@interface BMFRoutePlanShareURLOption : BMFModel

/// 路线规划短串分享类型
@property (nonatomic, assign) int routePlanType;

/// 起点，可通过关键字、坐标两种方式指定，使用关键字时必须指定from.cityID
@property (nonatomic, strong) BMFPlanNode *from;

/// 终点，可通过关键字、坐标两种方式指定，使用关键字时必须指定to.cityID
@property (nonatomic, strong) BMFPlanNode *to;

/// cityID，当进行公交路线规划短串分享且起终点通过关键字指定时，必须指定
@property (nonatomic, assign) NSUInteger cityID;

/// 公交路线规划短串分享时使用，分享的是第几条线路
@property (nonatomic, assign) NSUInteger routeIndex;

- (BMKRoutePlanShareURLOption *)toBMKRoutePlanShareURLOption;

@end


#pragma mark - 短串分享结果类
/// 分享URL结果类
@interface BMFShareURLResult : BMFModel

/// 返回结果url
@property (nonatomic, copy) NSString *url;

+ (instancetype)fromBMKShareURLResult:(BMKShareURLResult *)result;

@end


NS_ASSUME_NONNULL_END
