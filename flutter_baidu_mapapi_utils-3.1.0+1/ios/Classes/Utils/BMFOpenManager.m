//
//  BMFOpenManager.m
// flutter_baidu_mapapi_utils
//
//  Created by zhangbaojin on 2020/4/13.
//

#import "BMFOpenManager.h"
#import "BMFOpenHandles.h"
#import <flutter_baidu_mapapi_base/BMFDefine.h>

static NSString *kBMFOpenChannelName = @"flutter_bmfutils/open";

@implementation BMFOpenManager
+ (void)registerWithRegistrar:(nonnull NSObject<FlutterPluginRegistrar> *)registrar {
    FlutterMethodChannel *openChannel = [FlutterMethodChannel methodChannelWithName:kBMFOpenChannelName binaryMessenger:[registrar messenger]];
    BMFOpenManager *manager = [[BMFOpenManager alloc] init];
    manager.channel = openChannel;
    [registrar addMethodCallDelegate:manager channel:openChannel];
}

// 通信回调
- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
//    NSLog(@"ios-utils-open-method = %@ \n arguments = %@", call.method, call.arguments);
    BMFOpenHandles *handleCenter = [BMFOpenHandles defalutCenter];
    NSArray *methods = [handleCenter.openHandles allKeys];
    
    if ([methods containsObject:call.method]) {
        NSObject<BMFUtilsHandle> *handle = [NSClassFromString(handleCenter.openHandles[call.method]) new];
        [handle handleMethodCall:call result:result];
    } else {
        result(FlutterMethodNotImplemented);
    }
}
@end
