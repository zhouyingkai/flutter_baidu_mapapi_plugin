
#ifndef __BMFSearchMethodConst__H__
#define __BMFSearchMethodConst__H__

#import <Foundation/Foundation.h>

/// 获取检索组件版本号
FOUNDATION_EXPORT NSString *const kBMFGetSearchVersionMethod;

/// 公交详情搜索服务
FOUNDATION_EXPORT NSString *const kBMFBusLineSearchMethod;


/// 行政区域搜索服务
FOUNDATION_EXPORT NSString *const kBMFDistrictSearchMethod;


/// 地理编码
FOUNDATION_EXPORT NSString *const kBMFGeoCodeSearchMethod;
/// 逆地理编码
FOUNDATION_EXPORT NSString *const kBMFReverseGeoCodeSearchMethod;


/// 城市POI检索
FOUNDATION_EXPORT NSString *const kBMFPoiSearchInCityMethod;
/// 根据范围和检索词发起范围检索
FOUNDATION_EXPORT NSString *const kBMFPoiSearchInboundsMethod;
/// 根据中心点、半径和检索词发起周边检索
FOUNDATION_EXPORT NSString *const kBMFPoiSearchNearByMethod;
/// 根据poi uid 发起poi详情检索
FOUNDATION_EXPORT NSString *const kBMFPoiDetailSearchMethod;
/// poi室内检索
FOUNDATION_EXPORT NSString *const kBMFPoiIndoorSearchMethod;


/// 公交路线检索（仅支持市内）
FOUNDATION_EXPORT NSString *const kBMFTransitSearchMethod;
/// 公共交通路线检索（new）（支持市内和跨城）
FOUNDATION_EXPORT NSString *const kBMFMassTransitSearchMethod;
/// 驾乘路线检索
FOUNDATION_EXPORT NSString *const kBMFDrivingSearchMethod;
/// 步行路线检索
FOUNDATION_EXPORT NSString *const kBMFWalkingSearchMethod;
/// 骑行路线检索
FOUNDATION_EXPORT NSString *const kBMFRidingSearchMethod;
/// 室内路线检索
FOUNDATION_EXPORT NSString *const kBMFIndoorRoutePlanSearchMethod;


/// 获取poi详情短串分享url
FOUNDATION_EXPORT NSString *const kBMFPoiDetailShareURLMethod;
/// 获取反geo短串分享url
FOUNDATION_EXPORT NSString *const kBMFLocationShareURLMethod;
/// 获取路线规划短串分享url
FOUNDATION_EXPORT NSString *const kBMFRoutePlanShareURLMethod;


/// sug搜索服务
FOUNDATION_EXPORT NSString *const kBMFSuggestionSearchMethod;

/// 推荐上车点服务
FOUNDATION_EXPORT NSString *const kBMFRecommendStopSearchMethod;

/// 天气服务
FOUNDATION_EXPORT NSString *const kBMFWeatherSearchMethod;

/// 地图建筑物检索
FOUNDATION_EXPORT NSString *const kBMFBuildingSearchMethod;

#endif
