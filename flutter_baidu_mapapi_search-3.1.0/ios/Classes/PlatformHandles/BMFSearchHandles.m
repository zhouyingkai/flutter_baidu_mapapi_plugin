//
//  BMFSearchHandles.m
//  flutter_baidu_mapapi_search
//
//  Created by zhangbaojin on 2020/4/15.
//

#import "BMFSearchHandles.h"

#import "BMFSearchMethodConst.h"

#import "BMFBuslineSearchHandler.h"
#import "BMFShareURLSearchHandler.h"
#import "BMFDistrictSearchHandler.h"
#import "BMFGeoCodeSearchHandler.h"
#import "BMFPoiSearchHandler.h"
#import "BMFRecommendStopSearchHandler.h"
#import "BMFRouteSearchHandler.h"
#import "BMFShareURLSearchHandler.h"
#import "BMFSuggestionSearchHandler.h"
#import "BMFWeatherSearchHandler.h"
#import "BMFBuildingSearchHandler.h"

@interface BMFSearchHandles ()
{
    NSDictionary<NSString *, NSString *> *_handles;
    NSMutableArray<NSObject<BMFSearchHandle> *> *_handlerArray;
}
@end

@implementation BMFSearchHandles

static BMFSearchHandles *_instance = nil;
+ (instancetype)defalutCenter {
    return  [[BMFSearchHandles alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
     @synchronized(self) { // 同步
        if (!_instance) {
            _instance = [super allocWithZone:zone];
        }
    }
    return _instance;
}
 
- (instancetype)copyWithZone:(struct _NSZone *)zone {
    return _instance;
}

- (instancetype)mutableCopyWithZone:(nullable NSZone *)zone {
    return _instance;
}

- (NSDictionary<NSString *, NSString *> *)searchHandles {
    if (!_handles) {
        _handles = @{kBMFBusLineSearchMethod : NSStringFromClass([BMFBuslineSearchHandler class]),
                     kBMFDistrictSearchMethod : NSStringFromClass([BMFDistrictSearchHandler class]),
                     kBMFGeoCodeSearchMethod : NSStringFromClass([BMFGeoCodeSearchHandler class]),
                     kBMFReverseGeoCodeSearchMethod : NSStringFromClass([BMFGeoCodeSearchHandler class]),
                     kBMFPoiSearchInCityMethod : NSStringFromClass([BMFPoiSearchHandler class]),
                     kBMFPoiSearchNearByMethod : NSStringFromClass([BMFPoiSearchHandler class]),
                     kBMFPoiSearchInboundsMethod : NSStringFromClass([BMFPoiSearchHandler class]),
                     kBMFPoiIndoorSearchMethod : NSStringFromClass([BMFPoiSearchHandler class]),
                     kBMFPoiDetailSearchMethod : NSStringFromClass([BMFPoiSearchHandler class]),
                     kBMFRecommendStopSearchMethod : NSStringFromClass([BMFRecommendStopSearchHandler class]),
                     kBMFTransitSearchMethod : NSStringFromClass([BMFRouteSearchHandler class]),
                     kBMFMassTransitSearchMethod : NSStringFromClass([BMFRouteSearchHandler class]),
                     kBMFDrivingSearchMethod : NSStringFromClass([BMFRouteSearchHandler class]),
                     kBMFWalkingSearchMethod : NSStringFromClass([BMFRouteSearchHandler class]),
                     kBMFRidingSearchMethod : NSStringFromClass([BMFRouteSearchHandler class]),
                     kBMFIndoorRoutePlanSearchMethod : NSStringFromClass([BMFRouteSearchHandler class]),
                     kBMFPoiDetailShareURLMethod : NSStringFromClass([BMFShareURLSearchHandler class]),
                     kBMFLocationShareURLMethod : NSStringFromClass([BMFShareURLSearchHandler class]),
                     kBMFRoutePlanShareURLMethod : NSStringFromClass([BMFShareURLSearchHandler class]),
                     kBMFSuggestionSearchMethod : NSStringFromClass([BMFSuggestionSearchHandler class]),
                     kBMFWeatherSearchMethod : NSStringFromClass([BMFWeatherSearchHandler class]),
                     kBMFBuildingSearchMethod: NSStringFromClass([BMFBuildingSearchHandler class])
        };
    }
    return _handles;
}

- (NSMutableArray<NSObject<BMFSearchHandle> *> *)handlerArray {
    if (!_handlerArray) {
        _handlerArray = [NSMutableArray array];
    }
    return _handlerArray;
}

@end
