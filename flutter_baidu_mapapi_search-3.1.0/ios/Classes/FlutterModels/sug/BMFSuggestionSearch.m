//
//  BMFSuggestionSearch.m
//  flutter_baidu_mapapi_base
//
//  Created by zhangbaojin on 2020/4/15.
//

#import "BMFSuggestionSearch.h"
#import <BaiduMapAPI_Search/BMKSuggestionSearchOption.h>
#import <BaiduMapAPI_Search/BMKSuggestionSearchResult.h>
#import <flutter_baidu_mapapi_base/BMFMapModels.h>

@implementation BMFSuggestionSearchOption 

- (BMKSuggestionSearchOption *)toBMKSuggestionSearchOption {
    BMKSuggestionSearchOption *option = [BMKSuggestionSearchOption new];
    if (self.cityname) {
        option.cityname = self.cityname;
    }
    if (self.keyword) {
        option.keyword = self.keyword;
    }
    if (self.location) {
        option.location = [self.location toCLLocationCoordinate2D];
    }
    option.cityLimit = self.cityLimit;
    return option;
}
@end

#pragma mark - Sug检索子节点结果类
@implementation BMFSuggestionChildrenInfo

+ (instancetype)fromBMKSuggestionChildrenInfo:(BMKSuggestionChildrenInfo *)result {
    BMFSuggestionChildrenInfo *res = [BMFSuggestionChildrenInfo new];
    if (result.name) {
        res.name = result.name;
    }
    if (result.showName) {
        res.showName = result.showName;
    }
    if (result.uid) {
        res.uid = result.uid;
    }
    return res;
}

@end

#pragma mark - Sug检索结果类
@implementation BMFSuggestionInfo

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"children" : @"BMFSuggestionChildrenInfo"};
}

+ (instancetype)fromBMKSuggestionInfo:(BMKSuggestionInfo *)result {
    BMFSuggestionInfo *res = [BMFSuggestionInfo new];
    /// 联想词联想词名称
    res.key = result.key;
    /// 联想结果经纬度坐标
    res.location = [BMFCoordinate fromCLLocationCoordinate2D:result.location];
    /// 联想结果唯一标示，ID
    res.uid = result.uid;
    /// 联想结果所在城市
    res.city = result.city;
    /// 联想结果所在区县
    res.district = result.district;
    /// 联想结果分类，默认不召回，需要权限。
    if (result.tag) {
        res.tag = result.tag;
    }
    /// 联想结果地址，默认不召回，需要权限。
    if (result.address) {
        res.address = result.address;
    }
    /// 联想结果子节点，默认不召回，需要权限。
    if (result.children && result.children.count > 0) {
        NSMutableArray<BMFSuggestionChildrenInfo *> *mut = [NSMutableArray array];
        for (BMKSuggestionChildrenInfo *info in result.children) {
            BMFSuggestionChildrenInfo *cInfo = [BMFSuggestionChildrenInfo fromBMKSuggestionChildrenInfo:info];
            [mut addObject:cInfo];
        }
        res.children = [mut copy];
    }
    return res;
}

@end

@implementation BMFSuggestionSearchResult

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"suggestionList" : @"BMFSuggestionInfo"};
}

+ (instancetype)fromBMKSuggestionSearchResult:(BMKSuggestionSearchResult *)result {
    BMFSuggestionSearchResult *res = [BMFSuggestionSearchResult new];
    if (result.suggestionList && result.suggestionList.count > 0) {
        NSMutableArray<BMFSuggestionInfo *> *mut = [NSMutableArray array];
        for (BMKSuggestionInfo *info in result.suggestionList) {
            BMFSuggestionInfo *fInfo = [BMFSuggestionInfo fromBMKSuggestionInfo:info];
            [mut addObject:fInfo];
        }
        res.suggestionList = [mut copy];
    }
    return res;
}

@end
