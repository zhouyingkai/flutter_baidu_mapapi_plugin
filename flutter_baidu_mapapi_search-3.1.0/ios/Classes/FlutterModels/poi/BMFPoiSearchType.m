//
//  BMFPoiSearchType.m
//  flutter_baidu_mapapi_base
//
//  Created by zhangbaojin on 2020/4/7.
//

#import "BMFPoiSearchType.h"
#import <BaiduMapAPI_Search/BMKPoiSearchType.h>
#import <flutter_baidu_mapapi_base/BMFMapModels.h>


@implementation BMFPOIDetailChildrenInfo

+ (instancetype)fromBMKPOIDetailChildrenInfo:(BMKPOIDetailChildrenInfo *)result {
    BMFPOIDetailChildrenInfo *res = [BMFPOIDetailChildrenInfo new];

    /// poi子点uid
    res.uid = result.uid;

    /// poi子点名称
    res.name = result.name;

    /// poi子点简称
    res.showName = result.showName;

    /// poi子点类别
    res.tag = result.tag;

    /// poi子节点经纬度
    res.pt = [BMFCoordinate fromCLLocationCoordinate2D:result.pt];

    /// poi子点地址
    res.address = result.address;
    
    return res;
}

@end


@implementation BMFPoiInfo

+ (instancetype)fromBMKPoiInfo:(BMKPoiInfo *)result {
    BMFPoiInfo *res = [BMFPoiInfo new];

    /// POI名称
    res.name = result.name;

    /// POI坐标
    res.pt = [BMFCoordinate fromCLLocationCoordinate2D:result.pt];

    /// POI地址信息
    res.address = result.address;

    /// POI电话号码
    res.phone = result.phone;

    /// POI唯一标识符uid
    res.uid = result.UID;

    /// POI所在省份
    res.province = result.province;

    /// POI所在城市
    res.city = result.city;

    /// POI所在行政区域
    res.area = result.area;

    /// POI对应的街景图ID
    res.streetID = result.streetID;

    /// POI类别  注：逆地理编码检索会返回此值，其他检索可能返回为空，请参考detailInfo中的tag值。
    res.tag = result.tag;

    /// POI是否有详情信息
    res.hasDetailInfo = result.hasDetailInfo;

    /// POI详情信息
    res.detailInfo = [BMFPOIDetailInfo fromBMKPOIDetailInfo:result.detailInfo];

    /// 和当前坐标点的方向，注：此字段只对逆地理检索有效
    res.direction = result.direction;

    /// 距离坐标点距离，注：此字段只对逆地理检索有效
    res.distance = result.distance;

    /// 邮编，注：此字段只对逆地理检索有效
    res.zipCode = result.zipCode;
     /// 该POI对应的父POI，注：此字段只对逆地理检索有效
    if (result.parentPOI) {
        res.parentPOI = [BMFPoiInfo fromBMKPoiInfo:result.parentPOI];
    }
   
    return res;
}

@end



@implementation BMFPOIDetailInfo

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"children" : @"BMFPOIDetailChildrenInfo"};
}

+ (instancetype)fromBMKPOIDetailInfo:(BMKPOIDetailInfo *)result {
    BMFPOIDetailInfo *res = [BMFPOIDetailInfo new];

    /// 距离中心点的距离，圆形区域检索时返回
    res.distance = result.distance;

    /// POI类型："hotel","cater","life"等
    res.type = result.type;

    /// POI标签
    res.tag = result.tag;

    /// POI对应的导航引导点坐标。大型面状POI的导航引导点，一般为各类出入口，方便结合导航、路线规划等服务使用
    res.naviLocation = [BMFCoordinate fromCLLocationCoordinate2D:result.naviLocation];

    /// POI详情页URL
    res.detailURL = result.detailURL;

    /// POI商户的价格
    res.price = result.price;

    /// POI营业时间
    res.openingHours = result.openingHours;

    /// POI总体评分
    res.overallRating = result.overallRating;
    /// POI口味评分
    res.tasteRating = result.tasteRating;

    /// POI服务评分
    res.serviceRating = result.serviceRating;

    /// POI环境评分
    res.environmentRating = result.environmentRating;

    /// POI星级（设备）评分
    res.facilityRating = result.facilityRating;

    /// POI卫生评分
    res.hygieneRating = result.hygieneRating;

    /// POI技术评分
    res.technologyRating = result.technologyRating;

    /// POI图片数目
    res.imageNumber = result.imageNumber;

    /// POI团购数目
    res.grouponNumber = result.grouponNumber;

    /// POI优惠数目
    res.discountNumber = result.discountNumber;

    /// POI评论数目
    res.commentNumber = result.commentNumber;

    /// POI收藏数目
    res.favoriteNumber = result.favoriteNumber;

    /// POI签到数目
    res.checkInNumber = result.checkInNumber;
   /// POI详情子节点信息，默认不返回，需要权限。
    if (result.children && result.children.count > 0) {
        NSMutableArray<BMFPOIDetailChildrenInfo *> *mut = [NSMutableArray array];
        for (BMKPOIDetailChildrenInfo *info in result.children) {
            BMFPOIDetailChildrenInfo *cInfo = [BMFPOIDetailChildrenInfo fromBMKPOIDetailChildrenInfo:info];
            [mut addObject:cInfo];
        }
        res.children = [mut copy];
    }
    return res;
}

@end


@implementation BMFPoiIndoorInfo

+ (instancetype)fromBMKPoiIndoorInfo:(BMKPoiIndoorInfo *)result {
    BMFPoiIndoorInfo *res = [BMFPoiIndoorInfo new];

    /// POI名称
    res.name = result.name;

    /// POI唯一标识符
    res.uid = result.UID;

    /// 该室内POI所在 室内ID
    res.indoorID = result.indoorID;

    /// 该室内POI所在楼层
    res.floor = result.floor;

    /// POI地址
    res.address = result.address;

    /// POI所在城市
    res.city = result.city;

    /// POI电话号码
    res.phone = result.phone;

    /// POI坐标
    res.pt = [BMFCoordinate fromCLLocationCoordinate2D:result.pt];

    /// POI标签
    res.tag = result.tag;

    /// 价格
    res.price = result.price;

    /// 星级（0-50），50表示五星
    res.starLevel = result.starLevel;

    /// 是否有团购
    res.grouponFlag = result.grouponFlag;

    /// 是否有外卖
    res.takeoutFlag = result.takeoutFlag;

    /// 是否排队
    res.waitedFlag = result.waitedFlag;

    /// 团购数,-1表示没有团购信息
    res.grouponNum = result.grouponNum;

    /// 折扣信息FIXME
    res.discount = result.discount;
    
    return res;
}

@end
