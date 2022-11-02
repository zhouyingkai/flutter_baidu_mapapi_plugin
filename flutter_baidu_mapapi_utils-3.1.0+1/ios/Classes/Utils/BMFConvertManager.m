//
//  BMFConvertManager.m
// flutter_baidu_mapapi_utils
//
//  Created by zhangbaojin on 2020/4/13.
//

#import "BMFConvertManager.h"
#import "BMFConvertHandles.h"
#import <flutter_baidu_mapapi_base/BMFDefine.h>

static NSString *kBMFConvertChannelName = @"flutter_bmfutils/calculate";

@implementation BMFConvertManager
+ (void)registerWithRegistrar:(nonnull NSObject<FlutterPluginRegistrar> *)registrar {
    FlutterMethodChannel *convertChannel = [FlutterMethodChannel methodChannelWithName:kBMFConvertChannelName binaryMessenger:[registrar messenger]];
    BMFConvertManager *manager = [[BMFConvertManager alloc] init];
    manager.channel = convertChannel;
    [registrar addMethodCallDelegate:manager channel:convertChannel];
}

// 通信回调
- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
//    NSLog(@"ios-utils-convert-method = %@ \n arguments = %@", call.method, call.arguments);

    BMFConvertHandles *handleCenter = [BMFConvertHandles defalutCenter];
    NSArray *methods = [handleCenter.convertHandles allKeys];
    if ([methods containsObject:call.method]) {
        NSObject<BMFUtilsHandle> *handle = [NSClassFromString(handleCenter.convertHandles[call.method]) new];
        [handle handleMethodCall:call result:result];
    } else {
        result(FlutterMethodNotImplemented);
    }
}
@end
