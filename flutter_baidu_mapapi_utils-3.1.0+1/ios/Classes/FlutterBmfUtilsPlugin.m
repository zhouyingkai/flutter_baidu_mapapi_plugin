#import "FlutterBmfUtilsPlugin.h"
#import <BaiduMapAPI_Utils/BMKUtilsVersion.h>
#import <flutter_baidu_mapapi_base/BMFDefine.h>

#import "BMFOpenManager.h"
#import "BMFConvertManager.h"

@implementation FlutterBmfUtilsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:@"flutter_bmfutils"
                                                              binaryMessenger:[registrar messenger]];
    FlutterBmfUtilsPlugin *instance = [[FlutterBmfUtilsPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
    
    // open 注册
    [BMFOpenManager registerWithRegistrar:registrar];
    // convert 注册
    [BMFConvertManager registerWithRegistrar:registrar];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
//    NSLog(@"-ios-call.method = %@", call.method);
    if ([call.method isEqualToString:@"flutter_bmfutils/utils/getNativeUtilsVersion"]) {
        result(@{@"platform" : @"ios", @"component" : @"utils", @"version" : BMKGetMapApiUtilsComponentVersion()});
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end
