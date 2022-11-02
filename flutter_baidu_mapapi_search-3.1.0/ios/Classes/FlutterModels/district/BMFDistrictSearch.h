//
//  BMFDistrictSearchOption.h
//  flutter_baidu_mapapi_base
//
//  Created by zhangbaojin on 2020/4/7.
//

#import <flutter_baidu_mapapi_base/BMFModel.h>

@class BMFCoordinate;
@class BMKDistrictResult;
@class BMKDistrictSearchOption;
@class BMFCoordinates;

NS_ASSUME_NONNULL_BEGIN
/// 行政区域检索信息
@interface BMFDistrictSearchOption : BMFModel

/// 城市名字（必须）
@property (nonatomic, copy) NSString *city;

/// 区县名字（可选）
@property (nonatomic, copy) NSString *district;

- (BMKDistrictSearchOption *)toBMKDistrictSearchOption;

@end
/// 行政区域检索结果
@interface BMFDistrictSearchResult : BMFModel

/// 行政区域编码
@property (nonatomic, assign) NSInteger code;

/// 行政区域名称
@property (nonatomic, copy) NSString *name;

/// 行政区域中心点
@property (nonatomic, strong) BMFCoordinate *center;

@property (nonatomic, copy) NSArray<NSArray<BMFCoordinate *> *> *paths;

+ (instancetype)fromBMKDistrictSearchResult:(BMKDistrictResult *)data;

@end

@interface BMFCoordinates : BMFModel

/// 经纬度数组
@property (nonatomic, copy) NSArray<BMFCoordinate *> *coords;

@end
NS_ASSUME_NONNULL_END
