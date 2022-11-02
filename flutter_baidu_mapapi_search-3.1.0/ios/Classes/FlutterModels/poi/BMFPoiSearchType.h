//
//  BMFPoiSearchType.h
//  flutter_baidu_mapapi_base
//
//  Created by zhangbaojin on 2020/4/7.
//

#import <flutter_baidu_mapapi_base/BMFModel.h>

@class BMFCoordinate;
@class BMFPOIDetailInfo;

@class BMKPOIDetailChildrenInfo;
@class BMKPoiInfo;
@class BMKPOIDetailInfo;
@class BMKPoiIndoorInfo;


NS_ASSUME_NONNULL_BEGIN

#pragma mark - POI详情子节点信息类，需要权限（使用带有此权限的AK）
@interface BMFPOIDetailChildrenInfo : BMFModel

/// poi子点uid
@property (nonatomic, copy) NSString *uid;

/// poi子点名称
@property (nonatomic, copy) NSString *name;

/// poi子点简称
@property (nonatomic, copy) NSString *showName;

/// poi子点类别
@property (nonatomic, copy) NSString *tag;

/// poi子节点经纬度
@property (nonatomic, strong) BMFCoordinate *pt;

/// poi子点地址
@property (nonatomic, copy) NSString *address;

+ (instancetype)fromBMKPOIDetailChildrenInfo:(BMKPOIDetailChildrenInfo *)result;

@end

#pragma mark - POI信息类
/// POI信息类
@interface BMFPoiInfo : BMFModel

/// POI名称
@property (nonatomic, copy) NSString *name;

/// POI坐标
@property (nonatomic, strong) BMFCoordinate *pt;

/// POI地址信息
@property (nonatomic, copy) NSString *address;

/// POI电话号码
@property (nonatomic, copy) NSString *phone;

/// POI唯一标识符uid
@property (nonatomic, copy) NSString *uid;

/// POI所在省份
@property (nonatomic, copy) NSString *province;

/// POI所在城市
@property (nonatomic, copy) NSString *city;

/// POI所在行政区域
@property (nonatomic, copy) NSString *area;

/// POI对应的街景图ID
@property (nonatomic, copy) NSString *streetID;

/// POI类别  注：逆地理编码检索会返回此值，其他检索可能返回为空，请参考detailInfo中的tag值。
@property (nonatomic, copy) NSString *tag;

/// POI是否有详情信息
@property (nonatomic, assign) BOOL hasDetailInfo;

/// POI详情信息
@property (nonatomic, strong) BMFPOIDetailInfo *detailInfo;

/// 和当前坐标点的方向，注：此字段只对逆地理检索有效
@property (nonatomic, copy) NSString *direction;

/// 距离坐标点距离，注：此字段只对逆地理检索有效
@property (nonatomic, assign) NSInteger distance;

/// 邮编，注：此字段只对逆地理检索有效
@property (nonatomic, copy) NSString *zipCode;

/// 该POI对应的父POI，注：此字段只对逆地理检索有效
@property (nonatomic, strong) BMFPoiInfo *parentPOI;

+ (instancetype)fromBMKPoiInfo:(BMKPoiInfo *)result;

@end

#pragma mark - POI详情信息类
@interface BMFPOIDetailInfo : BMFModel

/// 距离中心点的距离，圆形区域检索时返回
@property (nonatomic, assign) NSInteger distance;

/// POI类型："hotel","cater","life"等
@property (nonatomic, copy) NSString *type;

/// POI标签
@property (nonatomic, copy) NSString *tag;

/// POI对应的导航引导点坐标。大型面状POI的导航引导点，一般为各类出入口，方便结合导航、路线规划等服务使用
@property (nonatomic, strong) BMFCoordinate *naviLocation;

/// POI详情页URL
@property (nonatomic, copy) NSString *detailURL;

/// POI商户的价格
@property (nonatomic, assign) CGFloat price;

/// POI营业时间
@property (nonatomic, copy) NSString *openingHours;

/// POI总体评分
@property (nonatomic, assign) CGFloat overallRating;
/// POI口味评分
@property (nonatomic, assign) CGFloat tasteRating;

/// POI服务评分
@property (nonatomic, assign) CGFloat serviceRating;

/// POI环境评分
@property (nonatomic, assign) CGFloat environmentRating;

/// POI星级（设备）评分
@property (nonatomic, assign) CGFloat facilityRating;

/// POI卫生评分
@property (nonatomic, assign) CGFloat hygieneRating;

/// POI技术评分
@property (nonatomic, assign) CGFloat technologyRating;

/// POI图片数目
@property (nonatomic, assign) NSInteger imageNumber;

/// POI团购数目
@property (nonatomic, assign) NSInteger grouponNumber;

/// POI优惠数目
@property (nonatomic, assign) NSInteger discountNumber;

/// POI评论数目
@property (nonatomic, assign) NSInteger commentNumber;

/// POI收藏数目
@property (nonatomic, assign) NSInteger favoriteNumber;

/// POI签到数目
@property (nonatomic, assign) NSInteger checkInNumber;

/// POI详情子节点信息，默认不返回，需要权限。
@property (nonatomic, copy) NSArray <BMFPOIDetailChildrenInfo *> *children;

+ (instancetype)fromBMKPOIDetailInfo:(BMKPOIDetailInfo *)result;

@end

#pragma mark - 室内POI信息类
/// 室内POI信息类
@interface BMFPoiIndoorInfo : BMFModel

/// POI名称
@property (nonatomic, copy) NSString *name;

/// POI唯一标识符
@property (nonatomic, copy) NSString *uid;

/// 该室内POI所在 室内ID
@property (nonatomic, copy) NSString *indoorID;

/// 该室内POI所在楼层
@property (nonatomic, copy) NSString *floor;

/// POI地址
@property (nonatomic, copy) NSString *address;

/// POI所在城市
@property (nonatomic, copy) NSString *city;

/// POI电话号码
@property (nonatomic, copy) NSString *phone;

/// POI坐标
@property (nonatomic, strong) BMFCoordinate *pt;

/// POI标签
@property (nonatomic, copy) NSString *tag;

/// 价格
@property (nonatomic, assign) CGFloat price;

/// 星级（0-50），50表示五星
@property (nonatomic, assign) NSInteger starLevel;

/// 是否有团购
@property (nonatomic, assign) BOOL grouponFlag;

/// 是否有外卖
@property (nonatomic, assign) BOOL takeoutFlag;

/// 是否排队
@property (nonatomic, assign) BOOL waitedFlag;

/// 团购数,-1表示没有团购信息
@property (nonatomic, assign) NSInteger grouponNum;

/// 折扣信息FIXME
@property (nonatomic, assign) NSInteger discount;

+ (instancetype)fromBMKPoiIndoorInfo:(BMKPoiIndoorInfo *)result;

@end

NS_ASSUME_NONNULL_END
