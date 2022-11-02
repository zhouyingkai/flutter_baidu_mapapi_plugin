//
//  BMFGeocodeSearchOption.h
//  flutter_baidu_mapapi_base
//
//  Created by zhangbaojin on 2020/4/7.
//

#import <flutter_baidu_mapapi_base/BMFModel.h>

@class BMFCoordinate;
@class BMKGeoCodeSearchOption;
@class BMKReverseGeoCodeSearchOption;

@class BMKGeoCodeSearchResult;
@class BMFAddressComponent;
@class BMFPoiInfo;
@class BMFSearchRGCRegionInfo;

@class BMKSearchRGCRegionInfo;
@class BMKReverseGeoCodeSearchResult;

NS_ASSUME_NONNULL_BEGIN
#pragma mark - GC请求参数类
/// 正地理编码参数信息类
@interface BMFGeocodeSearchOption : BMFModel
/**
 待解析的地址。必选。
 可以输入2种样式的值，分别是：
 1、标准的结构化地址信息，如北京市海淀区上地十街十号 【推荐，地址结构越完整，解析精度越高】
 2、支持“*路与*路交叉口”描述方式，如北一环路和阜阳路的交叉路口
 注意：第二种方式并不总是有返回结果，只有当地址库中存在该地址描述时才有返回。
 */
@property (nonatomic, copy) NSString *address;

/**
 地址所在的城市名。可选。
 用于指定上述地址所在的城市，当多个城市都有上述地址时，该参数起到过滤作用。
 注意：指定该字段，不会限制坐标召回城市。
 */
@property (nonatomic, copy) NSString *city;

- (BMKGeoCodeSearchOption *)toBMKGeoCodeSearchOption;

@end

#pragma mark - RGC请求参数类
/// 反地理编码参数信息类
@interface BMFReverseGeoCodeSearchOption : BMFModel

/// 待解析的经纬度坐标（必选）
@property (nonatomic, strong) BMFCoordinate *location;

/// 是否访问最新版行政区划数据（仅对中国数据生效）
@property (nonatomic, assign) BOOL isLatestAdmin;

/// 设置POI召回半径，允许设置区间为0-1000米，超过1000米按1000米召回，默认为1000米
@property (nonatomic, assign) int radius;

/// 设置每页容量，允许设置区间为0-100，默认为10条
@property (nonatomic, assign) int pageSize;

/// 分页编号
@property (nonatomic, assign) int pageNum;

- (BMKReverseGeoCodeSearchOption *)toBMKReverseGeoCodeSearchOption;

@end

#pragma mark - RC检索结果类
/// 地址编码结果类
@interface BMFGeoCodeSearchResult : BMFModel

/// 地址对应的经纬度坐标
@property (nonatomic, strong) BMFCoordinate *location;

/// 是否是精准查找，1为精确查找，即准确打点，0为不精确，即模糊打点
@property (nonatomic, assign) NSInteger precise;

/**
 可信度，值范围0-100，数值越大，可信度越高，误差范围越小
 大于80误差小于100m，该字段仅作参考，返回结果准确度主要参考precise参数
 */
@property (nonatomic, assign) NSInteger confidence;

/// 地址类型，包含：UNKNOWN、国家、省、商圈、生活服务等等
@property (nonatomic, copy) NSString *level;

+ (instancetype)fromBMKGeoCodeSearchResult:(BMKGeoCodeSearchResult *)result;

@end

#pragma mark - RGC检索结果归属区域面信息类
@interface BMFSearchRGCRegionInfo : BMFModel
/// 请求坐标与所归属区域面的相对位置关系
@property (nonatomic, copy) NSString *regionDescription;
/// 归属区域面名称
@property (nonatomic, copy) NSString *regionName;
/// 归属区域面类型
@property (nonatomic, copy) NSString *regionTag;
/// 归属区域面唯一标识
@property (nonatomic, copy) NSString *regionUID;

+ (instancetype)fromBMKSearchRGCRegionInfo:(BMKSearchRGCRegionInfo *)result;

@end

#pragma mark - RGC检索结果类
/// 反地理编码结果类
@interface BMFReverseGeoCodeSearchResult : BMFModel

/// 地址坐标
@property (nonatomic, strong) BMFCoordinate *location;

/// 地址名称
@property (nonatomic, copy) NSString *address;

/// 商圈名称
@property (nonatomic, copy) NSString *businessCircle;

/// 层次化地址信息
@property (nonatomic, strong) BMFAddressComponent *addressDetail;

/**
 可信度，值范围0-100，数值越大，可信度越高，误差范围越小
 大于80误差小于100m，该字段仅作参考，返回结果准确度主要参考precise参数
 */
@property (nonatomic, assign) NSInteger confidence;

/// 地址周边POI信息，成员类型为BMKPoiInfo
@property (nonatomic, copy) NSArray <BMFPoiInfo *> *poiList;

/// 地址所属区域面信息
@property (nonatomic, copy) NSArray <BMFSearchRGCRegionInfo *> *poiRegions;

/// 结合当前位置POI的语义化结果描述
@property (nonatomic, copy) NSString *sematicDescription;

+ (instancetype)fromBMKReverseGeoCodeSearchResult:(BMKReverseGeoCodeSearchResult *)result;

@end

NS_ASSUME_NONNULL_END
