//
//  BMFLocationResultHandle.m
//  flutter_bmflocation
//
//  Created by v_wangdachuan on 2022/1/22.
//

#import "BMFLocationResultHandle.h"
#import "BMFLocationMethodConst.h"
#import "BMFLocationMethodHandles.h"
#import "BMFLocationChannelHandle.h"
#import "BMKLocationkit/BMKLocationComponent.h"


#define kNotNull(notNull) [self excludeNil:notNull]

@interface BMFLocationResultHandle ()<BMFLocationHandle, BMKLocationManagerDelegate>


@end

@implementation BMFLocationResultHandle
@synthesize _channel;
@synthesize _locManager;

- (NSObject<BMFLocationHandle> *)initWithManager:(BMKLocationManager *)manager channel:(FlutterMethodChannel *)channel {
    _channel = channel;
    _locManager = manager;
    _locManager.delegate = self;
    return self;
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    
    if ([call.method isEqualToString:kBMFLocationSeriesLoc]) {
        
        [_locManager startUpdatingLocation];
        result(@{@"result":@(YES)});
    } else if ([call.method isEqualToString:kBMFLocationStopLoc]) {
        
        [_locManager stopUpdatingLocation];
        result(@{@"result":@(YES)});
        [[BMFLocationMethodHandles defalutCenter].handlerDictionary removeObjectForKey:NSStringFromClass([self class])];
        
    } else if ([call.method isEqualToString:kBMFLocationSingleLoc]) {
        
        BOOL isReGeocode = YES;
        BOOL isNetworkState = YES;
        
        if ([call.arguments allKeys] > 0) {
            if ([[call.arguments allKeys] containsObject:@"isReGeocode"]) {
                isReGeocode = [call.arguments[@"isReGeocode"] boolValue];
            }
            if ([[call.arguments allKeys] containsObject:@"isNetworkState"]) {
                isNetworkState = [call.arguments[@"isNetworkState"] boolValue];
            }
        }

        //单次定位block
        __weak typeof(self) weakSelf = self;
        [_locManager requestLocationWithReGeocode:isReGeocode withNetworkState:isNetworkState completionBlock:^(BMKLocation * _Nullable location, BMKLocationNetworkState state, NSError * _Nullable error) {
            
            //解析结果
            [weakSelf analyseLocationData:location seriesLoc:NO error:error complete:^() {
                [[BMFLocationMethodHandles defalutCenter].handlerDictionary removeObjectForKey:NSStringFromClass([weakSelf class])];
            }];
        }];
        result(@{@"result":@(YES)});
        
    } else {
        
        result(FlutterMethodNotImplemented);
    }
}

- (void)BMKLocationManager:(BMKLocationManager *)manager didUpdateLocation:(BMKLocation *)location orError:(NSError *)error {
    //解析结果
    [self analyseLocationData:location seriesLoc:YES error:error complete:^() {
    }];
}

- (void)analyseLocationData:(BMKLocation *)location seriesLoc:(BOOL)seriesLoc error:(NSError *)error complete:(void(^)(void))callback{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];

    if (error) {
//        NSLog(@"bdmap_loc_flutter_plugin:updateLocationFaild:{%ld - %@};",(long)error.code, error.localizedDescription);
        [dic setObject:[NSString stringWithFormat:@"bdmap_loc_flutter_plugin:updateLocationFaild:%@;", error.localizedDescription] forKey:@"errorInfo"];
        [dic setObject:[NSString stringWithFormat:@"%ld", (long)error.code] forKey:@"errorCode"];
        [dic setObject:kNotNull([self getFormatTime:[NSDate date]]) forKey:@"callbackTime"];
        
        [BMFLocationChannelHandle sendResultCallbackChannel:_channel methodId:seriesLoc ? kBMFLocationSeriesLoc : kBMFLocationSingleLoc result:dic errorCode:error.code];
        callback();
    }
    
    if (location) {
        
        //作弊概率
        [dic setObject:@(location.mockProbability) forKey:@"probability"];
        // 航向
        [dic setObject:@(location.location.course) forKey:@"course"];
        // 定位时间
        if (location.location.timestamp) {
            [dic setObject:kNotNull([self getFormatTime:location.location.timestamp]) forKey:@"locTime"];
        }
        // 垂直精度
        if (location.location.horizontalAccuracy) {
            [dic setObject:@(location.location.horizontalAccuracy) forKey:@"horizontalAccuracy"];
        }
        // 水平精度
        if (location.location.verticalAccuracy) {
            [dic setObject:@(location.location.verticalAccuracy) forKey:@"verticalAccuracy"];
        }
        // 纬度
        if (location.location.coordinate.latitude) {
            [dic setObject:@(location.location.coordinate.latitude) forKey:@"latitude"];
        }
        // 经度
        if (location.location.coordinate.longitude) {
            [dic setObject:@(location.location.coordinate.longitude) forKey:@"longitude"];
        }
        // 海拔高度
        if (location.location.altitude) {
            [dic setObject:@(location.location.altitude) forKey:@"altitude"];
        }
        // 速度 m/s
        if (location.location.speed) {
            [dic setObject:@(location.location.speed) forKey:@"speed"];
        }

        [dic setObject:kNotNull(location.locationID) forKey:@"locationID"];

        if (location.rgcData) {
            // 国家
            [dic setObject:kNotNull([location.rgcData country])  forKey:@"country"];
            // 省份
            [dic setObject:kNotNull([location.rgcData province]) forKey:@"province"];
            // 城市
            [dic setObject:kNotNull([location.rgcData city]) forKey:@"city"];
            // 区县
            [dic setObject:kNotNull([location.rgcData district]) forKey:@"district"];
            //城镇
            [dic setObject:kNotNull([location.rgcData town]) forKey:@"town"];
            // 街道
            [dic setObject:kNotNull([location.rgcData street]) forKey:@"street"];
            [dic setObject:kNotNull([location.rgcData locationDescribe]) forKey:@"locationDetail"];
            [dic setObject:kNotNull([location.rgcData cityCode]) forKey:@"cityCode"];
            [dic setObject:kNotNull([location.rgcData adCode]) forKey:@"adCode"];
            [dic setObject:kNotNull([location.rgcData streetNumber]) forKey:@"streetNumber"];
            

            //周边poi
            NSMutableArray *poiList = [NSMutableArray array];
            for (int i = 0; i < location.rgcData.poiList.count; i++) {
                
                NSMutableDictionary *poiDic = [NSMutableDictionary dictionary];
                BMKLocationPoi *poi = [location.rgcData.poiList objectAtIndex:i];
                if (poi) {
                    [poiDic setObject:kNotNull(poi.uid) forKey:@"uid"];
                    [poiDic setObject:kNotNull(poi.name) forKey:@"name"];
                    [poiDic setObject:kNotNull(poi.tags) forKey:@"tags"];
                    [poiDic setObject:kNotNull(poi.addr) forKey:@"addr"];
                }
                
                [poiList addObject:poiDic];
            }
            
            if (poiList.count > 0) {
                [dic setObject:poiList forKey:@"pois"];
            }
            
            //当前位置poi信息
            if (location.rgcData.poiRegion) {
                NSMutableDictionary *poiDic = [NSMutableDictionary dictionary];
                [poiDic setObject:kNotNull(location.rgcData.poiRegion.directionDesc) forKey:@"directionDesc"];
                [poiDic setObject:kNotNull(location.rgcData.poiRegion.name) forKey:@"name"];
                [poiDic setObject:kNotNull(location.rgcData.poiRegion.tags) forKey:@"tags"];
                [dic setObject:poiDic forKey:@"poiRegion"];
            }
            
            //兼容旧版本poiList
            if (location.rgcData.poiList && location.rgcData.poiList.count > 0) {
                NSString* poilist = @"";
                if (location.rgcData.poiList.count == 1) {
                    for (BMKLocationPoi * poi in location.rgcData.poiList) {
                        poilist = [[poi name] stringByAppendingFormat:@",%@,%@", [poi tags], [poi addr]];
                    }
                } else {
                    for (int i = 0; i < location.rgcData.poiList.count - 1; i++) {
                        poilist = [poilist stringByAppendingFormat:@"%@,%@,%@|", location.rgcData.poiList[i].name, location.rgcData.poiList[i].tags, location.rgcData.poiList[i].addr];
                    }
                    poilist = [poilist stringByAppendingFormat:@"%@,%@,%@", location.rgcData.poiList[location.rgcData.poiList.count-1].name, location.rgcData.poiList[location.rgcData.poiList.count-1].tags, location.rgcData.poiList[location.rgcData.poiList.count-1].addr];
                }
                dic[@"poiList"] = poilist; // 周边poi信息
            }
        }
        
    } else {
        [dic setObject: @1 forKey:@"errorCode"]; // 定位结果错误码
        [dic setObject:@"location is null" forKey:@"errorInfo"]; // 定位错误信息
    }
    
    [dic setObject:kNotNull([self getFormatTime:[NSDate date]]) forKey:@"callbackTime"];
    
    // 定位结果回调
    [BMFLocationChannelHandle sendResultCallbackChannel:_channel methodId:seriesLoc ? kBMFLocationSeriesLoc : kBMFLocationSingleLoc result:dic errorCode:0];
    callback();
}

#pragma mark utils
- (NSString *)getFormatTime:(NSDate*)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *timeString = [formatter stringFromDate:date];
    return timeString;
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
