//
//  BMFConvertHandles.m
// flutter_baidu_mapapi_utils
//
//  Created by zhangbaojin on 2020/4/15.
//

#import "BMFConvertHandles.h"
#import "BMFConvertMethodConst.h"
#import <flutter_baidu_mapapi_base/BMFMapModels.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>

@interface BMFConvertHandles ()
{
    NSDictionary<NSString *, NSString *> *_handles;
}
@end

@implementation BMFConvertHandles
static BMFConvertHandles *_instance = nil;
+ (instancetype)defalutCenter {
    return [[BMFConvertHandles alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    @synchronized(self) { // 同步
        if (!_instance) {
            _instance = [super allocWithZone:zone];
        }
    }
    return _instance;
}
 
- (instancetype)copyWithZone:(struct _NSZone *)zone {
    return _instance;
}

- (instancetype)mutableCopyWithZone:(nullable NSZone *)zone {
    return _instance;
}

- (NSDictionary<NSString *, NSString *> *)convertHandles {
    if (!_handles) {
        _handles = @{
            kBMFCoordTransTypeMethod: NSStringFromClass([BMFCoordTransType class]),
            kBMFPolygonContainsCoordMethod: NSStringFromClass([BMFPolygonContainsCoord class]),
            kBMFCircleContainsCoordMethod: NSStringFromClass([BMFCircleContainsCoord class]),
            kBMFGetDirectionFromCoordsMethod: NSStringFromClass([BMFGetDirectionFromCoords class]),
            kBMFAreaBetweenCoordinatesMethod: NSStringFromClass([BMFAreaBetweenCoordinates class]),
            kBMFCalculatePolygonAreaMethod: NSStringFromClass([BMFCalculatePolygonArea class]),
            kBMFLocationDistanceMethod: NSStringFromClass([BMFLocationDistance class]),
            kBMFNearestPointToLineMethod: NSStringFromClass([BMFNearestPointToLine class]),
            kBMFPointToTheVerticalFootOfLineMethod: NSStringFromClass([BMFPointToTheVerticalFootOfLine class])
        };
    }
    return _handles;
}
@end

#pragma mark - 坐标转换

@implementation BMFCoordTransType

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    if (!call.arguments || !call.arguments[@"coordinate"] || !call.arguments[@"fromType"] || !call.arguments[@"toType"]) {
        result(@{@"coordinate" : [NSNull null]});
        return;
    }
    BMFCoordinate *coord = [BMFCoordinate bmf_modelWith:[call.arguments safeObjectForKey:@"coordinate"]];
    CLLocationCoordinate2D coordinate =  BMKCoordTrans([coord toCLLocationCoordinate2D], [[call.arguments safeObjectForKey:@"fromType"] intValue], [[call.arguments safeObjectForKey:@"toType"] intValue]);
    result(@{@"coordinate" : [[BMFCoordinate fromCLLocationCoordinate2D:coordinate] bmf_toDictionary]});
}

@end


#pragma mark - 几何

@implementation BMFPolygonContainsCoord

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    if (!call.arguments || !call.arguments[@"coordinate"] || !call.arguments[@"polygon"]) {
        result(@{@"result" : @NO});
        return;
    }
    BMFCoordinate *coord = [BMFCoordinate bmf_modelWith:[call.arguments safeObjectForKey:@"coordinate"]];
    NSArray<NSDictionary *> *data = [call.arguments safeObjectForKey:@"polygon"];
    CLLocationCoordinate2D *polygon = [BMFCoordinate fromData:data];
    BOOL flag = BMKPolygonContainsCoordinate([coord toCLLocationCoordinate2D], polygon, [data count]);
    [BMFCoordinate freeCoords:&polygon];
    result(@{@"result": @(flag)});
}

@end

@implementation BMFCircleContainsCoord

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    if (!call.arguments || !call.arguments[@"coord"] || !call.arguments[@"center"] || !call.arguments[@"radius"]) {
        result(@{@"result" : @NO});
        return;
    }
    BMFCoordinate *coord = [BMFCoordinate bmf_modelWith:[call.arguments safeObjectForKey:@"coord"]];
    BMFCoordinate *center = [BMFCoordinate bmf_modelWith:[call.arguments safeObjectForKey:@"center"]];
    double radius = [[call.arguments safeValueForKey:@"radius"] doubleValue];
    BOOL flag = BMKCircleContainsCoordinate([coord toCLLocationCoordinate2D], [center toCLLocationCoordinate2D], radius);
    result(@{@"result" : @(flag)});
}

@end

@implementation BMFGetDirectionFromCoords

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    if (!call.arguments || !call.arguments[@"startCoord"] || !call.arguments[@"endCoord"]) {
        result(@{@"result" : @(361.0)});
        return;
    }
    BMFCoordinate *startCoord = [BMFCoordinate bmf_modelWith:[call.arguments safeObjectForKey:@"startCoord"]];
    BMFCoordinate *endCoord = [BMFCoordinate bmf_modelWith:[call.arguments safeObjectForKey:@"endCoord"]];
    double angle = BMKGetDirectionFromCoords([startCoord toCLLocationCoordinate2D], [endCoord toCLLocationCoordinate2D]);
    result(@{@"result" : @(angle)});
}

@end

@implementation BMFAreaBetweenCoordinates

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    if (!call.arguments || !call.arguments[@"leftTop"] || !call.arguments[@"rightBottom"]) {
        result(@{@"result" : @(-1.0)});
        return;
    }
    BMFCoordinate *leftTop = [BMFCoordinate bmf_modelWith:[call.arguments safeObjectForKey:@"leftTop"]];
    BMFCoordinate *rightBottom = [BMFCoordinate bmf_modelWith:[call.arguments safeObjectForKey:@"rightBottom"]];
    double area = BMKAreaBetweenCoordinates([leftTop toCLLocationCoordinate2D], [rightBottom toCLLocationCoordinate2D]);
    result(@{@"result" : @(area)});
}

@end

@implementation BMFCalculatePolygonArea

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    if (!call.arguments || !call.arguments[@"polygon"]) {
        result(@{@"result" : @(-1.0)});
        return;
    }
    NSArray<NSDictionary *> *data = [call.arguments safeObjectForKey:@"polygon"];
    CLLocationCoordinate2D *polygon = [BMFCoordinate fromData:data];
    double area = BMKAreaForPolygon(polygon, (int)[data count]);
    [BMFCoordinate freeCoords:&polygon];
    result(@{@"result" : @(area)});
}

@end


@implementation BMFLocationDistance

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    if (!call.arguments || !call.arguments[@"startCoord"] || !call.arguments[@"endCoord"]) {
        result(@{@"result" : @(0.0)});
        return;
    }
    BMFCoordinate *startCoord = [BMFCoordinate bmf_modelWith:[call.arguments safeObjectForKey:@"startCoord"]];
    BMFCoordinate *endCoord = [BMFCoordinate bmf_modelWith:[call.arguments safeObjectForKey:@"endCoord"]];
    BMKMapPoint start = BMKMapPointForCoordinate([startCoord toCLLocationCoordinate2D]);
    BMKMapPoint end = BMKMapPointForCoordinate([endCoord toCLLocationCoordinate2D]);
    double distance = BMKMetersBetweenMapPoints(start, end);
    result(@{@"result" : @(distance)});
}

@end


@implementation BMFNearestPointToLine

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    if (!call.arguments || !call.arguments[@"coord"] || !call.arguments[@"polyLine"]) {
        result(@{@"result" : [NSNull null]});
        return;
    }
    BMKMapPoint point = [[BMFCoordinate bmf_modelWith:[call.arguments safeObjectForKey:@"coord"]] toBMKMapPoint];
    NSArray<NSDictionary *> *data = [call.arguments safeObjectForKey:@"polyLine"];
    BMKMapPoint *polyline = [BMFCoordinate fromPoints:data];
    BMFCoordinate *near = [BMFCoordinate fromBMKMapPoint:BMKGetNearestMapPointFromPolyline(point, polyline, [data count])];
    result(@{@"result" : [near bmf_toDictionary]});

}

@end


@implementation BMFPointToTheVerticalFootOfLine

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    if (!call.arguments || !call.arguments[@"coord"] || !call.arguments[@"lineStart"] || !call.arguments[@"lineEnd"]) {
        result(@{@"result" : [NSNull null]});
        return;
    }
    BMFCoordinate *point = [BMFCoordinate bmf_modelWith:[call.arguments safeObjectForKey:@"coord"]];
    BMFCoordinate *lineStart = [BMFCoordinate bmf_modelWith:[call.arguments safeObjectForKey:@"lineStart"]];
    BMFCoordinate *lineEnd = [BMFCoordinate bmf_modelWith:[call.arguments safeObjectForKey:@"lineEnd"]];
    BMFCoordinate *foot = [BMFCoordinate fromBMKMapPoint:BMKGetPointToTheVerticalFootOfLine([point toBMKMapPoint], [lineStart toBMKMapPoint], [lineEnd toBMKMapPoint])];
    result(@{@"result" : [foot bmf_toDictionary]});
}

@end
