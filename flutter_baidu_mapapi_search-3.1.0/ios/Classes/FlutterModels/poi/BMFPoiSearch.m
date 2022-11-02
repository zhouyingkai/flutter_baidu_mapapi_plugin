//
//  BMFPoiSearchOption.m
//  flutter_baidu_mapapi_base
//
//  Created by zhangbaojin on 2020/4/7.
//

#import "BMFPoiSearch.h"
#import <BaiduMapAPI_Search/BMKPoiSearchOption.h>
#import <BaiduMapAPI_Search/BMKPoiSearchResult.h>
#import <flutter_baidu_mapapi_base/BMFMapModels.h>

@implementation BMFPOISearchFilter

- (BMKPOISearchFilter *)toBMKPOISearchFilter {
    BMKPOISearchFilter *filter = [BMKPOISearchFilter new];

    /// POI所属行业类型，设置该字段可提高检索速度和过滤经度
    /// native 1~3 flutter 0~2
    if (self.industryType >= 0) {
        filter.industryType = self.industryType + 1;
    }

    if (self.sortBasis >= 0 &&  self.sortBasis <= 5) {
         filter.sortBasis = self.sortBasis + 1;
    } else if (self.sortBasis > 5 && self.sortBasis <= 11) {
        filter.sortBasis = self.sortBasis + 4;
    } else if (self.sortBasis > 11 && self.sortBasis <= 16) {
        filter.sortBasis = self.sortBasis + 8;
    }
   
    /// 排序规则
    filter.sortRule = self.sortRule;

    /// 是否有团购
    filter.isGroupon = self.isGroupon;

    /// 是否有打折
    filter.isDiscount = self.isDiscount;

    return filter;
}

@end

@implementation BMFPOICitySearchOption

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"tags" : @"NSString"};
}

- (BMKPOICitySearchOption *)toBMKPOICitySearchOption {
    BMKPOICitySearchOption *option = [BMKPOICitySearchOption new];

    /// 检索关键字，必选。举例：天安门
   option.keyword = self.keyword;

    /// 检索分类，与keyword字段组合进行检索，多个分类以","分隔。举例：美食,酒店
    option.tags = [self.tags copy];

    /// 区域名称(市或区的名字，如北京市，海淀区)或区域编码，必选
    option.city = self.city;

    /// 区域数据返回限制，可选，为true时，仅返回city对应区域内数据
    option.isCityLimit = self.isCityLimit;

    /// 检索结果详细程度 默认为BMK_POI_SCOPE_BASIC_INFORMATION
    option.scope = self.scope + 1;

    /// 检索过滤条件。scope字段为BMK_POI_SCOPE_DETAIL_INFORMATION时，filter字段才有效
   option.filter = [self.filter toBMKPOISearchFilter];

    /// 分页页码，默认为0,0代表第一页，1代表第二页，以此类推
    option.pageIndex = self.pageIndex;

    /// 单次召回POI数量，默认为10条记录，最大返回20条。
    option.pageSize = self.pageSize;
    
    return option;
}
@end

@implementation BMFPOINearbySearchOption

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"tags" : @"NSString",
             @"keywords" : @"NSString"
    };
}

- (BMKPOINearbySearchOption *)toBMKPOINearbySearchOption {
    BMKPOINearbySearchOption *option = [BMKPOINearbySearchOption new];
    option.keywords = [self.keywords copy];
    option.tags = [self.tags copy];
    option.location = [self.location toCLLocationCoordinate2D];
    option.radius = self.radius;
    option.isRadiusLimit = self.isRadiusLimit;
    option.scope = self.scope + 1;
    option.filter = [self.filter toBMKPOISearchFilter];
    option.pageIndex = self.pageIndex;
    option.pageSize = self.pageSize;
    return option;
}
@end

@implementation BMFPOIBoundSearchOption

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"tags" : @"NSString",
             @"keywords" : @"NSString"
    };
}

- (BMKPOIBoundSearchOption *)toBMKPOIBoundSearchOption {
    BMKPOIBoundSearchOption *option = [BMKPOIBoundSearchOption new];
    option.keywords = [self.keywords copy];
    option.tags = [self.tags copy];
    option.leftBottom = [self.leftBottom toCLLocationCoordinate2D];
    option.rightTop = [self.rightTop toCLLocationCoordinate2D];
    option.scope = self.scope + 1;
    option.filter = [self.filter toBMKPOISearchFilter];
    option.pageIndex = self.pageIndex;
    option.pageSize = self.pageSize;
    return option;
}

@end

@implementation BMFPOIDetailSearchOption

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"poiUIDs" : @"NSString"};
}

- (BMKPOIDetailSearchOption *)toBMKPOIDetailSearchOption {
    BMKPOIDetailSearchOption *option = [BMKPOIDetailSearchOption new];
    /// POI的唯一标识符集合，必选 注：从POI检索的返回结果BMFPoiInfo里获取。
    option.poiUIDs = [self.poiUIDs copy];

    /// 检索结果详细程度
   option.scope = self.scope + 1;
    
    return option;
}

@end


@implementation BMFPOIIndoorSearchOption

- (BMKPOIIndoorSearchOption *)toBMKPOIIndoorSearchOption {
    BMKPOIIndoorSearchOption *option = [BMKPOIIndoorSearchOption new];
    /// 室内检索唯一标识符，必选 注：从进入/移出室内图的回调方法中获取。
    option.indoorID = self.indoorID;
    /// 室内检索关键字，必选
    option.keyword = self.keyword;
    option.floor = self.floor;
    option.pageIndex = self.pageIndex;
    option.pageSize = self.pageSize;
    return option;
}

@end


#pragma mark - result

@implementation BMFPoiSearchResult

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"poiInfoList" : @"BMFPoiInfo"};
}

+ (instancetype)fromBMKPoiSearchResult:(BMKPOISearchResult *)result {
    BMFPoiSearchResult *res = [BMFPoiSearchResult new];
    res.totalPOINum = result.totalPOINum;

    /// 符合条件的检索结果总页数
    res.totalPageNum = result.totalPageNum;

    /// 当前页的结果个数
    res.curPOINum = result.curPOINum;

    /// 当前页的页数索引
    res.curPageIndex = result.curPageIndex;

    /// POI列表，成员是BMFPoiInfo
    if (result.poiInfoList && result.poiInfoList.count > 0) {
        NSMutableArray <BMFPoiInfo *> * mut = [NSMutableArray array];
        for (BMKPoiInfo *info in result.poiInfoList) {
            BMFPoiInfo *fInfo = [BMFPoiInfo fromBMKPoiInfo:info];
            [mut addObject:fInfo];
        }
        res.poiInfoList = [mut copy];
    }
    
    return res;
}

@end


@implementation BMFPOIDetailSearchResult

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"poiInfoList" : @"BMFPoiInfo"};
}

+ (instancetype)fromBMKPOIDetailSearchResult:(BMKPOIDetailSearchResult *)result {
    BMFPOIDetailSearchResult *res = [BMFPOIDetailSearchResult new];
    /// 符合条件的检索结果总个数
    res.totalPOINum = result.totalPOINum;

    /// POI列表，成员是BMFPoiInfo
    if (result.poiInfoList && result.poiInfoList.count > 0) {
        NSMutableArray <BMFPoiInfo *> *mut = [NSMutableArray array];
        for (BMKPoiInfo *info in result.poiInfoList) {
            BMFPoiInfo *fInfo = [BMFPoiInfo fromBMKPoiInfo:info];
            [mut addObject:fInfo];
        }
        res.poiInfoList = [mut copy];
    }
    return res;
}

@end


@implementation BMFPOIIndoorSearchResult

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"poiIndoorInfoList" : @"BMFPoiIndoorInfo"};
}

+ (instancetype)fromBMKPOIIndoorSearchResult:(BMKPOIIndoorSearchResult *)result {
    BMFPOIIndoorSearchResult *res = [BMFPOIIndoorSearchResult new];
    /// 符合条件的检索结果总个数
   res.totalPOINum = result.totalPOINum;

    /// 符合条件的检索结果总页数
    res.totalPageNum = result.totalPageNum;

    /// 当前页的结果个数
    res.curPOINum = result.curPOINum;

    /// 当前页的页数索引
    res.curPageIndex = result.curPageIndex;

    /// 室内POI列表，成员是BMFPoiIndoorInfo
    if (result.poiIndoorInfoList && result.poiIndoorInfoList.count > 0) {
        NSMutableArray <BMFPoiIndoorInfo *> *mut = [NSMutableArray array];
        for (BMKPoiIndoorInfo *info in result.poiIndoorInfoList) {
            BMFPoiIndoorInfo *fInfo = [BMFPoiIndoorInfo fromBMKPoiIndoorInfo:info];
            [mut addObject:fInfo];
        }
        res.poiIndoorInfoList = [mut copy];
    }
   
    
    return res;
}

@end

