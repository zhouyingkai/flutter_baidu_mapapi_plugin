//
//  BMFShareURLSearch.m
//  flutter_baidu_mapapi_base
//
//  Created by zhangbaojin on 2020/4/15.
//

#import "BMFShareURLSearch.h"
#import <BaiduMapAPI_Search/BMKShareUrlSearchOption.h>
#import <BaiduMapAPI_Search/BMKShareURLSearch.h>
#import <flutter_baidu_mapapi_base/BMFMapModels.h>
#import "BMFRouteSearchType.h"

@implementation BMFPoiDetailShareURLOption

- (BMKPoiDetailShareURLOption *)toBMKPoiDetailShareURLOption {
    BMKPoiDetailShareURLOption *option = [BMKPoiDetailShareURLOption new];
    if (self.uid) {
        option.uid = self.uid;
    }
    return option;
}

@end


@implementation BMFLocationShareURLOption

- (BMKLocationShareURLOption *)toBMKLocationShareURLOption {
    BMKLocationShareURLOption *option = [BMKLocationShareURLOption new];
    if (self.name) {
        option.name = self.name;
    }
   
    if (self.snippet) {
        option.snippet = self.snippet;
    }
    if (self.location) {
        option.location = [self.location toCLLocationCoordinate2D];
    }
    return option;
}

@end


@implementation BMFRoutePlanShareURLOption

- (BMKRoutePlanShareURLOption *)toBMKRoutePlanShareURLOption {
    BMKRoutePlanShareURLOption *option = [BMKRoutePlanShareURLOption new];
    if (self.from) {
        option.from = [self.from toBMKPlanNode];
    }
    if (self.to) {
        option.to = [self.to toBMKPlanNode];
    }
    if (self.cityID) {
        option.cityID = self.cityID;
    }
    option.routeIndex = self.routeIndex;
    option.routePlanType = self.routePlanType;
    return option;
}

@end

@implementation BMFShareURLResult

+ (instancetype)fromBMKShareURLResult:(BMKShareURLResult *)result {
    BMFShareURLResult *res = [BMFShareURLResult new];
    res.url = result.url;
    return res;
}

@end
