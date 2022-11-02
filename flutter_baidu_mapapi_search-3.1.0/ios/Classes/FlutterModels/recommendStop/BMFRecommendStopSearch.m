//
//  BMFRecommendStopSearch.m
//  flutter_baidu_mapapi_search
//
//  Created by Zhang,Baojin on 2020/11/12.
//

#import "BMFRecommendStopSearch.h"
#import <BaiduMapAPI_Search/BMKRecommendStopSearchOption.h>
#import <BaiduMapAPI_Search/BMKRecommendStopSearchResult.h>
#import <flutter_baidu_mapapi_base/BMFMapModels.h>


@implementation BMFRecommendStopSearchOption

- (BMKRecommendStopSearchOption *)toBMKRecommendStopSearchOption {
    BMKRecommendStopSearchOption *option = [BMKRecommendStopSearchOption new];
    if (self.location) {
        option.location = [self.location toCLLocationCoordinate2D];
    }
    return option;
}

@end


@implementation BMFRecommendStopInfo

+ (instancetype)fromBMKRecommendStopInfo:(BMKRecommendStopInfo *)result {
    BMFRecommendStopInfo *res = [BMFRecommendStopInfo new];
    /// 推荐上车点名称
    if (result.name) {
        res.name = result.name;
    }
    /// 推荐上车点地址
    if (result.address) {
        res.address = result.address;
    }
    /// 推荐上车点经纬度
    res.location = [BMFCoordinate fromCLLocationCoordinate2D:result.location];
    /// 推荐点poi的uid
    if (result.uid) {
        res.uid = result.uid;
    }
    /// 距查找点的距离，单位米
    res.distance = result.distance;
    
    return res;
}

@end


@implementation BMFRecommendStopSearchResult

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"recommendStopInfoList" : @"BMFRecommendStopInfo"};
}

+ (instancetype)fromBMKRecommendStopSearchResult:(BMKRecommendStopSearchResult *)result {
    BMFRecommendStopSearchResult *res = [BMFRecommendStopSearchResult new];
    
    if (result.recommendStopInfoList && result.recommendStopInfoList.count > 0) {
        NSMutableArray<BMFRecommendStopInfo *> *mut = [NSMutableArray array];
        for (BMKRecommendStopInfo *info in result.recommendStopInfoList) {
            [mut addObject:[BMFRecommendStopInfo fromBMKRecommendStopInfo:info]];
        }
        res.recommendStopInfoList = [mut copy];
    }
    
    return res;
}

@end
