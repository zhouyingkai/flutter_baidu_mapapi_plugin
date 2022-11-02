//
//  BMFLocationAuthKeyHandle.m
//  flutter_bmflocation
//
//  Created by v_wangdachuan on 2022/1/27.
//

#import "BMFLocationAuthKeyHandle.h"
#import "BMKLocationkit/BMKLocationComponent.h"
#import "BMFLocationMethodHandles.h"
#import "BMFLocationMethodConst.h"
#import "BMFLocationChannelHandle.h"

@interface BMFLocationAuthKeyHandle ()<BMKLocationAuthDelegate>

@end

@implementation BMFLocationAuthKeyHandle
@synthesize _locManager;
@synthesize _channel;

- (NSObject<BMFLocationHandle> *)initWithManager:(BMKLocationManager *)manager channel:(FlutterMethodChannel *)channel {
    _locManager = manager;
    _channel = channel;
    return self;
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    
    if ([call.method isEqualToString:kBMFLocationSetAK]) {
        
        __weak __typeof(self)weakSelf = self;
        [[BMKLocationAuth sharedInstance] checkPermisionWithKey:call.arguments authDelegate:weakSelf];
        BOOL flag = YES;
        result(@{@"result":@(flag)});
    } else if ([call.method isEqualToString:kBMFLocationSetAgreePrivacy]) {
      
        NSInteger isAgree = [call.arguments integerValue];
        [[BMKLocationAuth sharedInstance] setAgreePrivacy:isAgree];
        BOOL flag = YES;
        result(@{@"result":@(flag)});
        
    } else {
        
        result(FlutterMethodNotImplemented);
    }
}

//鉴权代理回调
- (void)onCheckPermissionState:(BMKLocationAuthErrorCode)iError {
    
    [BMFLocationChannelHandle sendResultCallbackChannel:_channel methodId:kBMFLocationSetAK result:[NSString stringWithFormat:@"PermissionState:%ld", (long)iError] errorCode:iError];
    [[BMFLocationMethodHandles defalutCenter].handlerDictionary removeObjectForKey:NSStringFromClass([self class])];
}

@end
