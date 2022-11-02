//
//  BMFAuxiliaryFunctionHandle.m
//  flutter_bmflocation
//
//  Created by v_wangdachuan on 2022/2/17.
//

#import "BMFAuxiliaryFunctionHandle.h"
#import "BMFLocationMethodConst.h"
#import "BMFLocationMethodHandles.h"
#import "BMFLocationChannelHandle.h"

@interface BMFAuxiliaryFunctionHandle ()<BMKLocationManagerDelegate>

@end

@implementation BMFAuxiliaryFunctionHandle
@synthesize _locManager;
@synthesize _channel;

- (NSObject<BMFLocationHandle> *)initWithManager:(BMKLocationManager *)manager channel:(FlutterMethodChannel *)channel {
    _locManager = manager;
    _channel = channel;
    _locManager.delegate = self;
    return self;
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    
    if ([call.method isEqualToString:kBMFLocationNetworkState]) {
        [_locManager requestNetworkState];
    } else {
        
        result(FlutterMethodNotImplemented);
    }
}



- (void)BMKLocationManager:(BMKLocationManager * _Nonnull)manager
     didUpdateNetworkState:(BMKLocationNetworkState)state orError:(NSError * _Nullable)error {
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
    if (error) {
        [resultDic setValue:0 forKey:@"state"];
    } else {
        switch (state) {
            case BMKLocationNetworkStateWifi:
                [resultDic setValue:@1 forKey:@"state"];
                break;
            case BMKLocationNetworkStateWifiHotSpot:
                [resultDic setValue:@2 forKey:@"state"];
                break;
            case BMKLocationNetworkStateMobile4G:
                [resultDic setValue:@5 forKey:@"state"];
                break;
            case BMKLocationNetworkStateMobile2G:
                [resultDic setValue:@3 forKey:@"state"];
                break;
            case BMKLocationNetworkStateMobile3G:
                [resultDic setValue:@4 forKey:@"state"];
                break;
            default:
                [resultDic setValue:@0 forKey:@"state"];
                break;
        }
    }
    
    [BMFLocationChannelHandle sendResultCallbackChannel:_channel methodId:kBMFLocationNetworkState result:resultDic errorCode:0];
    [[BMFLocationMethodHandles defalutCenter].handlerDictionary removeObjectForKey:NSStringFromClass([self class])];
}


@end
