//
//  BMFPoiSearchOption.h
//  flutter_baidu_mapapi_base
//
//  Created by zhangbaojin on 2020/4/7.
//

#import <flutter_baidu_mapapi_base/BMFModel.h>
#import "BMFPoiSearchType.h"

@class BMFCoordinate;
@class BMKPOISearchFilter;
@class BMKPOICitySearchOption;
@class BMKPOINearbySearchOption;
@class BMKPOIBoundSearchOption;
@class BMKPOIDetailSearchOption;
@class BMKPOIIndoorSearchOption;

@class BMKPOISearchResult;
@class BMKPOIDetailSearchResult;
@class BMKPOIIndoorSearchResult;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - POI检索过滤条件类
@interface BMFPOISearchFilter : BMFModel

/// POI所属行业类型，设置该字段可提高检索速度和过滤经度
@property (nonatomic, assign) NSUInteger industryType;

/**
 排序依据，根据industryType字段指定的行业类型不同，此字段应设置为对应行业的依据值
 比如industryType字段的值为BMK_POI_INDUSTRY_TYPE_CATER，则此字段应选择BMK_POI_SORT_BASIS_TYPE_CATER_XXX对应的枚举值
 */
@property (nonatomic, assign) NSUInteger sortBasis;

/// 排序规则
@property (nonatomic, assign) NSUInteger sortRule;

/// 是否有团购
@property (nonatomic, assign) BOOL isGroupon;

/// 是否有打折
@property (nonatomic, assign) BOOL isDiscount;

- (BMKPOISearchFilter *)toBMKPOISearchFilter;

@end

#pragma mark - POI城市检索参数信息类
/// POI城市检索参数信息类
@interface BMFPOICitySearchOption : BMFModel

/// 检索关键字，必选。举例：天安门
@property (nonatomic, copy) NSString *keyword;

/// 检索分类，与keyword字段组合进行检索，多个分类以","分隔。举例：美食,酒店
@property (nonatomic, copy) NSArray<NSString *> *tags;

/// 区域名称(市或区的名字，如北京市，海淀区)或区域编码，必选
@property (nonatomic, copy) NSString *city;

/// 区域数据返回限制，可选，为true时，仅返回city对应区域内数据
@property (nonatomic, assign) BOOL isCityLimit;

//// 检索结果详细程度 默认为BMK_POI_SCOPE_BASIC_INFORMATION
@property (nonatomic, assign) NSUInteger scope;

/// 检索过滤条件。scope字段为BMK_POI_SCOPE_DETAIL_INFORMATION时，filter字段才有效
@property (nonatomic, strong) BMFPOISearchFilter *filter;

/// 分页页码，默认为0,0代表第一页，1代表第二页，以此类推
@property (nonatomic, assign) NSInteger pageIndex;

/// 单次召回POI数量，默认为10条记录，最大返回20条。
@property (nonatomic, assign) NSInteger pageSize;

- (BMKPOICitySearchOption *)toBMKPOICitySearchOption;

@end

#pragma mark - POI周边检索参数信息类
/// POI周边检索参数信息类
@interface BMFPOINearbySearchOption : BMFModel

/**
 检索关键字，必选。
 在周边检索中关键字为数组类型，可以支持多个关键字并集检索，如银行和酒店。每个关键字对应数组一个元素。
 最多支持10个关键字。
 */
@property (nonatomic, copy) NSArray<NSString *> *keywords;

/**
 检索分类，可选。
 该字段与keywords字段组合进行检索。
 支持多个分类，如美食和酒店。每个分类对应数组中一个元素
 */
@property (nonatomic, copy) NSArray<NSString *> *tags;

/// 检索中心点的经纬度，必选
@property (nonatomic, strong) BMFCoordinate *location;

/**
 检索半径，可选，单位是米。
 当半径过大，超过中心点所在城市边界时，会变为城市范围检索，检索范围为中心点所在城市
 */
@property (nonatomic, assign) NSInteger radius;

/**
 是否严格限定召回结果在设置检索半径范围内。默认值为false。
 值为true代表检索结果严格限定在半径范围内；值为false时不严格限定。
 注意：值为true时会影响返回结果中total准确性及每页召回poi数量，我们会逐步解决此类问题。
 */
@property (nonatomic, assign) BOOL isRadiusLimit;

/// 检索结果详细程度 默认为BMK_POI_SCOPE_BASIC_INFORMATION
@property (nonatomic, assign) NSUInteger scope;

/// 检索过滤条件。scope字段为BMK_POI_SCOPE_DETAIL_INFORMATION时，filter字段才有效
@property (nonatomic, strong) BMFPOISearchFilter *filter;

/// 分页页码，默认为0,0代表第一页，1代表第二页，以此类推
@property (nonatomic, assign) NSInteger pageIndex;

/// 单次召回POI数量，默认为10条记录，最大返回20条。
@property (nonatomic, assign) NSInteger pageSize;

- (BMKPOINearbySearchOption *)toBMKPOINearbySearchOption;

@end

#pragma mark - POI矩形区域检索参数信息类
/// POI矩形区域检索参数信息类
@interface BMFPOIBoundSearchOption : BMFModel

/**
 检索关键字，必选。
 在矩形检索中关键字为数组类型，可以支持多个关键字并集检索，如银行和酒店。每个关键字对应数组一个元素。
 最多支持10个关键字。
 */
@property (nonatomic, copy) NSArray<NSString *> *keywords;

/**
 检索分类，可选。
 该字段与keywords字段组合进行检索。
 支持多个分类，如美食和酒店。每个分类对应数组中一个元素
 */
@property (nonatomic, copy) NSArray<NSString *> *tags;

/// 矩形检索区域的左下角经纬度坐标，必选
@property (nonatomic, strong) BMFCoordinate *leftBottom;

/// 矩形检索区域的右上角经纬度坐标，必选
@property (nonatomic, strong) BMFCoordinate *rightTop;

/// 检索结果详细程度 默认为BMK_POI_SCOPE_BASIC_INFORMATION
@property (nonatomic, assign) NSUInteger scope;

/// 检索过滤条件。scope字段为BMK_POI_SCOPE_DETAIL_INFORMATION时，filter字段才有效
@property (nonatomic, strong) BMFPOISearchFilter *filter;

/// 分页页码，默认为0,0代表第一页，1代表第二页，以此类推
@property (nonatomic, assign) NSInteger pageIndex;

/// 单次召回POI数量，默认为10条记录，最大返回20条。
@property (nonatomic, assign) NSInteger pageSize;

- (BMKPOIBoundSearchOption *)toBMKPOIBoundSearchOption;
@end

#pragma mark - POI详情检索参数信息类
/// POI详情检索信息类
@interface BMFPOIDetailSearchOption : BMFModel

/// POI的唯一标识符集合，必选 注：从POI检索的返回结果BMFPoiInfo里获取。
@property (nonatomic, copy) NSArray<NSString *> *poiUIDs;

/// 检索结果详细程度
@property (nonatomic, assign) NSUInteger scope;

- (BMKPOIDetailSearchOption *)toBMKPOIDetailSearchOption;

@end

#pragma mark - POI室内检索参数信息类
/// 室内POI检索参数信息类
@interface BMFPOIIndoorSearchOption : BMFModel

/// 室内检索唯一标识符，必选 注：从进入/移出室内图的回调方法中获取。
@property (nonatomic, copy) NSString *indoorID;

/// 室内检索关键字，必选
@property (nonatomic, copy) NSString *keyword;

/// 楼层（可选），设置后，会优先获取该楼层的室内POI，然后是其它楼层的。如“F3”,"B3"等。
@property (nonatomic, copy) NSString *floor;

/// 分页页码，默认为0,0代表第一页，1代表第二页，以此类推
@property (nonatomic, assign) NSInteger pageIndex;

/// 单次召回POI数量，默认为10条记录，最大返回20条。
@property (nonatomic, assign) NSInteger pageSize;

- (BMKPOIIndoorSearchOption *)toBMKPOIIndoorSearchOption;

@end


#pragma mark - POI搜索结果类
/// POI检索结果类，城市检索、周边检索、矩形区域检索服务都使用此结果类。
@interface BMFPoiSearchResult : BMFModel

/**
 关于以下4个字段的解释：
 假如检索请求中 pageSize=10 且 pageIndex=2，即开发者期望检索结果每页10条，取第2页的结果。
 如果符合条件的检索结果总数为25条，检索结果总页数就是3，当前页结果个数为5，当前页的索引为3；
 如果符合条件的检索结果总数为8条，此时没有符合条件的检索结果。本对象为nil
 */
/// 符合条件的检索结果总个数
@property (nonatomic, assign) NSInteger totalPOINum;

/// 符合条件的检索结果总页数
@property (nonatomic, assign) NSInteger totalPageNum;

/// 当前页的结果个数
@property (nonatomic, assign) NSInteger curPOINum;

/// 当前页的页数索引
@property (nonatomic, assign) NSInteger curPageIndex;

/// POI列表，成员是BMFPoiInfo
@property (nonatomic, copy) NSArray<BMFPoiInfo *> *poiInfoList;

+ (instancetype)fromBMKPoiSearchResult:(BMKPOISearchResult *)result;

@end


#pragma mark - POI详情检索结果类
/// POI详情检索结果类
@interface BMFPOIDetailSearchResult : BMFModel

/// 符合条件的检索结果总个数
@property (nonatomic, assign) NSInteger totalPOINum;

/// POI列表，成员是BMFPoiInfo
@property (nonatomic, copy) NSArray<BMFPoiInfo *> *poiInfoList;

+ (instancetype)fromBMKPOIDetailSearchResult:(BMKPOIDetailSearchResult *)result;

@end


#pragma mark - POI室内搜索结果类
/// POI室内搜索结果类
@interface BMFPOIIndoorSearchResult : BMFModel

/// 符合条件的检索结果总个数
@property (nonatomic, assign) NSInteger totalPOINum;

/// 符合条件的检索结果总页数
@property (nonatomic, assign) NSInteger totalPageNum;

/// 当前页的结果个数
@property (nonatomic, assign) NSInteger curPOINum;

/// 当前页的页数索引
@property (nonatomic, assign) NSInteger curPageIndex;

/// 室内POI列表，成员是BMFPoiIndoorInfo
@property (nonatomic, copy) NSArray<BMFPoiIndoorInfo *> *poiIndoorInfoList;

+ (instancetype)fromBMKPOIIndoorSearchResult:(BMKPOIIndoorSearchResult *)result;

@end


NS_ASSUME_NONNULL_END
