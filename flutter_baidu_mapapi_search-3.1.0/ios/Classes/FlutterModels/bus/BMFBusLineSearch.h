//
//  BMFBusLineSearchOption.h
//  flutter_baidu_mapapi_base
//
//  Created by zhangbaojin on 2020/4/15.
//

#import <flutter_baidu_mapapi_base/BMFModel.h>

@class BMKBusLineSearchOption;
@class BMKBusLineResult;

@class BMFBusStation;
@class BMFBusStep;

NS_ASSUME_NONNULL_BEGIN

@interface BMFBusLineSearchOption : BMFModel

/// 城市名
@property (nonatomic, copy) NSString *city;

/// 公交线路的uid 注：从Sug检索或者POI城市检索中搜索公交线路,得到的结果中获取。
@property (nonatomic, copy) NSString *busLineUid;

- (BMKBusLineSearchOption *)toBMKBusLineSearchOption;

@end

#pragma mark - bus检索结果

@interface BMFBusLineResult : BMFModel
/// 公交公司名称
//@property (nonatomic, copy) NSString *busCompany __deprecated_msg("预留字段，现为空");

/// 公交线路名称
@property (nonatomic, copy) NSString *busLineName;
/// 公交线路方向
@property (nonatomic, copy) NSString *busLineDirection;
/// 公交线路uid
@property (nonatomic, copy) NSString *uid;
/// 公交路线首班车时间
@property (nonatomic, copy) NSString *startTime;
/// 公交路线末班车时间
@property (nonatomic, copy) NSString *endTime;
/// 公交路线是否有月票
@property (nonatomic, assign) BOOL isMonTicket;
/// 起步票价
@property (nonatomic, assign) CGFloat basicPrice;
/// 全程票价
@property (nonatomic, assign) CGFloat totalPrice;
/// 所有公交站点信息,成员类型为BMKBusStation
@property (nonatomic, copy) NSArray <BMFBusStation *> *busStations;
/// 公交路线分段信息，成员类型为BMKBusStep
@property (nonatomic, copy) NSArray <BMFBusStep *> *busSteps;

+ (instancetype)fromBMKBusLineSearchResult:(BMKBusLineResult *)result;

@end
NS_ASSUME_NONNULL_END
