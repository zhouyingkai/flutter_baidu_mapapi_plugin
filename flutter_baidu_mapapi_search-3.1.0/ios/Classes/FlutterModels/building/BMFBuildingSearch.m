//
//  BMFBuildingSearch.m
//  flutter_baidu_mapapi_search
//
//  Created by zhangbaojin on 2022/1/6.
//

#import "BMFBuildingSearch.h"
#import <BaiduMapAPI_Search/BMKBuildingSearchOption.h>
#import <BaiduMapAPI_Search/BMKBuildingSearchResult.h>
#import <flutter_baidu_mapapi_base/BMFMapModels.h>

@implementation BMFBuildingSearchOption

- (BMKBuildingSearchOption *)toBMKBuildingSearchOption {
    BMKBuildingSearchOption *option = [BMKBuildingSearchOption new];
    if (self.location) {
        option.location = [self.location toCLLocationCoordinate2D];
    }
    return option;
}

@end


@implementation BMFBuildingSearchResult

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"buildingList" : @"BMFBuildInfo"};
}

+ (instancetype)fromBMKBuildingSearchResult:(BMKBuildingSearchResult *)result {
    BMFBuildingSearchResult *res = [BMFBuildingSearchResult new];
    if (result.buildingList && result.buildingList.count > 0) {
        NSMutableArray<BMFBuildInfo *> *mut = [NSMutableArray array];
        for (BMKBuildInfo *info in result.buildingList) {
            [mut addObject:[BMFBuildInfo fromBMKBuildInfo:info]];
        }
        res.buildingList = [mut copy];
    }
    return res;
}

@end
