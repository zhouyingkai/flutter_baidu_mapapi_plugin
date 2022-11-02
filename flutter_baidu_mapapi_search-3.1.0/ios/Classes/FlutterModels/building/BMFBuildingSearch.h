//
//  BMFBuildingSearch.h
//  flutter_baidu_mapapi_search
//
//  Created by zhangbaojin on 2022/1/6.
//

#import <flutter_baidu_mapapi_base/BMFModel.h>

@class BMFCoordinate;
@class BMFBuildInfo;
@class BMKBuildingSearchOption;
@class BMKBuildingSearchResult;

NS_ASSUME_NONNULL_BEGIN

/// 建筑物请求信息类 since 6.4.0
@interface BMFBuildingSearchOption : BMFModel

/// 待解析的经纬度坐标（必选）
@property (nonatomic, strong) BMFCoordinate *location;

- (BMKBuildingSearchOption *)toBMKBuildingSearchOption;

@end

/// 建筑物返回结果类
@interface BMFBuildingSearchResult : BMFModel

/// 建筑物返回结果列表
@property (nonatomic, copy) NSArray<BMFBuildInfo *> *buildingList;

+ (instancetype)fromBMKBuildingSearchResult:(BMKBuildingSearchResult *)result ;

@end

NS_ASSUME_NONNULL_END
