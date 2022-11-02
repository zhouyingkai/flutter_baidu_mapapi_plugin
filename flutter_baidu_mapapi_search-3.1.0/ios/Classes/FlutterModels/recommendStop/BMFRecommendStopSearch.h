//
//  BMFRecommendStopSearch.h
//  flutter_baidu_mapapi_search
//
//  Created by Zhang,Baojin on 2020/11/12.
//

#import <flutter_baidu_mapapi_base/BMFModel.h>

@class BMFCoordinate;
@class BMKRecommendStopSearchOption;
@class BMKRecommendStopInfo;
@class BMKRecommendStopSearchResult;

NS_ASSUME_NONNULL_BEGIN

@interface BMFRecommendStopSearchOption : BMFModel

/// 推荐上车点经纬度 （必选）
@property (nonatomic, strong) BMFCoordinate *location;


- (BMKRecommendStopSearchOption *)toBMKRecommendStopSearchOption;

@end


@interface BMFRecommendStopInfo : BMFModel

/// 推荐上车点名称
@property (nonatomic, copy) NSString *name;

/// 推荐上车点地址
@property (nonatomic, copy) NSString *address;

/// 推荐上车点经纬度
@property (nonatomic, strong) BMFCoordinate *location;

/// 推荐点poi的uid
@property (nonatomic, copy) NSString *uid;

/// 距查找点的距离，单位米
@property (nonatomic, assign) CGFloat distance;

+ (instancetype)fromBMKRecommendStopInfo:(BMKRecommendStopInfo *)result;

@end

@interface BMFRecommendStopSearchResult : BMFModel

/// 推荐上车点返回结果列表
@property (nonatomic, copy) NSArray<BMFRecommendStopInfo *> *recommendStopInfoList;

+ (instancetype)fromBMKRecommendStopSearchResult:(BMKRecommendStopSearchResult *)result;

@end

NS_ASSUME_NONNULL_END
