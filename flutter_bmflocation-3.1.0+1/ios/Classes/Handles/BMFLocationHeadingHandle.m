//
//  BMFLocationHeadingHandle.m
//  flutter_bmflocation
//
//  Created by v_wangdachuan on 2022/4/6.
//

#import "BMFLocationHeadingHandle.h"
#import "BMFLocationMethodConst.h"
#import "BMFLocationChannelHandle.h"

@interface BMFLocationHeadingHandle ()<BMKLocationManagerDelegate>
{
    double _heading;
}
@property (nonatomic, strong) BMKLocationManager *locationManager;
@end

@implementation BMFLocationHeadingHandle

@synthesize _locManager;
@synthesize _channel;

- (NSObject<BMFLocationHandle> *)initWithManager:(BMKLocationManager *)manager channel:(FlutterMethodChannel *)channel {
    _locationManager = [[BMKLocationManager alloc] init];
    _channel = channel;
    _locationManager.delegate = self;
    return self;
}


- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    
    if ([call.method isEqualToString:kBMFLocationHeadingAvailable]) {
        
        result(@{@"result":@([BMKLocationManager headingAvailable])});
    } else if ([call.method isEqualToString:kBMFLocationStartHeading]) {
        
        if ([BMKLocationManager headingAvailable]) {
            [_locationManager startUpdatingHeading];
        }
        result(@{@"result":@(YES)});
    } else if ([call.method isEqualToString:kBMFLocationStopHeading]) {
        
        if ([BMKLocationManager headingAvailable]) {
            [_locationManager stopUpdatingHeading];
        }
        result(@{@"result":@(YES)});
    } else {
        
        result(FlutterMethodNotImplemented);
    }
}


- (BOOL)BMKLocationManagerShouldDisplayHeadingCalibration:(BMKLocationManager * _Nonnull)manager {
    return YES;
}

- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager
          didUpdateHeading:(CLHeading * _Nullable)heading {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];

    // 定位时间
    if (heading) {
        // 地磁北，磁方向
        [dic setObject:@(heading.magneticHeading) forKey:@"magneticHeading"];
        // 地理北极，地图一般使用这个
        [dic setObject:@(heading.trueHeading) forKey:@"trueHeading"];
        // 偏差，-1代表无效
        [dic setObject:@(heading.headingAccuracy) forKey:@"headingAccuracy"];
        
        [dic setObject:@(heading.x) forKey:@"x"];
        [dic setObject:@(heading.y) forKey:@"y"];
        [dic setObject:@(heading.z) forKey:@"z"];
        [dic setObject:[self getFormatTime:heading.timestamp] forKey:@"timestamp"];
    }
    
    [BMFLocationChannelHandle sendResultCallbackChannel:_channel methodId:kBMFLocationStartHeading result:dic errorCode:0];
}


- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager doRequestAlwaysAuthorization:(CLLocationManager * _Nonnull)locationManager {
    [locationManager requestAlwaysAuthorization];
}

#pragma mark utils
- (NSString *)getFormatTime:(NSDate*)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *timeString = [formatter stringFromDate:date];
    return timeString;
}

@end
