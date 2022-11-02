//
//  BMFOpenPoiModel.h
// flutter_baidu_mapapi_utils
//
//  Created by zhangbaojin on 2020/4/13.
//

#import <flutter_baidu_mapapi_base/BMFModel.h>

@class BMFCoordinate;
@class BMKOpenPoiDetailOption;
@class BMKOpenPoiNearbyOption;

NS_ASSUME_NONNULL_BEGIN

/// 调起百度地图： poi详情参数类
@interface BMFOpenPoiDetailModel : BMFModel

/// poi的uid
@property (nonatomic, copy) NSString *poiUid;

/// 应用返回scheme，用于调起后返回，没有不能返回
@property (nonatomic, copy) NSString *appScheme;

/// 调起百度地图客户端失败后，是否支持调起web地图，默认：YES
@property (nonatomic, assign) BOOL isSupportWeb;

- (BMKOpenPoiDetailOption *)toBMKOpenPoiDetailOption;

@end


/// 调起百度地图： poi周边参数类
@interface BMFOpenPoiNearbyModel : BMFModel

/// 中心点（经纬度）
@property (nonatomic, strong) BMFCoordinate *location;

/// 半径
@property (nonatomic, assign) NSUInteger radius;

/// 关键词
@property (nonatomic, copy) NSString* keyword;

/// 应用返回scheme，用于调起后返回，没有不能返回
@property (nonatomic, copy) NSString *appScheme;

/// 调起百度地图客户端失败后，是否支持调起web地图，默认：YES
@property (nonatomic, assign) BOOL isSupportWeb;

- (BMKOpenPoiNearbyOption *)toBMKOpenPoiNearbyOption;

@end
NS_ASSUME_NONNULL_END
