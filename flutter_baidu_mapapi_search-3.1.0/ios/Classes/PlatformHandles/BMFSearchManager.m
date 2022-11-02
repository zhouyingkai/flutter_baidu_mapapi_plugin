//
//  BMFSearchManager.m
//  flutter_baidu_mapapi_search
//
//  Created by zhangbaojin on 2020/4/15.
//

#import "BMFSearchManager.h"
#import <BaiduMapAPI_Search/BMKSearchVersion.h>
#import <flutter_baidu_mapapi_base/BMFDefine.h>

#import "BMFSearchMethodConst.h"
#import "BMFSearchHandles.h"

@implementation BMFSearchManager

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
        FlutterMethodChannel *searchChannel = [FlutterMethodChannel methodChannelWithName:@"flutter_bmfsearch" binaryMessenger:[registrar messenger]];
    
    BMFSearchManager *instance = [BMFSearchManager new];
    instance.channel = searchChannel;
    
    [registrar addMethodCallDelegate:instance channel:searchChannel];
}

// 通信回调
- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSLog(@"-ios-search-call.method = %@", call.method);
    
    BMFSearchHandles *defaultCenter = [BMFSearchHandles defalutCenter];
    NSArray *methods = [[defaultCenter searchHandles] allKeys];
    
    if ([methods containsObject:call.method]) {
        NSObject<BMFSearchHandle> *handler = [[NSClassFromString(defaultCenter.searchHandles[call.method]) new] initWith:_channel];
        [defaultCenter.handlerArray addObject:handler];
        [handler handleMethodCall:call result:result];
    } else if ([call.method isEqualToString:kBMFGetSearchVersionMethod]) {
        result(@{@"platform" : @"ios", @"component" : @"search", @"version" : BMKGetMapApiSearchComponentVersion()});
    } else {
        result(FlutterMethodNotImplemented);
    }
    
}

@end
