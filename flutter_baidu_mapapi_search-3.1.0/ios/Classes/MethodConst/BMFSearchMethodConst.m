
#ifndef __BMFSearchMethodConst__M__
#define __BMFSearchMethodConst__M__

#import <Foundation/Foundation.h>

/// 获取检索组件版本号
NSString *const kBMFGetSearchVersionMethod = @"flutter_bmfsearch/search/getNativeSearchVersion";

/// 公交详情搜索服务
NSString *const kBMFBusLineSearchMethod = @"flutter_bmfsearch/busLineSearch/busLineSearch";


/// 行政区域搜索服务
NSString *const kBMFDistrictSearchMethod = @"flutter_bmfsearch/districtSearch/districtSearch";


/// 地理编码
NSString *const kBMFGeoCodeSearchMethod = @"flutter_bmfsearch/geoSearch/geoCode";
/// 逆地理编码
NSString *const kBMFReverseGeoCodeSearchMethod = @"flutter_bmfsearch/geoSearch/reverseGeoCode";


/// 城市POI检索
NSString *const kBMFPoiSearchInCityMethod = @"flutter_bmfsearch/poiSearch/poiSearchInCity";
/// 根据范围和检索词发起范围检索
NSString *const kBMFPoiSearchInboundsMethod = @"flutter_bmfsearch/poiSearch/poiSearchInbounds";
/// 根据中心点、半径和检索词发起周边检索
NSString *const kBMFPoiSearchNearByMethod = @"flutter_bmfsearch/poiSearch/poiSearchNearBy";
/// 根据poi uid 发起poi详情检索
NSString *const kBMFPoiDetailSearchMethod = @"flutter_bmfsearch/poiSearch/poiDetailSearch";
/// poi室内检索
NSString *const kBMFPoiIndoorSearchMethod = @"flutter_bmfsearch/poiSearch/poiIndoorSearch";


/// 公交路线检索（仅支持市内）
NSString *const kBMFTransitSearchMethod = @"flutter_bmfsearch/routeSearch/transitSearch";
/// 公共交通路线检索（new）（支持市内和跨城）
NSString *const kBMFMassTransitSearchMethod = @"flutter_bmfsearch/routeSearch/massTransitSearch";
/// 驾乘路线检索
NSString *const kBMFDrivingSearchMethod = @"flutter_bmfsearch/routeSearch/drivingSearch";
/// 步行路线检索
NSString *const kBMFWalkingSearchMethod = @"flutter_bmfsearch/routeSearch/walkingSearch";
/// 骑行路线检索
NSString *const kBMFRidingSearchMethod = @"flutter_bmfsearch/routeSearch/ridingSearch";
/// 室内路线检索
NSString *const kBMFIndoorRoutePlanSearchMethod = @"flutter_bmfsearch/routeSearch/indoorRoutePlanSearch";

/// 获取poi详情短串分享url
NSString *const kBMFPoiDetailShareURLMethod = @"flutter_bmfsearch/shareURL/requestPoiDetailShareURL";
/// 获取反geo短串分享url
NSString *const kBMFLocationShareURLMethod = @"flutter_bmfsearch/shareURL/requestLocationShareURL";
/// 获取路线规划短串分享url
NSString *const kBMFRoutePlanShareURLMethod = @"flutter_bmfsearch/shareURL/requestRoutePlanShareURL";


/// sug搜索服务
NSString *const kBMFSuggestionSearchMethod = @"flutter_bmfsearch/suggestionSearch/suggestionSearch";

/// 推荐上车点服务
NSString *const kBMFRecommendStopSearchMethod = @"flutter_bmfsearch/recommendStopSearch/recommendStopSearch";
/// 天气服务
NSString *const kBMFWeatherSearchMethod = @"flutter_bmfsearch/weatherSearch/weatherSearch";

/// 地图建筑物检索
NSString *const kBMFBuildingSearchMethod = @"flutter_bmfsearch/buildingSearch/buildingSearch";

#endif
