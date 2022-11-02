//
//  BMFCircleGeofenceHandle.m
//  flutter_bmflocation
//
//  Created by v_wangdachuan on 2022/2/11.
//

#import "BMFCircleGeofenceHandle.h"
#import "BMFLocationMethodHandles.h"
#import "BMFLocationMethodConst.h"
#import <BMKLocationkit/BMKLocationComponent.h>
#import "BMFLocationChannelHandle.h"

#define kNotEmpty(objc) (objc != [NSNull null]) && objc
#define kNotNull(notNull) [self excludeNil:notNull]

@interface BMFCircleGeofenceHandle ()<BMKGeoFenceManagerDelegate>

@property(nonatomic, strong) BMKGeoFenceManager *geofenceManager;

@end

@implementation BMFCircleGeofenceHandle

@synthesize _channel;

- (NSObject<BMFLocationHandle> *)initWithManager:(BMKLocationManager *)manager channel:(FlutterMethodChannel *)channel {
    _channel = channel;
    self.geofenceManager = [[BMKGeoFenceManager alloc] init];
    self.geofenceManager.delegate = self;
    return self;
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    
    if ([call.method isEqualToString:kBMFLocationCircleGeofence] ||
        [call.method isEqualToString:kBMFLocationPolygonGeofence]) {
        
        NSDictionary *regionDic = call.arguments;
        //创建围栏
        [self createGeofence:regionDic];
    } else if ([call.method isEqualToString:kBMFLocationGetAllGeofence]) {
        
        //获取自定义id全部围栏
        NSArray *geofences = [self.geofenceManager geoFenceRegionsWithCustomID:nil];
        
        if (geofences.count > 0 && geofences) {
            //将BMKGeoFenceRegion对象解析
            NSArray *results = [self analysisBMKGeoFenceRegions:geofences];
            result(@{@"result": results});
        } else {
            result(@{@"result": [NSArray array]});
        }
    } else if ([call.method isEqualToString:kBMFLocationRemoveGeofenceId]) {
        
        //删除自定义id围栏
        NSString *customId = call.arguments;
        [self.geofenceManager removeGeoFenceRegionsWithCustomID:customId];
        
        //如果没有了围栏就释放handle
        NSArray *geofences = [self.geofenceManager geoFenceRegionsWithCustomID:nil];
        if (geofences.count <= 1) {
            [[BMFLocationMethodHandles defalutCenter].handlerDictionary removeObjectForKey:NSStringFromClass([self class])];
        }
        
    } else if ([call.method isEqualToString:kBMFLocationRemoveAllGeofence]) {
        
        //删除全部围栏
        [self.geofenceManager removeAllGeoFenceRegions];
        //释放handle
        [[BMFLocationMethodHandles defalutCenter].handlerDictionary removeObjectForKey:NSStringFromClass([self class])];
        
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (void)createGeofence:(NSDictionary *)regionDic {

    //坐标
    BMKLocationCoordinateType coordType = BMKLocationCoordinateTypeGCJ02;
    if ([[regionDic allKeys] containsObject:@"coordType"] &&
        kNotEmpty(regionDic[@"coordType"])) {
        if ([regionDic[@"coordType"] intValue] == 0) {
            coordType = BMKLocationCoordinateTypeGCJ02;
        } else if ([regionDic[@"coordType"] intValue] == 1) {
            coordType = BMKLocationCoordinateTypeWGS84;
        } else {
            coordType = BMKLocationCoordinateTypeBMK09LL;
        }
    }
    
    if ([[regionDic allKeys] containsObject:@"activateAction"] &&
        kNotEmpty(regionDic[@"activateAction"])) {
        if ([regionDic[@"activateAction"] intValue] == 0) {
            self.geofenceManager.activeAction = BMKGeoFenceActiveActionInside;
        } else if ([regionDic[@"activateAction"] intValue] == 1) {
            self.geofenceManager.activeAction = BMKGeoFenceActiveActionOutside;
        } else if ([regionDic[@"activateAction"] intValue] == 2) {
            self.geofenceManager.activeAction = BMKGeoFenceActiveActionStayed;
        } else if ([regionDic[@"activateAction"] intValue] == 3) {
            self.geofenceManager.activeAction = BMKGeoFenceActiveActionOutside | BMKGeoFenceActiveActionInside;
        } else if ([regionDic[@"activateAction"] intValue] == 4) {
            self.geofenceManager.activeAction = BMKGeoFenceActiveActionStayed | BMKGeoFenceActiveActionInside;
        } else if ([regionDic[@"activateAction"] intValue] == 5) {
            self.geofenceManager.activeAction = BMKGeoFenceActiveActionStayed | BMKGeoFenceActiveActionOutside;
        } else {
            self.geofenceManager.activeAction = BMKGeoFenceActiveActionStayed | BMKGeoFenceActiveActionInside | BMKGeoFenceActiveActionOutside;
        }
    }
    
    if ([[regionDic allKeys] containsObject:@"pausesLocationUpdatesAutomatically"] &&
        kNotEmpty(regionDic[@"pausesLocationUpdatesAutomatically"])) {
        self.geofenceManager.pausesLocationUpdatesAutomatically = [regionDic[@"pausesLocationUpdatesAutomatically"] boolValue];
        
    }
    
    if ([[regionDic allKeys] containsObject:@"allowsBackgroundLocationUpdates"] &&
        kNotEmpty(regionDic[@"allowsBackgroundLocationUpdates"])) {
        self.geofenceManager.allowsBackgroundLocationUpdates = [regionDic[@"allowsBackgroundLocationUpdates"] boolValue];
    }
    
    if ([[regionDic allKeys] containsObject:@"centerCoordinate"] &&
        kNotEmpty(regionDic[@"centerCoordinate"]) &&
        [[regionDic allKeys] containsObject:@"radius"] &&
        kNotEmpty(regionDic[@"radius"])) {
        
        NSDictionary *dic = regionDic[@"centerCoordinate"];
        CLLocationDistance distance = [regionDic[@"radius"] doubleValue];
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([dic[@"latitude"] doubleValue], [dic[@"longitude"] doubleValue]);
        //添加围栏
        [self.geofenceManager addCircleRegionForMonitoringWithCenter:coordinate radius:distance coorType:coordType customID:(kNotEmpty(regionDic[@"customId"])) ? regionDic[@"customId"] : @""];
        
    } else if ([[regionDic allKeys] containsObject:@"coordinateList"] &&
               kNotEmpty(regionDic[@"coordinateList"])) {
        
        NSMutableArray *coordinates = [NSMutableArray array];
        NSArray *array = regionDic[@"coordinateList"];
        for (int i = 0; i < array.count; i++) {
            NSDictionary *dic = array[i];
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([dic[@"latitude"] doubleValue], [dic[@"longitude"] doubleValue]);
            [coordinates addObject:[NSValue value:&coordinate withObjCType:@encode(struct CLLocationCoordinate2D)]];
        }
        
        int size = (int)[coordinates count];
        CLLocationCoordinate2D *coorArr = malloc(sizeof(CLLocationCoordinate2D) * size);
        for (int i = 0; i < size; i++) {
            struct CLLocationCoordinate2D p;
            [[coordinates objectAtIndex:i] getValue:&p];
            
            coorArr[i] = CLLocationCoordinate2DMake(p.latitude, p.longitude);
        }
        
        //添加围栏
        [_geofenceManager addPolygonRegionForMonitoringWithCoordinates:coorArr count:size coorType:BMKLocationCoordinateTypeBMK09LL customID:(kNotEmpty(regionDic[@"customId"])) ? regionDic[@"customId"] : @""];
    } else {
        
        NSDictionary *resultDic = @{@"regions": [NSArray array]};
        //参数错误
        [BMFLocationChannelHandle sendResultCallbackChannel:_channel methodId:kBMFLocationGeofenceCallback result:resultDic errorCode:2];
    }
}

- (void)BMKGeoFenceManager:(BMKGeoFenceManager * _Nonnull)manager didAddRegionForMonitoringFinished:(NSArray <BMKGeoFenceRegion *> * _Nullable)regions customID:(NSString * _Nullable)customID error:(NSError * _Nullable)error {

    NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
    
    if (error.code != 0) {
        
        [BMFLocationChannelHandle sendResultCallbackChannel:_channel methodId:kBMFLocationGeofenceCallback result:resultDic errorCode:error.code];
    } else {
        
        //创建成功后
        NSMutableDictionary *regionDic = [NSMutableDictionary dictionary];
        if (regions.count > 0) {
            
            BMKGeoFenceRegion *region = regions.lastObject;
            [regionDic setValue:kNotNull(region.identifier) forKey:@"geofenceId"];
            [regionDic setValue:kNotNull(region.customID) forKey:@"customId"];
            [regionDic setValue:[NSNumber numberWithInteger:region.fenceStatus] forKey:@"geofenceState"];

            if (region.coordinateType == BMKLocationCoordinateTypeGCJ02) {
                [regionDic setValue:@0 forKey:@"coordType"];
            } else if (region.coordinateType == BMKLocationCoordinateTypeWGS84){
                [regionDic setValue:@1 forKey:@"coordType"];
            } else {
                [regionDic setValue:@2 forKey:@"coordType"];
            }
            
            if ([NSStringFromClass(region.class) isEqualToString:NSStringFromClass([BMKGeoFenceCircleRegion class])]) {
                
                BMKGeoFenceCircleRegion *circle = (BMKGeoFenceCircleRegion *)region;
                [regionDic setValue:@0 forKey:@"geofenceStyle"];
                [regionDic setValue:@{@"latitude": @(circle.center.latitude), @"longitude": @(circle.center.longitude)} forKey:@"centerCoordinate"];
                [regionDic setValue:@(circle.radius) forKey:@"radius"];
            } else if ([NSStringFromClass(region.class) isEqualToString:NSStringFromClass([BMKGeoFencePolygonRegion class])]) {
                
                BMKGeoFencePolygonRegion *polygon = (BMKGeoFencePolygonRegion *)region;
                NSMutableArray *coords = [NSMutableArray array];
                for (int i = 0; i < polygon.count; i++) {
                    
                    NSDictionary *dic = @{@"latitude": @(polygon.coordinates[i].latitude), @"longitude": @(polygon.coordinates[i].longitude)};
                    [coords addObject:dic];
                }
                [regionDic setValue:coords forKey:@"coordinateList"];
                [regionDic setValue:@(coords.count) forKey:@"coordinateCount"];
                [regionDic setValue:@1 forKey:@"geofenceStyle"];
            }
        
        }
        [resultDic setValue:regionDic forKey:@"region"];
        [BMFLocationChannelHandle sendResultCallbackChannel:_channel methodId:kBMFLocationGeofenceCallback result:resultDic errorCode:0];
        
    }

}

/**
 * @brief 地理围栏状态改变时回调，当围栏状态的值发生改变，定位失败都会调用
 * @param manager 地理围栏管理类
 * @param region 状态改变的地理围栏
 * @param customID 用户执行添加围栏函数时传入的customID
 * @param error 错误信息，如定位相关的错误
 */
- (void)BMKGeoFenceManager:(BMKGeoFenceManager * _Nonnull)manager didGeoFencesStatusChangedForRegion:(BMKGeoFenceRegion * _Nullable)region customID:(NSString * _Nullable)customID error:(NSError * _Nullable)error {
    
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
    NSInteger code = 0;
    if (error) {
        code = error.code;
    } else {
        switch (region.fenceStatus) {
            case BMKGeoFenceRegionStatusInside:
                [resultDic setValue:@1 forKey:@"geoFenceRegionStatus"];
                break;
            case BMKGeoFenceRegionStatusStayed:
                [resultDic setValue:@2 forKey:@"geoFenceRegionStatus"];
                break;
            case BMKGeoFenceRegionStatusOutside:
                [resultDic setValue:@3 forKey:@"geoFenceRegionStatus"];
                break;
            default:
                [resultDic setValue:@0 forKey:@"geoFenceRegionStatus"];
                break;
        }
    }
    [BMFLocationChannelHandle sendResultCallbackChannel:_channel methodId:kBMFLocationMonitorGeofence result:resultDic errorCode:code];
}



/// 将BMKGeoFenceRegion对象解析
/// @param regions 要解析的围栏
- (NSArray *)analysisBMKGeoFenceRegions:(NSArray<BMKGeoFenceRegion *>*)regions {
    
    //将BMKGeoFenceRegion对象解析
    NSMutableArray *results = [NSMutableArray array];
    for (int i = 0; i < regions.count; i++) {
        
        BMKGeoFenceRegion *region = regions[i];
        NSMutableDictionary *regionDic = [NSMutableDictionary dictionary];
        [regionDic setValue:kNotNull(region.identifier) forKey:@"geofenceId"];
        [regionDic setValue:kNotNull(region.customID) forKey:@"customId"];
        [regionDic setValue:[NSNumber numberWithInteger:region.fenceStatus] forKey:@"geofenceState"];

        if (region.coordinateType == BMKLocationCoordinateTypeGCJ02) {
            [regionDic setValue:@0 forKey:@"coordType"];
        } else if (region.coordinateType == BMKLocationCoordinateTypeWGS84){
            [regionDic setValue:@1 forKey:@"coordType"];
        } else {
            [regionDic setValue:@2 forKey:@"coordType"];
        }
        
        if ([NSStringFromClass(region.class) isEqualToString:NSStringFromClass([BMKGeoFenceCircleRegion class])]) {
            
            BMKGeoFenceCircleRegion *circle = (BMKGeoFenceCircleRegion *)region;
            [regionDic setValue:@0 forKey:@"geofenceStyle"];
            [regionDic setValue:@{@"latitude": @(circle.center.latitude), @"longitude": @(circle.center.longitude)} forKey:@"centerCoordinate"];
            [regionDic setValue:@(circle.radius) forKey:@"radius"];
        } else if ([NSStringFromClass(region.class) isEqualToString:NSStringFromClass([BMKGeoFencePolygonRegion class])]) {
            
            BMKGeoFencePolygonRegion *polygon = (BMKGeoFencePolygonRegion *)region;
            NSMutableArray *coords = [NSMutableArray array];
            for (int i = 0; i < polygon.count; i++) {
                
                NSDictionary *dic = @{@"latitude": @(polygon.coordinates[i].latitude), @"longitude": @(polygon.coordinates[i].longitude)};
                [coords addObject:dic];
            }
            [regionDic setValue:coords forKey:@"coordinateList"];
            [regionDic setValue:@(coords.count) forKey:@"coordinateCount"];
            [regionDic setValue:@1 forKey:@"geofenceStyle"];
        }
        [results addObject:regionDic];
    }
    return [results copy];
}

- (void)BMKGeoFenceManager:(BMKGeoFenceManager * _Nonnull)manager doRequestAlwaysAuthorization:(CLLocationManager * _Nonnull)locationManager {
    [locationManager requestAlwaysAuthorization];
}

- (NSString *)excludeNil:(NSString *)str{
    
    if ([str isKindOfClass:[NSString class]]) {
        if (str !=nil &&
            ![str isEqualToString:@"(null)"] &&
            ![str isEqualToString:@""] &&
            ![str isEqualToString:@"<null>"]){
            return str;
        } else {
            return @"";
        }
    } else if ([str isKindOfClass:[NSNumber class]]){
        return [NSString stringWithFormat:@"%@", str];
    } else {
        return @"";
    }
}


@end
