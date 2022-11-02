//
//  BMFMapModels.h
//  flutter_baidu_mapapi_base
//
//  Created by zbj on 2020/2/10.
//

#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import "NSObject+BMFVerify.h"
#import "BMFModel.h"

NS_ASSUME_NONNULL_BEGIN

/// 经纬度
@interface BMFCoordinate : BMFModel

/// 纬度
@property(nonatomic, assign) double latitude;

/// 经度
@property(nonatomic, assign) double longitude;

/// CLLocationCoordinate2D -> BMFCoordinate
+ (instancetype)fromCLLocationCoordinate2D:(CLLocationCoordinate2D)coord;

+ (instancetype)fromBMKMapPoint:(BMKMapPoint)mapPoint;

/// 经纬度结构体数组
+ (CLLocationCoordinate2D *)fromData:(NSArray<NSDictionary *> *)data;

/// 释放经纬度结构体数组
+ (BOOL)freeCoords:(CLLocationCoordinate2D *_Nonnull*_Nullable)coords;

/// BMKMapPoint结构体数组
+ (BMKMapPoint *)fromPoints:(NSArray<NSDictionary *> *)data;

/// 释放BMKMapPoint结构体数组
+ (BOOL)freePoints:(BMKMapPoint *_Nonnull*_Nullable)points;

/// BMFCoordinate对象数组
+ (NSArray<BMFCoordinate *> *)coordinatesWith:(NSArray<NSDictionary *> *)data;

/// BMFCoordinate  ->  CLLocationCoordinate2D
- (CLLocationCoordinate2D)toCLLocationCoordinate2D;

/// BMFCoordinate ->  BMKMapPoint
- (BMKMapPoint)toBMKMapPoint;

@end

/// 地理坐标点，用直角地理坐标表示
@interface BMFMapPoint : BMFModel

/// 横坐标
@property (nonatomic, assign) double x;

/// 纵坐标
@property (nonatomic, assign) double y;

/// BMKMapPoint -> BMFMapPoint
+ (instancetype)fromBMKMapPoint:(BMKMapPoint)point;

/// CGPoint -> BMFMapPoint
+ (instancetype)fromCGPoint:(CGPoint)point;

/// BMFMapPoint -> CGPoint
- (CGPoint)toCGPoint;

/// BMFMapPoint -> BMKMapPoint
- (BMKMapPoint)toBMKMapPoint;

@end

/// 矩形大小，用直角地理坐标表示
@interface BMFMapSize : BMFModel

/// 宽度
@property (nonatomic, assign) CGFloat width;

/// 高度
@property (nonatomic, assign) CGFloat height;

/// BMKMapSize -> BMFMapSize
+ (instancetype)fromBMKMapSize:(BMKMapSize)mapSize;

/// BMFMapSize -> BMKMapSize
- (BMKMapSize)toBMKMapSize;

@end

/// 表示一个经纬度范围
@interface BMFCoordinateSpan : BMFModel

/// 纬度范围
@property (nonatomic, assign) double latitudeDelta;

/// 经度范围
@property (nonatomic, assign) double longitudeDelta;

/// BMKCoordinateSpan -> BMFCoordinateSpan
+ (instancetype)fromBMKCoordinateSpan:(BMKCoordinateSpan)span;

/// BMFCoordinateSpan -> BMKCoordinateSpan
- (BMKCoordinateSpan)toBMKCoordinateSpan;

@end

/// 表示一个经纬度区域
@interface BMFCoordinateRegion : BMFModel

/// 中心点经纬度坐标
@property (nonatomic, strong) BMFCoordinate *center;

/// 经纬度范围
@property (nonatomic, strong) BMFCoordinateSpan *span;

/// BMFCoordinateRegion -> BMKCoordinateRegion
- (BMKCoordinateRegion)toCoordinateRegion;

/// BMKCoordinateBounds -> BMFCoordinateRegion
+ (instancetype)fromBMKCoordinateBounds:(BMKCoordinateBounds)bounds;

@end

/// 表示一个经纬度区域
@interface BMFCoordinateBounds : BMFModel

/// 东北角点经纬度坐标
@property (nonatomic, strong) BMFCoordinate *northeast;

/// 西南角点经纬度坐标
@property (nonatomic, strong) BMFCoordinate *southwest;

/// BMFCoordinateBounds -->  BMKCoordinateBounds
- (BMKCoordinateBounds)toBMKCoordinateBounds;

/// BMFCoordinateBounds -->  BMKMapRect
- (BMKMapRect)toBMKMapRect;

/// BMFCoordinateBounds -->  BMKCoordinateRegion
- (BMKCoordinateRegion)toCoordinateRegion;

@end

/// 矩形，用直角地理坐标表示
@interface BMFMapRect : BMFModel

/// 屏幕左上点对应的直角地理坐标
@property (nonatomic, strong) BMFMapPoint *origin;

/// 坐标范围
@property (nonatomic, strong) BMFMapSize *size;

/// BMFMapRect -> BMKMapRect
- (BMKMapRect)toBMKMapRect;

/// BMFMapRect -> CGRect
- (CGRect)toCGRect;

/// BMFMapRect -> BMFCoordinateBounds
- (BMFCoordinateBounds *)toBMFCoordinateBounds;

/// BMKMapRect -> BMFMapRect
+ (instancetype)fromBMKMapRect:(BMKMapRect)rect;

@end

@interface BMFBuildInfo : BMFModel

/// 高度
@property (nonatomic, assign) float height;

/// 准确度
@property (nonatomic, assign) int accuracy;

/// 加密后的面
@property (nonatomic, copy) NSString *paths;

/// 加密后的中心点
@property (nonatomic, copy) NSString *center;

+ (instancetype)fromBMKBuildInfo:(BMKBuildInfo *)info;

- (BMKBuildInfo *)toBMKBuildInfo;

@end

NS_ASSUME_NONNULL_END
