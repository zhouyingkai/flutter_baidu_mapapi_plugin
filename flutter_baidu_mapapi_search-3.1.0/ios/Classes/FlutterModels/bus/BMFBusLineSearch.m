//
//  BMFBusLineSearchOption.m
//  flutter_baidu_mapapi_base
//
//  Created by zhangbaojin on 2020/4/15.
//

#import "BMFBusLineSearch.h"
#import <BaiduMapAPI_Search/BMKBusLineSearchOption.h>
#import <BaiduMapAPI_Search/BMKBusLineSearchResult.h>
#import <BaiduMapAPI_Utils/BMKGeometry.h>
#import <flutter_baidu_mapapi_base/BMFMapModels.h>
#import "BMFRouteSearchType.h"

@implementation BMFBusLineSearchOption

- (BMKBusLineSearchOption *)toBMKBusLineSearchOption {
    BMKBusLineSearchOption *option = [BMKBusLineSearchOption new];
    if (self.city) {
        option.city = self.city;
    }
    if (self.busLineUid) {
        option.busLineUid = self.busLineUid;
    }
    return option;
}

@end


@implementation BMFBusLineResult

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"busStations" : @"BMFBusStation",
             @"busSteps" : @"BMFBusStep"
    };
}

+ (instancetype)fromBMKBusLineSearchResult:(BMKBusLineResult *)result {
    BMFBusLineResult *res = [BMFBusLineResult new];
    /// 公交公司名称
//    res.busCompany = result.busCompany;
    /// 公交线路名称
    res.busLineName = result.busLineName;
    /// 公交线路方向
    res.busLineDirection = result.busLineDirection;
    /// 公交线路uid
    res.uid = result.uid;
    /// 公交路线首班车时间
    res.startTime = result.startTime;
    /// 公交路线末班车时间
    res.endTime = result.endTime;
    /// 公交路线是否有月票
    res.isMonTicket = result.isMonTicket;
    /// 起步票价
    res.basicPrice = result.basicPrice;
    /// 全程票价
    res.totalPrice = result.totalPrice;

    /// 所有公交站点信息,成员类型为BMKBusStation
    if (result.busStations && result.busStations.count > 0) {
        NSMutableArray <BMFBusStation *> *mut = [NSMutableArray array];
        
        for (BMKBusStation *info in result.busStations) {
            BMFBusStation *bInfo = [BMFBusStation fromBMKBusStation:info];
            [mut addObject:bInfo];
        }
        res.busStations = [mut copy];
    }
    /// 公交路线分段信息，成员类型为BMKBusStep
    if (result.busSteps && result.busSteps.count > 0) {
        NSMutableArray <BMFBusStep *> * mut = [NSMutableArray array];
        for (BMKBusStep *step in result.busSteps) {
            BMFBusStep *st = [BMFBusStep fromBMKBusStep:step];
            [mut addObject:st];
        }
        res.busSteps = [mut copy];
    }
    
    return res;
}

@end
