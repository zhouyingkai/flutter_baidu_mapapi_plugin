//
//  BMFShareURLSearchHandler.m
//  flutter_baidu_mapapi_base
//
//  Created by zhangbaojin on 2020/4/15.
//

#import "BMFShareURLSearchHandler.h"

#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <flutter_baidu_mapapi_base/BMFMapModels.h>
#import <flutter_baidu_mapapi_base/BMFDefine.h>

#import "BMFSearchHandles.h"
#import "BMFSearchMethodConst.h"
#import "BMFShareURLSearch.h"

@interface BMFShareURLSearchHandler ()<BMKShareURLSearchDelegate>

@end

@implementation BMFShareURLSearchHandler

@synthesize _channel;

- (nonnull NSObject<BMFSearchHandle> *)initWith:(nonnull FlutterMethodChannel *)channel {
    _channel = channel;
    return self;
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if ([call.method isEqualToString:kBMFPoiDetailShareURLMethod]) {
        BMKShareURLSearch *search = [BMKShareURLSearch new];
        search.delegate = self;
        BMFPoiDetailShareURLOption *option = [BMFPoiDetailShareURLOption bmf_modelWith:[call.arguments safeObjectForKey:@"poiDetailShareURLOption"]];
        
        BOOL flag = [search requestPoiDetailShareURL:[option toBMKPoiDetailShareURLOption]];
        result(@{@"result":@(flag)});
        
    } else if ([call.method isEqualToString:kBMFLocationShareURLMethod]) {
        BMKShareURLSearch *search = [BMKShareURLSearch new];
        search.delegate = self;
        BMFLocationShareURLOption *option = [BMFLocationShareURLOption bmf_modelWith:[call.arguments safeObjectForKey:@"reverseGeoShareURLOption"]];
        
        BOOL flag = [search requestLocationShareURL:[option toBMKLocationShareURLOption]];
        result(@{@"result":@(flag)});
        
    } else if ([call.method isEqualToString:kBMFRoutePlanShareURLMethod]) {
        BMKShareURLSearch *search = [BMKShareURLSearch new];
        search.delegate = self;
        BMFRoutePlanShareURLOption *option = [ BMFRoutePlanShareURLOption bmf_modelWith:[call.arguments safeObjectForKey:@"routePlanShareURLOption"]];
        
        BOOL flag = [search requestRoutePlanShareURL:[option toBMKRoutePlanShareURLOption]];
        result(@{@"result":@(flag)});
        
    } else {
        result(FlutterMethodNotImplemented);
    }
}

#pragma mark - BMKShareURLSearchDelegate

- (void)onGetPoiDetailShareURLResult:(BMKShareURLSearch *)searcher result:(BMKShareURLResult *)result errorCode:(BMKSearchErrorCode)error {
    if (!_channel) return;
    [[BMFSearchHandles defalutCenter].handlerArray removeObject:self];
    BMFShareURLResult *res = [BMFShareURLResult fromBMKShareURLResult:result];
    [_channel invokeMethod:kBMFPoiDetailShareURLMethod arguments:@{@"result" : [res bmf_toDictionary], @"errorCode" : @(error)} result:nil];
}

- (void)onGetLocationShareURLResult:(BMKShareURLSearch *)searcher result:(BMKShareURLResult *)result errorCode:(BMKSearchErrorCode)error {
    if (!_channel) return;
    [[BMFSearchHandles defalutCenter].handlerArray removeObject:self];
    BMFShareURLResult *res = [BMFShareURLResult fromBMKShareURLResult:result];
    [_channel invokeMethod:kBMFLocationShareURLMethod arguments:@{@"result" : [res bmf_toDictionary], @"errorCode" : @(error)} result:nil];
}

- (void)onGetRoutePlanShareURLResult:(BMKShareURLSearch *)searcher result:(BMKShareURLResult *)result errorCode:(BMKSearchErrorCode)error {
    if (!_channel) return;
    [[BMFSearchHandles defalutCenter].handlerArray removeObject:self];
    BMFShareURLResult *res = [BMFShareURLResult fromBMKShareURLResult:result];
    [_channel invokeMethod:kBMFRoutePlanShareURLMethod arguments:@{@"result" : [res bmf_toDictionary], @"errorCode" : @(error)} result:nil];

}

- (void)dealloc{
    NSLog(@"----BMFShareURLSearchHandler-dealloc-----");
}


@end
