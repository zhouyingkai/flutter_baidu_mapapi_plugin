//
//  BMFMapModels.m
//  flutter_baidu_mapapi_base
//
//  Created by zbj on 2020/2/10.
//

#import "BMFMapModels.h"
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>

@implementation BMFCoordinate

+ (instancetype)fromCLLocationCoordinate2D:(CLLocationCoordinate2D)coord {
    BMFCoordinate *coordinate = [BMFCoordinate new];
    coordinate.latitude = coord.latitude;
    coordinate.longitude = coord.longitude;
    return coordinate;
}

+ (instancetype)fromBMKMapPoint:(BMKMapPoint)mapPoint {
    CLLocationCoordinate2D coord = BMKCoordinateForMapPoint(mapPoint);
    return [BMFCoordinate fromCLLocationCoordinate2D:coord];
}

+ (BOOL)freeCoords:(CLLocationCoordinate2D *_Nonnull*_Nullable)coords {
    if (*coords) {
        free(*coords);
        return YES;
    }
    return NO;
}

+ (CLLocationCoordinate2D *)fromData:(NSArray<NSDictionary *> *)data {
    NSUInteger count = [data count];
    CLLocationCoordinate2D *coords = new CLLocationCoordinate2D[count];
    for (int i = 0; i < count; i++) {
        coords[i] = [[BMFCoordinate bmf_modelWith:data[i]] toCLLocationCoordinate2D];
    }
    return coords;
}
/// BMKMapPoint结构体数组
+ (BMKMapPoint *)fromPoints:(NSArray<NSDictionary *> *)data{
    NSUInteger count = [data count];
    BMKMapPoint *points = new BMKMapPoint[count];
    for (int i = 0; i < count; i++) {
        points[i] = BMKMapPointForCoordinate([[BMFCoordinate bmf_modelWith:data[i]] toCLLocationCoordinate2D]);
    }
    return points;
}

/// 释放BMKMapPoint结构体数组
+ (BOOL)freePoints:(BMKMapPoint *_Nonnull*_Nullable)points {
    if (*points) {
        free(*points);
        return YES;
    }
    return NO;
}

+ (NSArray<BMFCoordinate *> *)coordinatesWith:(NSArray<NSDictionary *> *)data {
    NSMutableArray<BMFCoordinate *> *mut = [NSMutableArray array];
    if (data.count > 0) {
        for (NSDictionary *dic in data) {
            BMFCoordinate *coord = [BMFCoordinate bmf_modelWith:dic];
            [mut addObject:coord];
        }
    }
    return mut;
}

- (CLLocationCoordinate2D)toCLLocationCoordinate2D {
    return CLLocationCoordinate2DMake(self.latitude, self.longitude);
}

- (BMKMapPoint)toBMKMapPoint{
    CLLocationCoordinate2D coord = [self toCLLocationCoordinate2D];
    return BMKMapPointForCoordinate(coord);
}

@end

@implementation BMFMapPoint

+ (instancetype)fromCGPoint:(CGPoint)point {
    BMFMapPoint *pt = [BMFMapPoint new];
    pt.x = point.x;
    pt.y = point.y;
    return pt;
}

+ (instancetype)fromBMKMapPoint:(BMKMapPoint)point {
    BMFMapPoint *pt =[BMFMapPoint new];
    pt.x = point.x;
    pt.y = point.y;
    return pt;
}

- (BMKMapPoint)toBMKMapPoint {
    return BMKMapPointMake(self.x, self.y);
}

- (CGPoint)toCGPoint{
    return CGPointMake(self.x, self.y);
}

@end

@implementation BMFCoordinateSpan

+ (instancetype)fromBMKCoordinateSpan:(BMKCoordinateSpan)span {
    BMFCoordinateSpan *sp = [BMFCoordinateSpan new];
    sp.latitudeDelta = span.latitudeDelta;
    span.longitudeDelta = span.longitudeDelta;
    return sp;
}

- (BMKCoordinateSpan)toBMKCoordinateSpan {
    return BMKCoordinateSpanMake(self.latitudeDelta, self.longitudeDelta);
}

@end

@implementation BMFCoordinateRegion

/// BMKCoordinateBounds -> BMFCoordinateRegion
+ (instancetype)fromBMKCoordinateBounds:(BMKCoordinateBounds)bounds {
    BMFCoordinateRegion *region = [BMFCoordinateRegion new];
    BMFCoordinate *center = [BMFCoordinate new];
    center.latitude = (bounds.northEast.latitude +  bounds.southWest.latitude) / 2;
    center.longitude = (bounds.northEast.longitude +  bounds.southWest.longitude) / 2;
    region.center = center;
    BMFCoordinateSpan *span = [BMFCoordinateSpan new];
    span.latitudeDelta = bounds.northEast.latitude - center.latitude;
    span.longitudeDelta = bounds.northEast.longitude - center.longitude;
    region.span = span;
    return region;

}

- (BMKCoordinateRegion)toCoordinateRegion {
  return BMKCoordinateRegionMake([self.center toCLLocationCoordinate2D], [self.span toBMKCoordinateSpan]);
}

@end

@implementation BMFCoordinateBounds

/// BMFCoordinateBounds -->  BMKCoordinateBounds
- (BMKCoordinateBounds)toBMKCoordinateBounds {
    BMKCoordinateBounds bounds;
    bounds.northEast = [self.northeast toCLLocationCoordinate2D];
    bounds.southWest = [self.southwest toCLLocationCoordinate2D];
    return bounds;
}

- (BMKMapRect)toBMKMapRect {
    CLLocationCoordinate2D northEast; /// 东北角点经纬度坐标
    northEast = [self.northeast toCLLocationCoordinate2D];
    CLLocationCoordinate2D southWest; /// 西南角点经纬度坐标
    southWest = [self.southwest toCLLocationCoordinate2D];
    
    CLLocationCoordinate2D northWest; /// 西北角点经纬度坐标
    northWest.latitude = northEast.latitude;
    northWest.longitude = southWest.longitude;
    CLLocationCoordinate2D southEast; /// 东南角点经纬度坐标
    southEast.latitude = southWest.latitude;
    southEast.longitude = northEast.longitude;
    
    BMKMapPoint point = BMKMapPointForCoordinate(northWest);
    BMKMapPoint point2 = BMKMapPointForCoordinate(southEast);
    
    return BMKMapRectMake(point.x, point.y, point2.x - point.x, point2.y - point.y);
}

- (BMKCoordinateRegion)toCoordinateRegion {
    BMKCoordinateBounds bounds;
    bounds.northEast = [self.northeast toCLLocationCoordinate2D];
    bounds.southWest = [self.southwest toCLLocationCoordinate2D];
    double latitudeCenter = (bounds.northEast.latitude + bounds.southWest.latitude) / 2;
    double longitudeCenter = (bounds.northEast.longitude + bounds.southWest.longitude) / 2;
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(latitudeCenter, longitudeCenter); 
    double latitudeSpan = bounds.northEast.latitude - latitudeCenter;
    double longitudeSpan = bounds.northEast.longitude - longitudeCenter;
    BMKCoordinateSpan span = BMKCoordinateSpanMake(latitudeSpan, longitudeSpan);
    return BMKCoordinateRegionMake(center, span);
}
@end

@implementation BMFMapSize

+ (instancetype)fromBMKMapSize:(BMKMapSize)mapSize{
    BMFMapSize *size = [BMFMapSize new];
    size.width = mapSize.width;
    size.height = mapSize.height;
    return size;
}

- (BMKMapSize)toBMKMapSize {
    return BMKMapSizeMake(self.width, self.height);
}

@end

@implementation BMFMapRect

+ (instancetype)fromBMKMapRect:(BMKMapRect)mapRect {
    BMFMapRect *rect = [BMFMapRect new];
    rect.origin = [BMFMapPoint fromBMKMapPoint:mapRect.origin];
    rect.size = [BMFMapSize fromBMKMapSize:mapRect.size];
    return rect;
}

- (BMKMapRect)toBMKMapRect {
    return BMKMapRectMake(self.origin.x, self.origin.y, self.size.width, self.size.height);
}

- (CGRect)toCGRect {
    return CGRectMake(self.origin.x, self.origin.y, self.size.width, self.size.height);
}

- (BMFCoordinateBounds *)toBMFCoordinateBounds {
    BMFCoordinateBounds *bounds = [BMFCoordinateBounds new];
    BMKMapPoint point = BMKMapPointMake(self.origin.x, self.origin.y); /// 西北角直角坐标
    CLLocationCoordinate2D northWest = BMKCoordinateForMapPoint(point);
    BMKMapPoint point2 = BMKMapPointMake(self.origin.x + self.size.width, self.origin.y + self.size.height); /// 东南角点经纬度坐标
    CLLocationCoordinate2D southEast = BMKCoordinateForMapPoint(point2);
    CLLocationCoordinate2D northEast = CLLocationCoordinate2DMake(northWest.latitude, southEast.longitude); /// 东北角点经纬度坐标
    CLLocationCoordinate2D southWest = CLLocationCoordinate2DMake(southEast.latitude, northWest.longitude); /// 西南角点经纬度坐标
    bounds.northeast = [BMFCoordinate fromCLLocationCoordinate2D:northEast];
    bounds.southwest = [BMFCoordinate fromCLLocationCoordinate2D:southWest];
    return bounds;
}

@end

@implementation BMFBuildInfo

+ (instancetype)fromBMKBuildInfo:(BMKBuildInfo *)info {
    BMFBuildInfo *buildInfo = [[BMFBuildInfo alloc] init];
    buildInfo.height = info.height;
    buildInfo.accuracy = info.accuracy;
    buildInfo.paths = info.paths;
    buildInfo.center = info.center;
    return buildInfo;
}

- (BMKBuildInfo *)toBMKBuildInfo {
    BMKBuildInfo *info = [BMKBuildInfo new];
    // KVC
    [info setValue:@(self.height) forKey:@"_height"];
    [info setValue:@(self.accuracy) forKey:@"_accuracy"];
    if (self.paths) {
        [info setValue:self.paths forKey:@"_paths"];
    }
    if (self.center) {
        [info setValue:self.center forKey:@"_center"];
    }
    return info;
}

@end
