//
//  BMFGeocodeSearchOption.m
//  flutter_baidu_mapapi_base
//
//  Created by zhangbaojin on 2020/4/7.
//

#import "BMFGeocodeSearch.h"
#import <BaiduMapAPI_Search/BMKGeocodeSearchOption.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearchResult.h>
#import <flutter_baidu_mapapi_base/BMFMapModels.h>
#import "BMFRouteSearchType.h"
#import "BMFPoiSearchType.h"

@implementation BMFGeocodeSearchOption

- (BMKGeoCodeSearchOption *)toBMKGeoCodeSearchOption {
    BMKGeoCodeSearchOption *option = [BMKGeoCodeSearchOption new];
    if (self.address) {
        option.address = self.address;
    }
    if (self.city) {
        option.city = self.city;
    }
    return option;
}

@end


@implementation BMFReverseGeoCodeSearchOption

- (BMKReverseGeoCodeSearchOption *)toBMKReverseGeoCodeSearchOption {
    BMKReverseGeoCodeSearchOption *option = [BMKReverseGeoCodeSearchOption new];
    if (self.location) {
        option.location = [self.location toCLLocationCoordinate2D];
    }
    if (self.radius) {
        option.radius = self.radius;
    }
    if (self.pageNum) {
        option.pageNum = self.pageNum;
    }
    if (self.pageSize) {
        option.pageSize = self.pageSize;
    }
    option.isLatestAdmin = self.isLatestAdmin;
    return option;
}

@end

#pragma mark - RC检索结果类
@implementation BMFGeoCodeSearchResult

+ (instancetype)fromBMKGeoCodeSearchResult:(BMKGeoCodeSearchResult *)result {
    BMFGeoCodeSearchResult *res = [BMFGeoCodeSearchResult new];
    res.location = [BMFCoordinate fromCLLocationCoordinate2D:result.location];
    res.precise = result.precise;
    res.confidence = result.confidence;
    res.level = result.level;
    return res;
}

@end
#pragma mark - RGC检索结果归属区域面信息类

@implementation BMFSearchRGCRegionInfo

+ (instancetype)fromBMKSearchRGCRegionInfo:(BMKSearchRGCRegionInfo *)result {
    BMFSearchRGCRegionInfo *res = [BMFSearchRGCRegionInfo new];
    res.regionDescription = result.regionDescription;
    res.regionName = result.regionName;
    res.regionTag = result.regionTag;
    res.regionUID = result.regionUID;
    return res;
}

@end

#pragma mark - RGC检索结果类
@implementation BMFReverseGeoCodeSearchResult

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"poiList" : @"BMFPoiInfo",
             @"poiRegions" : @"BMFSearchRGCRegionInfo"
    };
}

+ (instancetype)fromBMKReverseGeoCodeSearchResult:(BMKReverseGeoCodeSearchResult *)result {
    BMFReverseGeoCodeSearchResult *res = [BMFReverseGeoCodeSearchResult new];
    res.location = [BMFCoordinate fromCLLocationCoordinate2D:result.location];
    res.address = result.address;
    res.businessCircle = result.businessCircle;
    res.addressDetail = [BMFAddressComponent fromBMKAddressComponent:result.addressDetail];
    res.confidence = result.confidence;
    if (result.poiList && result.poiList.count > 0) {
        NSMutableArray<BMFPoiInfo *> *mut = [NSMutableArray array];
        for (BMKPoiInfo *info in result.poiList) {
            BMFPoiInfo *finfo = [BMFPoiInfo fromBMKPoiInfo:info];
            [mut addObject:finfo];
        }
        res.poiList = [mut copy];
    }
    if (result.poiRegions && result.poiRegions.count > 0) {
        NSMutableArray<BMFSearchRGCRegionInfo *> *mut = [NSMutableArray array];
        for (BMKSearchRGCRegionInfo *info in result.poiRegions) {
            BMFSearchRGCRegionInfo *pInfo = [BMFSearchRGCRegionInfo fromBMKSearchRGCRegionInfo:info];
            [mut addObject:pInfo];
        }
        res.poiRegions = [mut copy];
    }
    res.sematicDescription = result.sematicDescription;
    return res;
}

@end


