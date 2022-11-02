//
//  BMFLocationOptionsHandle.m
//  flutter_bmflocation
//
//  Created by v_wangdachuan on 2022/1/22.
//

#import "BMFLocationOptionsHandle.h"
#import "BMFLocationMethodHandles.h"
#import "BMFLocationMethodConst.h"

#define kNotEmpty(objc) (objc != [NSNull null]) && objc

@implementation BMFLocationOptionsHandle

@synthesize _locManager;

- (NSObject<BMFLocationHandle> *)initWithManager:(BMKLocationManager *)manager channel:(FlutterMethodChannel *)channel {
    _locManager = manager;
    return self;
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    
    if ([call.method isEqualToString:kBMFLocationSetOptions]) {
        
        [self updateOptions:call.arguments result:result];
    } else {
        
        result(FlutterMethodNotImplemented);
    }
}

- (void)updateOptions:(NSDictionary *)arguments result:(FlutterResult)result{
    
    BOOL flag = NO;
    if (!_locManager) {
        result(@{@"result":@(flag)});
    }
    //坐标
    if ([[arguments allKeys] containsObject:@"BMKLocationCoordinateType"]) {
        [_locManager setCoordinateType:[ self getCoordinateType: arguments[@"BMKLocationCoordinateType"]]];
    }
    
    //坐标
    if ([arguments.allKeys containsObject:@"coordType"]) {
        if (kNotEmpty(arguments[@"coordType"])) {
            if ([arguments[@"coordType"] intValue] == 0) {
                _locManager.coordinateType = BMKLocationCoordinateTypeGCJ02;
            } else if ([arguments[@"coordType"] intValue] == 1) {
                _locManager.coordinateType = BMKLocationCoordinateTypeWGS84;
            } else {
                _locManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
            }
        }
    }
        
    // 设置期望定位精度
    if ([arguments.allKeys containsObject:@"desiredAccuracy"]) {
        if (kNotEmpty(arguments[@"desiredAccuracy"])) {
            if ([arguments[@"desiredAccuracy"] intValue] == 0) {
                _locManager.desiredAccuracy = kCLLocationAccuracyBest;
            } else if ([arguments[@"desiredAccuracy"] intValue] == 1) {
                _locManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
            } else if ([arguments[@"desiredAccuracy"] intValue] == 2) {                _locManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
            } else if ([arguments[@"desiredAccuracy"] intValue] == 3) {
                _locManager.desiredAccuracy = kCLLocationAccuracyKilometer;
            } else if ([arguments[@"desiredAccuracy"] intValue] == 4) {
                _locManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
            }
        }
    }
    
    // 设置定位的最小更新距离
    if ([arguments.allKeys containsObject:@"distanceFilter"]) {
        if (kNotEmpty(arguments[@"distanceFilter"])) {
            _locManager.distanceFilter = [arguments[@"distanceFilter"] doubleValue] < 0 ? kCLDistanceFilterNone : [arguments[@"distanceFilter"] doubleValue];
        }
    }
    
    // 设置应用位置类型
    if ([arguments.allKeys containsObject:@"activityType"]) {
        if (kNotEmpty(arguments[@"activityType"])) {
            if ([arguments[@"activityType"] intValue] == 0) {
                _locManager.activityType = CLActivityTypeOther;
            } else if ([arguments[@"activityType"] intValue] == 1) {
                _locManager.activityType = CLActivityTypeAutomotiveNavigation;
            } else if ([arguments[@"activityType"] intValue] == 2) {
                _locManager.activityType = CLActivityTypeFitness;
            } else if ([arguments[@"activityType"] intValue] == 3) {
                _locManager.activityType = CLActivityTypeOtherNavigation;
            } else if ([arguments[@"activityType"] intValue] == 4) {
                if (@available(iOS 12.0, *)) {
                    _locManager.activityType = CLActivityTypeAirborne;
                } else {
                    _locManager.activityType = CLActivityTypeAutomotiveNavigation;
                }
            }
        }
    }
    
    // 设置是否需要返回新版本rgc信息
    if ([arguments.allKeys containsObject:@"isNeedNewVersionRgc"]) {
        if (kNotEmpty(arguments[@"isNeedNewVersionRgc"])) {
            _locManager.isNeedNewVersionReGeocode = [arguments[@"isNeedNewVersionRgc"] boolValue];
        }
    }
    
    // 指定定位是否会被系统自动暂停
    if ([arguments.allKeys containsObject:@"pausesLocationUpdatesAutomatically"]) {
        if (kNotEmpty(arguments[@"pausesLocationUpdatesAutomatically"])) {
            _locManager.pausesLocationUpdatesAutomatically = [arguments[@"pausesLocationUpdatesAutomatically"] boolValue];
        }
    }
    
    // 设置是否允许后台定位
    if ([arguments.allKeys containsObject:@"allowsBackgroundLocationUpdates"]) {
        if (kNotEmpty(arguments[@"allowsBackgroundLocationUpdates"])) {
            _locManager.allowsBackgroundLocationUpdates = [arguments[@"allowsBackgroundLocationUpdates"] boolValue];
        }
    }
    
    
    // 设置定位超时时间
    if ([arguments.allKeys containsObject:@"locationTimeout"]) {
        if (kNotEmpty(arguments[@"locationTimeout"])) {
            [_locManager setLocationTimeout:[arguments[@"locationTimeout"] integerValue]];
        }
    }
    
    // 设置逆地理超时时间
    if ([arguments.allKeys containsObject:@"reGeocodeTimeout"]) {
        if (kNotEmpty(arguments[@"reGeocodeTimeout"])) {
            [_locManager setReGeocodeTimeout:[arguments[@"reGeocodeTimeout"] integerValue]];
        }
    }
    flag = YES;
    result(@{@"result":@(flag)});
    [[BMFLocationMethodHandles defalutCenter].handlerDictionary removeObjectForKey:NSStringFromClass([self class])];
}

/**
 获取设置的经纬度坐标系类型
 */
-(int)getCoordinateType:(NSString*)str{
    
    if ([@"BMKLocationCoordinateTypeBMK09LL" isEqualToString:str]) {
        return BMKLocationCoordinateTypeBMK09LL;
    } else if ([@"BMKLocationCoordinateTypeBMK09MC" isEqualToString:str]) {
        return BMKLocationCoordinateTypeBMK09MC;
    } else if ([@"BMKLocationCoordinateTypeWGS84" isEqualToString:str]) {
        return BMKLocationCoordinateTypeWGS84;
    } else if ([@"BMKLocationCoordinateTypeGCJ02" isEqualToString:str]) {
        return BMKLocationCoordinateTypeGCJ02;
    } else {
        return BMKLocationCoordinateTypeGCJ02;
    }
}

@end
