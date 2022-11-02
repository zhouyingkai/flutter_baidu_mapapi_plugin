//
//  BMFOverlayHandles.m
//  flutter_baidu_mapapi_map
//
//  Created by zhangbaojin on 2020/2/12.
//

#import "BMFOverlayHandles.h"
#import <flutter_baidu_mapapi_base/UIColor+BMFString.h>
#import <flutter_baidu_mapapi_base/BMFMapModels.h>
#import <flutter_baidu_mapapi_base/BMFDefine.h>

#import "BMFMapView.h"
#import "BMFOverlayMethodConst.h"
#import "BMFFileManager.h"
#import "BMFPolyline.h"
#import "BMFArcline.h"
#import "BMFPolygon.h"
#import "BMFCircle.h"
#import "BMFTileModel.h"
#import "BMFURLTileLayer.h"
#import "BMFAsyncTileLayer.h"
#import "BMFSyncTileLayer.h"
#import "BMFGroundOverlay.h"
#import "BMFHollowShapeModel.h"
#import "BMFGeodesicLine.h"
#import "BMFGradientLine.h"
#import "BMFPrismOverlay.h"
#import "BMF3DModelOverlay.h"
#import "BMFMultiPointOverlay.h"
#import "BMFTraceOverlay.h"

@interface BMFOverlayHandles ()
{
    NSDictionary<NSString *, NSString *> *_handles;
}
@end

@implementation BMFOverlayHandles

static  BMFOverlayHandles *_instance = nil;
+ (instancetype)defalutCenter {
    return [[BMFOverlayHandles alloc] init];
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

- (NSDictionary<NSString *, NSString *> *)overlayHandles {
    if (!_handles) {
        _handles = @{
            kBMFMapAddPolylineMethod: NSStringFromClass([BMFAddPolyline class]),
            kBMFMapAddArcineMethod: NSStringFromClass([BMFAddArcline class]),
            kBMFMapAddPolygonMethod: NSStringFromClass([BMFAddPolygon class]),
            kBMFMapAddCircleMethod: NSStringFromClass([BMFAddCircle class]),
            kBMFMapAddTileMethod: NSStringFromClass([BMFAddTile class]),
            kBMFMapAddGroundMethod: NSStringFromClass([BMFAddGround class]),
            kBMFMapAddGeodesicLineMethod: NSStringFromClass([BMFAddGeodesicLine class]),
            kBMFMapAddGradientLineMethod: NSStringFromClass([BMFAddGradientLine class]),
            kBMFMapAddPrismOverlayMethod: NSStringFromClass([BMFAddPrismOverlay class]),
            kBMFMapAdd3DModelOverlayMethod: NSStringFromClass([BMFAdd3DModelOverlay class]),
            kBMFMapAddMultiPointOverlayMethod: NSStringFromClass([BMFAddMultiPointOverlay class]),
            kBMFMapAddTraceOverlayMethod: NSStringFromClass([BMFAddTraceOverlay class]),
            kBMFMapGetOverlayBoundsMethod: NSStringFromClass([BMFGetOverlayBounds class]),
            kBMFMapRemoveOverlayMethod: NSStringFromClass([BMFRemoveOverlay class]),
            kBMFMapRemoveTraceOverlayMethod: NSStringFromClass([BMFRemoveTraceOverlay class]),
            kBMFMapRemoveTileMethod: NSStringFromClass([BMFRemoveTileOverlay class]),
            kBMFMapUpdatePolylineMemberMethod: NSStringFromClass([BMFUpdatePolyline class]),
            kBMFMapUpdateArclineMemberMethod: NSStringFromClass([BMFUpdateArcline class]),
            kBMFMapUpdateCircleMemberMethod: NSStringFromClass([BMFUpdateCircle class]),
            kBMFMapUpdatePolygonMemberMethod: NSStringFromClass([BMFUpdatePolygon class])
        };
    }
    return _handles;
}

@end

#pragma mark - overlay

@implementation BMFAddPolyline

@synthesize _mapView;

- (nonnull NSObject<BMFMapViewHandler> *)initWith:(nonnull BMFMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    BMKPolyline *polyline = [BMKPolyline overlayWithDictionary:call.arguments];
    if (polyline) {
        [_mapView addOverlay:polyline];
        result(@YES);
    } else {
        result(@NO);
    }
}

@end

@implementation BMFAddArcline

@synthesize _mapView;

- (nonnull NSObject<BMFMapViewHandler> *)initWith:(nonnull BMFMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    BMKArcline *arcline = [BMKArcline overlayWithDictionary:call.arguments];
    if (arcline) {
        [_mapView addOverlay:arcline];
        result(@YES);
    } else {
        result(@NO);
    }
}

@end


@implementation BMFAddPolygon

@synthesize _mapView;

- (nonnull NSObject<BMFMapViewHandler> *)initWith:(nonnull BMFMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    BMKPolygon *polygon = [BMKPolygon overlayWithDictionary:call.arguments];
    if (polygon) {
        [_mapView addOverlay:polygon];
        result(@YES);
    } else {
        result(@NO);
    }
}

@end


@implementation BMFAddCircle

@synthesize _mapView;

- (nonnull NSObject<BMFMapViewHandler> *)initWith:(nonnull BMFMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    BMKCircle *circle = [BMKCircle overlayWithDictionary:call.arguments];
    if (circle) {
        [_mapView addOverlay:circle];
        result(@YES);
    } else {
        result(@NO);
    }
}

@end

@implementation BMFAddTile

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
    BMFTileModel *model = [BMFTileModel bmf_modelWith:call.arguments];
    model.tileOptions = [BMFTileModelOptions bmf_modelWith:call.arguments];
    //    NSLog(@"%@", [model bmf_toDictionary]);
    if (!model) {
        result(@NO);
        return;
    }
    if (model.tileOptions.tileLoadType == kBMFTileLoadUrl && model.tileOptions.url) {
        BMFURLTileLayer *urlTileLayer = [BMFURLTileLayer urlTileLayerWith:model];
        [_mapView addOverlay:urlTileLayer];
        result(@YES);
    }
    else if (model.tileOptions.tileLoadType == kBMFTileLoadLocalAsync) {
        BMFAsyncTileLayer *asyncTileLayer = [BMFAsyncTileLayer asyncTileLayerWith:model];
        [_mapView addOverlay:asyncTileLayer];
        result(@YES);
    }
    else if (model.tileOptions.tileLoadType == kBMFTileLoadLocalSync) {
        BMFSyncTileLayer *syncTileLayer = [BMFSyncTileLayer syncTileLayerWith:model];
        [_mapView addOverlay:syncTileLayer];
        result(@YES);
    }
    else {
        result(@NO);
    }
}

@end

@implementation BMFAddGround

@synthesize _mapView;

- (nonnull NSObject<BMFMapViewHandler> *)initWith:(nonnull BMFMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    BMKGroundOverlay *ground = [BMKGroundOverlay overlayWithDictionary:call.arguments];
    if (ground) {
        [_mapView addOverlay:ground];
        result(@YES);
    } else {
        result(@NO);
    }
}

@end

@implementation BMFAddGeodesicLine

@synthesize _mapView;

- (nonnull NSObject<BMFMapViewHandler> *)initWith:(nonnull BMFMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    BMKGeodesicLine *geodesicline = [BMKGeodesicLine overlayWithDictionary:call.arguments];
    if (geodesicline) {
        [_mapView addOverlay:geodesicline];
        result(@YES);
    } else {
        result(@NO);
    }
}

@end

@implementation BMFAddGradientLine

@synthesize _mapView;

- (nonnull NSObject<BMFMapViewHandler> *)initWith:(nonnull BMFMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    BMKGradientLine *gradientLine = [BMKGradientLine overlayWithDictionary:call.arguments];
    if (gradientLine) {
        [_mapView addOverlay:gradientLine];
        result(@YES);
    } else {
        result(@NO);
    }
}

@end

@implementation BMFAddPrismOverlay

@synthesize _mapView;

- (nonnull NSObject<BMFMapViewHandler> *)initWith:(nonnull BMFMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    BMKPrismOverlay *prismOverlay = [BMKPrismOverlay overlayWithDictionary:call.arguments];
    if (prismOverlay) {
        [_mapView addOverlay:prismOverlay];
        result(@YES);
    } else {
        result(@NO);
    }
}

@end

@implementation BMFAdd3DModelOverlay

@synthesize _mapView;

- (nonnull NSObject<BMFMapViewHandler> *)initWith:(nonnull BMFMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    BMK3DModelOverlay *modelOverlay = [BMK3DModelOverlay overlayWithDictionary:call.arguments];
    if (modelOverlay) {
        [_mapView addOverlay:modelOverlay];
        result(@YES);
    } else {
        result(@NO);
    }
}

@end

@implementation BMFAddMultiPointOverlay

@synthesize _mapView;

- (nonnull NSObject<BMFMapViewHandler> *)initWith:(nonnull BMFMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    BMKMultiPointOverlay *multiPointOverlay = [BMKMultiPointOverlay overlayWithDictionary:call.arguments];
    if (multiPointOverlay) {
        [_mapView addOverlay:multiPointOverlay];
        result(@YES);
    } else {
        result(@NO);
    }
}

@end

@implementation BMFAddTraceOverlay

@synthesize _mapView;

- (nonnull NSObject<BMFMapViewHandler> *)initWith:(nonnull BMFMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    BMKTraceOverlay *traceOverlay = [BMKTraceOverlay overlayWithDictionary:call.arguments];
    if (traceOverlay) {
        [_mapView addOverlay:traceOverlay];
        result(@YES);
    } else {
        result(@NO);
    }
}

@end

#pragma mark - Getter

@implementation BMFGetOverlayBounds

@synthesize _mapView;

- (nonnull NSObject<BMFMapViewHandler> *)initWith:(nonnull BMFMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    if (!call.arguments || !call.arguments[@"overlayType"] || !call.arguments[@"overlay"]) {
        result(@{});
        return;
    }
    NSString *overlayType = [call.arguments safeValueForKey:@"overlayType"];
    NSDictionary *overlayDic = [call.arguments safeValueForKey:@"overlay"];
    id <BMKOverlay> overlay;
    if ([overlayType isEqualToString:@"BMFPolyline"]) {
        overlay = [BMKPolyline overlayWithDictionary:overlayDic];
    }
    else if ([overlayType isEqualToString:@"BMFGradientLine"]) {
        overlay = [BMKGradientLine overlayWithDictionary:overlayDic];
    }
    else if ([overlayType isEqualToString:@"BMFPolygon"]) {
        overlay = [BMKPolygon overlayWithDictionary:overlayDic];
    }
    else if ([overlayType isEqualToString:@"BMFTraceOverlay"]) {
        overlay = [BMKTraceOverlay overlayWithDictionary:overlayDic];
    }
    else if ([overlayType isEqualToString:@"BMFArcLine"]) {
        overlay = [BMKArcline overlayWithDictionary:overlayDic];
    }
    else if ([overlayType isEqualToString:@"BMFCircle"]) {
        overlay = [BMKCircle overlayWithDictionary:overlayDic];
    }
 
    if (overlay) {
        BMFMapRect *rect = [BMFMapRect fromBMKMapRect:overlay.boundingMapRect];
        BMFCoordinateBounds *bounds = [rect toBMFCoordinateBounds];
        result([bounds bmf_toDictionary]);
    } else {
        result(@{});
    }
}

@end

#pragma mark - Remove

@implementation BMFRemoveOverlay

@synthesize _mapView;

- (nonnull NSObject<BMFMapViewHandler> *)initWith:(nonnull BMFMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    if (!call.arguments || !call.arguments[@"id"]) {
        result(@NO);
        return;
    }
    NSString *ID = [call.arguments safeObjectForKey:@"id"];
    __block NSString *overlayID;
    __weak __typeof__(_mapView) weakMapView = _mapView;
    [_mapView.overlays enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if ([obj isKindOfClass:[BMKPolyline class]]) { // polyline
            overlayID = ((BMFPolylineModel *)((id<BMFOverlay> )obj).flutterModel).Id;
        }
        else if ([obj isKindOfClass:[BMKPolygon class]]) { // polygon
            overlayID = ((BMFPolygonModel *)((id<BMFOverlay> )obj).flutterModel).Id;
        }
        else if ([obj isKindOfClass:[BMKArcline class]]) { // arcline
            overlayID = ((BMFArclineModel *)((id<BMFOverlay> )obj).flutterModel).Id;
        }
        else if ([obj isKindOfClass:[BMKCircle class]]) { // circle
            overlayID = ((BMFCircleModel *)((id<BMFOverlay> )obj).flutterModel).Id;
        }
        else if ([obj isKindOfClass:[BMKGroundOverlay class]]) { // ground
            overlayID = ((BMFGroundModel *)((id<BMFOverlay> )obj).flutterModel).Id;
        }
        else if ([obj isKindOfClass:[BMKGeodesicLine class]]) { // geodesicline
            overlayID = ((BMFGeodesicLineModel *)((id<BMFOverlay> )obj).flutterModel).Id;
        }
        else if ([obj isKindOfClass:[BMKGradientLine class]]) { // gradientline
            overlayID = ((BMFGradientLineModel *)((id<BMFOverlay> )obj).flutterModel).Id;
        }
        else if ([obj isKindOfClass:[BMKPrismOverlay class]]) { // prism
            overlayID = ((BMFPrismOverlayModel *)((id<BMFOverlay> )obj).flutterModel).Id;
        }
        else if ([obj isKindOfClass:[BMK3DModelOverlay class]]) { // 3dmodel
            overlayID = ((BMF3DModelOverlayModel *)((id<BMFOverlay> )obj).flutterModel).Id;
        }
        else if ([obj isKindOfClass:[BMKMultiPointOverlay class]]) { // multipoint
            overlayID = ((BMFMultiPointOverlayModel *)((id<BMFOverlay> )obj).flutterModel).Id;
        }
        else if ([obj isKindOfClass:[BMKTraceOverlay class]]) { // trace
            overlayID = ((BMFTraceOverlayModel *)((id<BMFOverlay> )obj).flutterModel).Id;
        }
        
        if (overlayID) {
            if ([ID isEqualToString:overlayID]) {
                [weakMapView removeOverlay:obj];
                result(@YES);
                *stop = YES;
                return;
            }
        }
    }];
}

@end

// 兼容android的删除方法
@implementation BMFRemoveTraceOverlay

@synthesize _mapView;

- (nonnull NSObject<BMFMapViewHandler> *)initWith:(nonnull BMFMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    if (!call.arguments || !call.arguments[@"id"]) {
        result(@NO);
        return;
    }
    NSString *ID = [call.arguments safeObjectForKey:@"id"];
    __block NSString *overlayID;
    __weak __typeof__(_mapView) weakMapView = _mapView;
    [_mapView.overlays enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[BMKTraceOverlay class]]) { // trace
            overlayID = ((BMFTraceOverlayModel *)((id<BMFOverlay> )obj).flutterModel).Id;
        }
        
        if (overlayID) {
            if ([ID isEqualToString:overlayID]) {
                [weakMapView removeOverlay:obj];
                result(@YES);
                *stop = YES;
                return;
            }
        }
    }];
}

@end


@implementation BMFRemoveTileOverlay

@synthesize _mapView;

- (nonnull NSObject<BMFMapViewHandler> *)initWith:(nonnull BMFMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    if (!call.arguments || !call.arguments[@"id"]) {
        result(@NO);
        return;
    }
    NSString *ID = [call.arguments safeObjectForKey:@"id"];
    __block NSString *overlayID;
    __weak __typeof__(_mapView) weakMapView = _mapView;
    [_mapView.overlays enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 瓦片图
        if ([obj isKindOfClass:[BMFURLTileLayer class]]) {
            overlayID = ((BMFURLTileLayer *)obj).Id;
        }
        else if ([obj isKindOfClass:[BMFAsyncTileLayer class]]) {
            overlayID = ((BMFAsyncTileLayer *)obj).Id;
        }
        else if ([obj isKindOfClass:[BMFSyncTileLayer class]]) {
            overlayID = ((BMFSyncTileLayer *)obj).Id;
        }
        
        if ([ID isEqualToString:overlayID]) {
            [weakMapView removeOverlay:obj];
            result(@YES);
            *stop = YES;
            return;
        }
        
    }];
}

@end

#pragma mark - Update
@implementation BMFUpdatePolyline

@synthesize _mapView;

- (nonnull NSObject<BMFMapViewHandler> *)initWith:(nonnull BMFMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    if (!call.arguments || !call.arguments[@"id"]) {
        result(@NO);
        return;
    }
    NSString *ID = [call.arguments safeObjectForKey:@"id"];
    __block  BMKPolyline *polyline;
    [_mapView.overlays enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[BMKPolyline class]]) {
            BMKPolyline *line = (BMKPolyline *)obj;
            if ([ID isEqualToString:((BMFPolylineModel *)line.flutterModel).Id]) {
                polyline = line;
                *stop = YES;
            }
        }
    }];
    if (!polyline) {
        result(@NO);
        return;
    }
    NSString *member = [call.arguments safeObjectForKey:@"member"];
    
    //        kBMFColorLine = 0,   ///< 单色折线
    //        kBMFColorsLine,      ///< 多色折线
    //        kBMFTextureLine,     ///< 单纹理折线
    //        kBMFTexturesLine,    ///< 多纹理折线
    //        kBMFDashLine,        ///< 虚线
    //        kBMFMultiDashLine    ///< 多色虚线
    
    if ([member isEqualToString:@"coordinates"]) {
        
        NSArray<NSDictionary *> *coordinates = [call.arguments safeObjectForKey:@"value"];
        if (!coordinates || coordinates.count <= 1) {
            result(@NO);
            return;
        }
        
        CLLocationCoordinate2D coords[coordinates.count];
        for (size_t i = 0, count = coordinates.count; i < count; i++) {
            BMFCoordinate *coord = [BMFCoordinate bmf_modelWith:coordinates[i]];
            coords[i] = [coord toCLLocationCoordinate2D];
        }
        switch (polyline.lineType) {
            case kBMFColorLine:
            case kBMFTextureLine:
            case kBMFDashLine: {
                [polyline setPolylineWithCoordinates:coords count:coordinates.count];
                result(@YES);
                break;
            }
            case kBMFColorsLine:
            case kBMFTexturesLine:
            case kBMFMultiDashLine: {
                if (![call.arguments safeObjectForKey:@"indexs"]) {
                    result(@NO);
                    return;
                }
                NSMutableArray<NSNumber *> *indexs = [NSMutableArray array];
                for (NSNumber *value in call.arguments[@"indexs"]) {
                    [indexs addObject:value];
                }
                
                [(BMKMultiPolyline *)polyline setMultiPolylineWithCoordinates:coords count:coordinates.count drawIndexs:indexs];
                result(@YES);
                break;
            }
            default:
                break;
        }
        
    }
    else if ([member isEqualToString:@"width"]) {
        BMKPolylineView *view = (BMKPolylineView *)[_mapView viewForOverlay:polyline];
        view.lineWidth = [[call.arguments safeObjectForKey:@"value"] floatValue];
        result(@YES);
    }
    else if ([member isEqualToString:@"colors"]) {
        NSArray *colorsData = [call.arguments safeObjectForKey:@"value"];
        if (!colorsData || colorsData.count <= 0) {
            result(@NO);
            return;
        }
        BMKPolylineView *view = (BMKPolylineView *)[_mapView viewForOverlay:polyline];
        NSMutableArray<UIColor *> *colors = [NSMutableArray array];
        for (NSString *color in colorsData) {
            [colors addObject:[UIColor fromColorString:color]];
        }
        if (polyline.lineType == kBMFColorsLine || polyline.lineType == kBMFMultiDashLine) {
            ((BMKMultiColorPolylineView *)view).strokeColors = [colors copy];
            result(@YES);
            
        }
        else if (polyline.lineType ==kBMFColorLine || polyline.lineType == kBMFDashLine) {
            view.strokeColor = [colors firstObject];
            result(@YES);
        }
        else {
            NSLog(@"ios - 纹理折线不支持更新colors");
            result(@NO);
        }
    }
    else if ([member isEqualToString:@"lineDashType"]) {
        if (polyline.lineType == kBMFTextureLine || polyline.lineType == kBMFTexturesLine) {
            NSLog(@"ios - 纹理折线不支持虚线类型");
            result(@NO);
            return;
        }
        BMKPolylineView *view = (BMKPolylineView *)[_mapView viewForOverlay:polyline];
        view.lineDashType = [[call.arguments safeObjectForKey:@"value"] intValue];
        result(@YES);
    }
    else if ([member isEqualToString:@"lineCapType"]) {
        BMKPolylineView *view = (BMKPolylineView *)[_mapView viewForOverlay:polyline];
        if (view.lineDashType != kBMKLineDashTypeNone) {
            NSLog(@"ios - lineCapType不支持虚线");
            result(@NO);
            return;
        }
        view.lineCapType = [[call.arguments safeObjectForKey:@"value"] intValue];
        result(@YES);
    }
    else if ([member isEqualToString:@"lineJoinType"]) {
        if (polyline.lineType == kBMFDashLine || polyline.lineType == kBMFMultiDashLine) {
            NSLog(@"ios - lineJoinType不支持虚线");
            result(@NO);
            return;
        }
        BMKPolylineView *view = (BMKPolylineView *)[_mapView viewForOverlay:polyline];
        view.lineJoinType = [[call.arguments safeObjectForKey:@"value"] intValue];
        result(@YES);
    }
    else if ([member isEqualToString:@"isThined"]) {
        polyline.isThined = [[call.arguments safeObjectForKey:@"value"] boolValue];
        result(@YES);
    } else {
        NSLog(@"ios -polyline- 暂不支持设置%@", member);
        result(@YES);
    }
}

@end


@implementation  BMFUpdateArcline

@synthesize _mapView;

- (nonnull NSObject<BMFMapViewHandler> *)initWith:(nonnull BMFMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    if (!call.arguments || !call.arguments[@"id"]) {
        result(@NO);
        return;
    }
    NSString *ID = [call.arguments safeObjectForKey:@"id"];
    __block BMKArcline *arcline;
    [_mapView.overlays enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[BMKArcline class]]) {
            BMKArcline *aline = (BMKArcline *)obj;
            if ([ID isEqualToString:((BMFArclineModel *)aline.flutterModel).Id]) {
                arcline = aline;
                *stop = YES;
            }
        }
    }];
    if (!arcline) {
        result(@NO);
        return;
    }
    NSString *member = [call.arguments safeObjectForKey:@"member"];
    
    if ([member isEqualToString:@"coordinates"]) {
        NSArray<NSDictionary *> *coordinates = [call.arguments safeObjectForKey:@"value"];
        if (!coordinates || coordinates.count <= 2) {
            result(@NO);
            return;
        }
        
        CLLocationCoordinate2D coords[coordinates.count];
        for (size_t i = 0, count = coordinates.count; i < count; i++) {
            BMFCoordinate *coord = [BMFCoordinate bmf_modelWith:coordinates[i]];
            coords[i] = [coord toCLLocationCoordinate2D];
        }
        [arcline setArclineWithCoordinates:coords];
        result(@YES);
    }
    else if ([member isEqualToString:@"width"]) {
        BMKArclineView *view = (BMKArclineView *)[_mapView viewForOverlay:arcline];
        view.lineWidth = [[call.arguments safeObjectForKey:@"value"] floatValue];
        result(@YES);
    }
    else if ([member isEqualToString:@"color"]) {
        BMKArclineView *view = (BMKArclineView *)[_mapView viewForOverlay:arcline];
        NSString *colorStr = [call.arguments safeObjectForKey:@"value"];
        view.strokeColor = [UIColor fromColorString:colorStr];
        result(@YES);
    }
    else if ([member isEqualToString:@"lineDashType"]) {
        BMKArclineView *view = (BMKArclineView *)[_mapView viewForOverlay:arcline];
        view.lineDashType = [[call.arguments safeObjectForKey:@"value"] intValue];
        result(@YES);
    }
    else {
        NSLog(@"ios -arcline- 暂不支持设置%@", member);
        result(@YES);
    }
}

@end


@implementation BMFUpdateCircle

@synthesize _mapView;

- (nonnull NSObject<BMFMapViewHandler> *)initWith:(nonnull BMFMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    if (!call.arguments || !call.arguments[@"id"]) {
        result(@NO);
        return;
    }
    NSString *ID = [call.arguments safeObjectForKey:@"id"];
    __block BMKCircle *circle;
    [_mapView.overlays enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[BMKCircle class]]) {
            BMKCircle *aCircle = (BMKCircle *)obj;
            if ([ID isEqualToString:((BMFCircleModel *)aCircle.flutterModel).Id]) {
                circle = aCircle;
                *stop = YES;
            }
        }
    }];
    if (!circle) {
        result(@NO);
        return;
    }
    NSString *member = [call.arguments safeObjectForKey:@"member"];
    
    if ([member isEqualToString:@"center"]) {
        BMFCoordinate *center = [BMFCoordinate bmf_modelWith:[call.arguments safeObjectForKey:@"value"]];
        [circle setCoordinate:[center toCLLocationCoordinate2D]];
        result(@YES);
    }
    else if ([member isEqualToString:@"radius"]) {
        double radius = [[call.arguments safeObjectForKey:@"value"] doubleValue];
        [circle setRadius:radius];
        result(@YES);
    }
    else if ([member isEqualToString:@"width"]) {
        BMKCircleView *view = (BMKCircleView *)[_mapView viewForOverlay:circle];
        view.lineWidth = [[call.arguments safeObjectForKey:@"value"] floatValue];
        result(@YES);
    }
    else if ([member isEqualToString:@"strokeColor"]) {
        BMKCircleView *view = (BMKCircleView *)[_mapView viewForOverlay:circle];
        NSString *colorStr = [call.arguments safeObjectForKey:@"value"];
        view.strokeColor = [UIColor fromColorString:colorStr];
        result(@YES);
    }
    else if ([member isEqualToString:@"fillColor"]) {
        BMKCircleView *view = (BMKCircleView *)[_mapView viewForOverlay:circle];
        NSString *colorStr = [call.arguments safeObjectForKey:@"value"];
        view.fillColor = [UIColor fromColorString:colorStr];
        result(@YES);
    }
    else if ([member isEqualToString:@"lineDashType"]) {
        BMKCircleView *view = (BMKCircleView *)[_mapView viewForOverlay:circle];
        view.lineDashType = [[call.arguments safeObjectForKey:@"value"] intValue];
        result(@YES);
    }
    else if ([member isEqualToString:@"hollowShapes"]) {
        NSArray<id<BMKOverlay>> *hollowShapes = [BMFHollowShapeModel fromDictionaryArray:(NSArray<NSDictionary *> *)[call.arguments safeObjectForKey:@"value"]];
        circle.hollowShapes = hollowShapes;
        result(@YES);
    }
    else {
        NSLog(@"ios -circle- 暂不支持设置%@", member);
        result(@YES);
    }
}

@end


@implementation BMFUpdatePolygon

@synthesize _mapView;

- (nonnull NSObject<BMFMapViewHandler> *)initWith:(nonnull BMFMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    if (!call.arguments || !call.arguments[@"id"]) {
        result(@NO);
        return;
    }
    NSString *ID = [call.arguments safeObjectForKey:@"id"];
    __block BMKPolygon *polygon;
    [_mapView.overlays enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[BMKPolygon class]]) {
            BMKPolygon *aPolygon = (BMKPolygon *)obj;
            if ([ID isEqualToString:((BMFPolygonModel *)aPolygon.flutterModel).Id]) {
                polygon = aPolygon;
                *stop = YES;
            }
        }
    }];
    if (!polygon) {
        result(@NO);
        return;
    }
    NSString *member = [call.arguments safeObjectForKey:@"member"];
    
    if ([member isEqualToString:@"coordinates"]) {
        NSArray<NSDictionary *> *coordinates = [call.arguments safeObjectForKey:@"value"];
        if (!coordinates || coordinates.count <= 1) {
            result(@NO);
            return;
        }
        
        CLLocationCoordinate2D coords[coordinates.count];
        for (size_t i = 0, count = coordinates.count; i < count; i++) {
            BMFCoordinate *coord = [BMFCoordinate bmf_modelWith:coordinates[i]];
            coords[i] = [coord toCLLocationCoordinate2D];
        }
        [polygon setPolygonWithCoordinates:coords count:coordinates.count];
        result(@YES);
        
    }
    else if ([member isEqualToString:@"width"]) {
        BMKPolygonView *view = (BMKPolygonView *)[_mapView viewForOverlay:polygon];
        view.lineWidth = [[call.arguments safeObjectForKey:@"value"] floatValue];
        result(@YES);
    }
    else if ([member isEqualToString:@"strokeColor"]) {
        BMKPolygonView *view = (BMKPolygonView *)[_mapView viewForOverlay:polygon];
        NSString *colorStr = [call.arguments safeObjectForKey:@"value"];
        view.strokeColor = [UIColor fromColorString:colorStr];
        result(@YES);
    }
    else if ([member isEqualToString:@"fillColor"]) {
        BMKPolygonView *view = (BMKPolygonView *)[_mapView viewForOverlay:polygon];
        NSString *colorStr = [call.arguments safeObjectForKey:@"value"];
        view.fillColor = [UIColor fromColorString:colorStr];
        result(@YES);
    }
    else if ([member isEqualToString:@"lineDashType"]) {
        BMKPolygonView *view = (BMKPolygonView *)[_mapView viewForOverlay:polygon];
        view.lineDashType = [[call.arguments safeObjectForKey:@"value"] intValue];
        result(@YES);
    }
    else if ([member isEqualToString:@"hollowShapes"]) {
        NSArray<id<BMKOverlay>> *hollowShapes = [BMFHollowShapeModel fromDictionaryArray:(NSArray<NSDictionary *> *)[call.arguments safeObjectForKey:@"value"]];
        polygon.hollowShapes = hollowShapes;
        result(@YES);
    }
    else {
        NSLog(@"ios -polygon- 暂不支持设置%@", member);
        result(@YES);
    }
    
}

@end
