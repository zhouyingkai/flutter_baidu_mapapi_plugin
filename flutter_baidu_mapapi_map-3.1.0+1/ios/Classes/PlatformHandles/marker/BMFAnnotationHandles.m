//
//  BMFAnnotationHandles.m
//  flutter_baidu_mapapi_map
//
//  Created by zhangbaojin on 2020/2/11.
//

#import <flutter_baidu_mapapi_base/NSObject+BMFVerify.h>
#import <flutter_baidu_mapapi_base/UIColor+BMFString.h>
#import <flutter_baidu_mapapi_base/BMFMapModels.h>
#import <flutter_baidu_mapapi_base/BMFDefine.h>

#import "BMFAnnotationHandles.h"
#import "BMFMapView.h"
#import "BMFAnnotationMethodConst.h"
#import "BMFFileManager.h"
#import "BMFAnnotation.h"

@interface BMFAnnotationHandles ()
{
    NSDictionary<NSString *, NSString *> *_handles;
}
@end
@implementation BMFAnnotationHandles

static BMFAnnotationHandles *_instance = nil;
+ (instancetype)defalutCenter {
    return [[BMFAnnotationHandles alloc] init];
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

- (NSDictionary<NSString *, NSString *> *)annotationHandles {
    if (!_handles) {
        _handles = @{
            kBMFMapAddMarkerMethod: NSStringFromClass([BMFAddAnnotation class]),
            kBMFMapAddMarkersMethod: NSStringFromClass([BMFAddAnnotations class]),
            kBMFMapRemoveMarkerMethod: NSStringFromClass([BMFRemoveAnnotation class]),
            kBMFMapRemoveMarkersMethod: NSStringFromClass([BMFRemoveAnnotations class]),
            kBMFMapCleanAllMarkersMethod: NSStringFromClass([BMFCleanAllAnnotations class]),
            kBMFMapShowMarkersMethod: NSStringFromClass([BMFShowAnnotations class]),
            kBMFMapUpdateMarkerMemberMethod: NSStringFromClass([BMFUpdateAnnotation class])
        };
    }
    return _handles;
}

@end

#pragma mark - marker

@implementation BMFAddAnnotation

@synthesize _mapView;

- (nonnull NSObject<BMFMapViewHandler> *)initWith:(nonnull BMFMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    BMKPointAnnotation *annotation = [BMKPointAnnotation overlayWithDictionary:call.arguments];
    if (annotation) {
        [_mapView addAnnotation:annotation];
        result(@YES);
    } else {
        result(@NO);
    }
}

@end

@implementation BMFAddAnnotations

@synthesize _mapView;

- (nonnull NSObject<BMFMapViewHandler> *)initWith:(nonnull BMFMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    if (!call.arguments) {
        result(@NO);
        return;
    }
    
    NSMutableArray *annotations = @[].mutableCopy;
    for (NSDictionary *dic in (NSArray *)call.arguments) {
        BMKPointAnnotation *an = [BMKPointAnnotation overlayWithDictionary:dic];
        [annotations addObject:an];
    }
    [_mapView addAnnotations:annotations];
    result(@YES);
}

@end


@implementation BMFRemoveAnnotation

@synthesize _mapView;

- (nonnull NSObject<BMFMapViewHandler> *)initWith:(nonnull BMFMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    if (!call.arguments || ![call.arguments safeObjectForKey:@"id"]) {
        result(@NO);
        return;
    }
    NSString *ID = [call.arguments safeObjectForKey:@"id"];
    __weak __typeof__(_mapView) weakMapView = _mapView;
    [_mapView.annotations enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([ID isEqualToString:((BMFAnnotationModel *)((BMKPointAnnotation *) obj).flutterModel).Id]) {
            [weakMapView removeAnnotation:obj];
            result(@YES);
            *stop = YES;
        }
    }];
    
}

@end


@implementation BMFRemoveAnnotations

@synthesize _mapView;

- (nonnull NSObject<BMFMapViewHandler> *)initWith:(nonnull BMFMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    if (!call.arguments) {
        result(@NO);
        return;
    }
    
    __block NSMutableArray <BMKPointAnnotation*> *annotations = @[].mutableCopy;
    for (NSDictionary *dic in (NSArray *)call.arguments) {
        [_mapView.annotations enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([[dic safeObjectForKey:@"id"] isEqualToString:((BMFAnnotationModel *)((BMKPointAnnotation *) obj).flutterModel).Id]) {
                [annotations addObject:obj];
                *stop = YES;
            }
        }];
    }
    [_mapView removeAnnotations:annotations];
    result(@YES);
}

@end

@implementation BMFCleanAllAnnotations

@synthesize _mapView;

- (nonnull NSObject<BMFMapViewHandler> *)initWith:(nonnull BMFMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    [_mapView removeAnnotations:_mapView.annotations];
    result(@YES);
}

@end


@implementation BMFSelectAnnotation

@synthesize _mapView;

- (nonnull NSObject<BMFMapViewHandler> *)initWith:(nonnull BMFMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    if (!call.arguments || ![call.arguments safeObjectForKey:@"id"]) {
        result(@NO);
        return;
    }
    NSString *ID = [call.arguments safeObjectForKey:@"id"];
    __block  BMKPointAnnotation *annotation;
    [_mapView.annotations enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([ID isEqualToString:((BMFAnnotationModel *)((BMKPointAnnotation *) obj).flutterModel).Id]) {
            annotation = (BMKPointAnnotation *) obj;
            *stop = YES;
        }
    }];
    if (!annotation) {
        NSLog(@"根据ID(%@)未找到对应的marker", ID);
        result(@NO);
    }
    [_mapView selectAnnotation:annotation animated:YES];
    result(@YES);
}

@end


@implementation BMFDeselectAnnotation

@synthesize _mapView;

- (nonnull NSObject<BMFMapViewHandler> *)initWith:(nonnull BMFMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    if (!call.arguments || ![call.arguments safeObjectForKey:@"id"]) {
        result(@NO);
        return;
    }
    NSString *ID = [call.arguments safeObjectForKey:@"id"];
    __block  BMKPointAnnotation *annotation;
    [_mapView.annotations enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([ID isEqualToString:((BMFAnnotationModel *)((BMKPointAnnotation *) obj).flutterModel).Id]) {
            annotation = (BMKPointAnnotation *) obj;
            *stop = YES;
        }
    }];
    if (!annotation) {
        NSLog(@"根据ID(%@)未找到对应的marker", ID);
        result(@NO);
    }
    [_mapView deselectAnnotation:annotation animated:YES];
    result(@YES);
}

@end


@implementation BMFShowAnnotations

@synthesize _mapView;

- (nonnull NSObject<BMFMapViewHandler> *)initWith:(nonnull BMFMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    if (!call.arguments || !call.arguments[@"markers"] || !call.arguments[@"animated"]) {
        result(@NO);
        return;
    }
    NSArray<NSDictionary *> *annotationsDic = (NSArray<NSDictionary *> *)[call.arguments safeValueForKey:@"markers"];
    BOOL animated = [[call.arguments safeValueForKey:@"animated"] boolValue];
    NSMutableArray<id <BMKAnnotation>> *annotations = [NSMutableArray array];
    for (NSDictionary *dic in annotationsDic) {
        BMKPointAnnotation *annotation = [BMKPointAnnotation overlayWithDictionary:dic];
        [annotations addObject:annotation];
    }
    [_mapView showAnnotations:[annotations copy] animated:animated];
    result(@YES);
}

@end

@implementation BMFUpdateAnnotation

@synthesize _mapView;

- (nonnull NSObject<BMFMapViewHandler> *)initWith:(nonnull BMFMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    if (!call.arguments || ![call.arguments safeObjectForKey:@"id"]) {
        result(@NO);
        return;
    }
    NSString *ID = [call.arguments safeObjectForKey:@"id"];
    __block  BMKPointAnnotation *annotation;
    //    __weak __typeof__(_mapView) weakMapView = _mapView;
    [_mapView.annotations enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([ID isEqualToString:((BMFAnnotationModel *)((BMKPointAnnotation *) obj).flutterModel).Id]) {
            annotation = (BMKPointAnnotation *) obj;
            *stop = YES;
        }
    }];
    if (!annotation) {
        NSLog(@"根据ID(%@)未找到对应的marker", ID);
        result(@NO);
    }
    
    NSString *member = [call.arguments safeObjectForKey:@"member"];
    
    if ([member isEqualToString:@"title"]) {
        annotation.title = [call.arguments safeObjectForKey:@"value"];
        result(@YES);
    }
    else if ([member isEqualToString:@"subtitle"]) {
        annotation.subtitle = [call.arguments safeObjectForKey:@"value"];
        result(@YES);
    }
    else if ([member isEqualToString:@"position"]) {
        BMFCoordinate *coord = [BMFCoordinate bmf_modelWith:[call.arguments safeObjectForKey:@"value"]];
        annotation.coordinate = [coord toCLLocationCoordinate2D];
        result(@YES);
    }
    else if ([member isEqualToString:@"isLockedToScreen"]) {
        annotation.isLockedToScreen = [[call.arguments safeObjectForKey:@"value"] boolValue];
        if (annotation.isLockedToScreen) {
            annotation.screenPointToLock = [[BMFMapPoint bmf_modelWith:[call.arguments safeObjectForKey:@"screenPointToLock"]] toCGPoint];
        }
        [_mapView setMapStatus:_mapView.getMapStatus];
        result(@YES);
    }
    else if ([member isEqualToString:@"icon"]) {
        BMKPinAnnotationView *view = (BMKPinAnnotationView *)[_mapView viewForAnnotation:annotation];
        view.image = [UIImage imageWithContentsOfFile:[[BMFFileManager defaultCenter] pathForFlutterImageName:[call.arguments safeObjectForKey:@"value"]]];
        result(@YES);
    }
    else if ([member isEqualToString:@"centerOffset"]) {
        BMKPinAnnotationView *view = (BMKPinAnnotationView *)[_mapView viewForAnnotation:annotation];
        BMFMapPoint *point = [BMFMapPoint bmf_modelWith:[call.arguments safeObjectForKey:@"value"]];
        view.centerOffset = [point toCGPoint];
        result(@YES);
    }
    else if ([member isEqualToString:@"enabled3D"]) {
        BMKPinAnnotationView *view = (BMKPinAnnotationView *)[_mapView viewForAnnotation:annotation];
        BOOL value = [[call.arguments safeObjectForKey:@"value"] boolValue];
        view.enabled3D = value;
        result(@YES);
    }
    else if ([member isEqualToString:@"enabled"]) {
        BMKPinAnnotationView *view = (BMKPinAnnotationView *)[_mapView viewForAnnotation:annotation];
        BOOL value = [[call.arguments safeObjectForKey:@"value"] boolValue];
        view.enabled = value;
        result(@YES);
    }
    else if ([member isEqualToString:@"draggable"]) {
        BMKPinAnnotationView *view = (BMKPinAnnotationView *)[_mapView viewForAnnotation:annotation];
        BOOL value = [[call.arguments safeObjectForKey:@"value"] boolValue];
        view.draggable = value;
        result(@YES);
    }
    else if ([member isEqualToString:@"zIndex"]) {
        NSLog(@"ios - 暂不支持设置zIndex");
        result(@YES);
    }
    else if ([member isEqualToString:@"visible"]) {
        NSLog(@"ios - 暂不支持设置visible");
        result(@YES);
    }
    else {
        result(@YES);
    }
    
}

@end
