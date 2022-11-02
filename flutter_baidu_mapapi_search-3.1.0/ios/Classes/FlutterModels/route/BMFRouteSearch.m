//
//  BMFRouteSearch.m
//  flutter_baidu_mapapi_base
//
//  Created by zhangbaojin on 2020/4/15.
//

#import "BMFRouteSearch.h"
#import <BaiduMapAPI_Search/BMKRouteSearch.h>
#import <BaiduMapAPI_Search/BMKRouteSearchType.h>
#import <BaiduMapAPI_Search/BMKRouteSearchResult.h>
#import <flutter_baidu_mapapi_base/BMFMapModels.h>

#import "BMFRouteSearchType.h"

#pragma mark - 步行查询基础信息类

@implementation BMFWalkingRoutePlanOption

- (BMKWalkingRoutePlanOption *)toBMKWalkingRoutePlanOption {
    BMKWalkingRoutePlanOption *option = [BMKWalkingRoutePlanOption new];
    if (self.from) {
        option.from = [self.from toBMKPlanNode];
    }
    if (self.to) {
        option.to = [self.to toBMKPlanNode];
    }
    return option;
}

@end

#pragma mark - 骑行查询基础信息类

@implementation BMFRidingRoutePlanOption

- (BMKRidingRoutePlanOption *)toBMKRidingRoutePlanOption {
    BMKRidingRoutePlanOption *option = [BMKRidingRoutePlanOption new];
    if (self.from) {
        option.from = [self.from toBMKPlanNode];
    }
    if (self.to) {
        option.to = [self.to toBMKPlanNode];
    }
    option.ridingType = self.ridingType;
    return option;
}

@end

#pragma mark - 驾车查询基础信息类

@implementation BMFDrivingRoutePlanOption

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"wayPointsArray" : @"BMFPlanNode"};
}

- (BMKDrivingRoutePlanOption *)toBMKDrivingRoutePlanOption {
    BMKDrivingRoutePlanOption *option = [BMKDrivingRoutePlanOption new];
    if (self.from) {
        option.from = [self.from toBMKPlanNode];
    }
    if (self.to) {
        option.to = [self.to toBMKPlanNode];
    }
    if (self.wayPointsArray && self.wayPointsArray.count > 0) {
        NSMutableArray *mut = [NSMutableArray array];
        for (BMFPlanNode *node in self.wayPointsArray) {
            BMKPlanNode *kNode = [node toBMKPlanNode];
            [mut addObject:kNode];
        }
        option.wayPointsArray = [mut copy];
    }
//       BMK_DRIVING_BLK_FIRST = -1, //躲避拥堵(自驾)
//       BMK_DRIVING_TIME_FIRST = 0,    //最短时间(自驾)
//       BMK_DRIVING_DIS_FIRST = 1,    //最短路程(自驾)
//       BMK_DRIVING_FEE_FIRST,        //少走高速(自驾)
    option.drivingPolicy = self.drivingPolicy - 1;
    option.drivingRequestTrafficType = self.drivingRequestTrafficType;
    return option;
}

@end

#pragma mark - 公交查询基础信息类

@implementation BMFTransitRoutePlanOption

- (BMKTransitRoutePlanOption *)toBMKTransitRoutePlanOption {
    BMKTransitRoutePlanOption *option = [BMKTransitRoutePlanOption new];
    if (self.from) {
        option.from = [self.from toBMKPlanNode];
    }
    if (self.to) {
        option.to = [self.to toBMKPlanNode];
    }
    if (self.city) {
        option.city = self.city;
    }
//    BMK_TRANSIT_TIME_FIRST = 3,        //较快捷(公交)
//    BMK_TRANSIT_TRANSFER_FIRST = 4,    //少换乘(公交)
//    BMK_TRANSIT_WALK_FIRST = 5,        //少步行(公交)
//    BMK_TRANSIT_NO_SUBWAY = 6,        //不坐地铁
    option.transitPolicy = self.transitPolicy + 3;
    return option;
}

@end

#pragma mark - 公共交通路线查询基础信息类

@implementation BMFMassTransitRoutePlanOption

- (BMKMassTransitRoutePlanOption *)toBMKMassTransitRoutePlanOption {
    BMKMassTransitRoutePlanOption *option = [BMKMassTransitRoutePlanOption new];
    if (self.from) {
        option.from = [self.from toBMKPlanNode];
    }
    if (self.to) {
        option.to = [self.to toBMKPlanNode];
    }
    option.pageIndex = self.pageIndex;
    option.pageCapacity = self.pageCapacity;
    option.incityPolicy = self.incityPolicy;
    option.intercityPolicy = self.intercityPolicy;
    option.intercityTransPolicy = self.intercityTransPolicy;
    return option;
}

@end

#pragma mark - 室内路线规划

@implementation BMFIndoorRoutePlanOption

- (BMKIndoorRoutePlanOption *)toBMKIndoorRoutePlanOption {
    BMKIndoorRoutePlanOption *option = [BMKIndoorRoutePlanOption new];
    if (self.from) {
        option.from = [self.from toBMKIndoorPlanNode];
    }
    if (self.to) {
        option.to = [self.to toBMKIndoorPlanNode];
    }
    return option;
}

@end

#pragma mark - 规划结果类

#pragma mark - 步行路线规划结果类

@implementation BMFWalkingRouteResult

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"routes" : @"BMFWalkingRouteLine"};
}

+ (instancetype)fromBMKWalkingRouteResult:(BMKWalkingRouteResult *)result {
    BMFWalkingRouteResult *res = [BMFWalkingRouteResult new];
    if (result.suggestAddrResult) {
        res.suggestAddrResult = [BMFSuggestAddrInfo fromBMKSuggestAddrInfo:result.suggestAddrResult];
    }
    if (result.routes && result.routes.count > 0) {
        NSMutableArray <BMFWalkingRouteLine *> * mut = [NSMutableArray array];
        for (BMKWalkingRouteLine *line in result.routes) {
            BMFWalkingRouteLine *fLine = [BMFWalkingRouteLine fromBMKWalkingRouteLine:line];
            [mut addObject:fLine];
        }
        res.routes = [mut copy];
    }
    return res;
}

@end

#pragma mark - 骑行路线规划结果类

@implementation BMFRidingRouteResult

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"routes" : @"BMFRidingRouteLine"};
}

+ (instancetype)fromBMKRidingRouteResult:(BMKRidingRouteResult *)result {
    BMFRidingRouteResult *res = [BMFRidingRouteResult new];
    if (result.suggestAddrResult) {
        res.suggestAddrResult = [BMFSuggestAddrInfo fromBMKSuggestAddrInfo:result.suggestAddrResult];
    }
    if (result.routes && result.routes.count > 0) {
        NSMutableArray <BMFRidingRouteLine *> * mut = [NSMutableArray array];
        for (BMKRidingRouteLine *line in result.routes) {
            BMFRidingRouteLine *fLine = [BMFRidingRouteLine fromBMKRidingRouteLine:line];
            [mut addObject:fLine];
        }
        res.routes = [mut copy];
    }
    return res;
}

@end

#pragma mark - 驾车路线规划结果类

@implementation BMFDrivingRouteResult

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"routes" : @"BMFDrivingRouteLine"};
}

+ (instancetype)fromBMKDrivingRouteResult:(BMKDrivingRouteResult *)result {
    BMFDrivingRouteResult *res = [BMFDrivingRouteResult new];
    if (result.suggestAddrResult) {
        res.suggestAddrResult = [BMFSuggestAddrInfo fromBMKSuggestAddrInfo:result.suggestAddrResult];
    }
    if (result.routes && result.routes.count > 0) {
        NSMutableArray <BMFDrivingRouteLine *> * mut = [NSMutableArray array];
        for (BMKDrivingRouteLine *line in result.routes) {
            BMFDrivingRouteLine *fLine = [BMFDrivingRouteLine fromBMKDrivingRouteLine:line];
            [mut addObject:fLine];
        }
        res.routes = [mut copy];
    }
    return res;
}

@end

#pragma mark - 公交路线规划结果类

@implementation BMFTransitRouteResult

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"routes" : @"BMFTransitRouteLine"};
}

+ (instancetype)fromBMKTransitRouteResult:(BMKTransitRouteResult *)result {
    BMFTransitRouteResult *res = [BMFTransitRouteResult new];
    if (result.taxiInfo) {
        res.taxiInfo = [BMFTaxiInfo fromBMKTaxiInfo:result.taxiInfo];
    }
    if (result.suggestAddrResult) {
        res.suggestAddrResult = [BMFSuggestAddrInfo fromBMKSuggestAddrInfo:result.suggestAddrResult];
    }
    if (result.routes && result.routes.count > 0) {
        NSMutableArray <BMFTransitRouteLine *> * mut = [NSMutableArray array];
        for (BMKTransitRouteLine *line in result.routes) {
            BMFTransitRouteLine *fLine = [BMFTransitRouteLine fromBMKTransitRouteLine:line];
            [mut addObject:fLine];
        }
        res.routes = [mut copy];
    }
    return res;
}

@end

#pragma mark - 跨城路线规划结果类

@implementation BMFMassTransitRouteResult

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"routes" : @"BMFMassTransitRouteLine"};
}

+ (instancetype)fromBMKMassTransitRouteResult:(BMKMassTransitRouteResult *)result {
    BMFMassTransitRouteResult *res = [BMFMassTransitRouteResult new];
    if (result.taxiInfo) {
        res.taxiInfo = [BMFTaxiInfo fromBMKTaxiInfo:result.taxiInfo];
    }
    if (result.suggestAddrResult) {
        res.suggestAddrResult = [BMFSuggestAddrInfo fromBMKSuggestAddrInfo:result.suggestAddrResult];
    }
    if (result.routes && result.routes.count > 0) {
        NSMutableArray <BMFMassTransitRouteLine *> * mut = [NSMutableArray array];
        for (BMKMassTransitRouteLine *line in result.routes) {
            BMFMassTransitRouteLine *fLine = [BMFMassTransitRouteLine fromBMKMassTransitRouteLine:line];
            [mut addObject:fLine];
        }
        res.routes = [mut copy];
    }
    res.totalRoutes = result.totalRoutes;
    return res;
}

@end

#pragma mark - 室内路线规划结果类
@implementation BMFIndoorRouteResult

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"routes" : @"BMFIndoorRouteLine"};
}

+ (instancetype)fromBMKIndoorRouteResult:(BMKIndoorRouteResult *)result {
    BMFIndoorRouteResult *res = [BMFIndoorRouteResult new];
    if (result.routes && result.routes.count > 0) {
        NSMutableArray <BMFIndoorRouteLine *> * mut = [NSMutableArray array];
        for (BMKIndoorRouteLine *line in result.routes) {
            BMFIndoorRouteLine *fLine = [BMFIndoorRouteLine fromBMKIndoorRouteLine:line];
            [mut addObject:fLine];
        }
        res.routes = [mut copy];
    }
    return res;
}

@end
