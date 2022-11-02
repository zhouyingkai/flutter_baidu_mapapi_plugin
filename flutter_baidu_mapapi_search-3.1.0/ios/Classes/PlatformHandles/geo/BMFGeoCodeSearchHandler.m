//
//  BMFGeoCodeSearchHandler.m
//  flutter_baidu_mapapi_base
//
//  Created by zhangbaojin on 2020/4/15.
//

#import "BMFGeoCodeSearchHandler.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <flutter_baidu_mapapi_base/BMFMapModels.h>
#import <flutter_baidu_mapapi_base/BMFDefine.h>

#import "BMFSearchHandles.h"
#import "BMFSearchMethodConst.h"
#import "BMFGeocodeSearch.h"

@interface BMFGeoCodeSearchHandler ()<BMKGeoCodeSearchDelegate>

@end

@implementation BMFGeoCodeSearchHandler

@synthesize _channel;

- (nonnull NSObject<BMFSearchHandle> *)initWith:(nonnull FlutterMethodChannel *)channel {
    _channel = channel;
    return self;
}

// 通信回调
- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if ([call.method isEqualToString:kBMFGeoCodeSearchMethod]) {
        BMKGeoCodeSearch *search = [BMKGeoCodeSearch new];
        search.delegate = self;
        BMFGeocodeSearchOption *option = [BMFGeocodeSearchOption bmf_modelWith:[call.arguments safeObjectForKey:@"geoCodeSearchOption"]];

        BOOL flag = [search geoCode:[option toBMKGeoCodeSearchOption]];
        result(@{@"result" : @(flag)});
    } else if ([call.method isEqualToString:kBMFReverseGeoCodeSearchMethod]) {
        BMKGeoCodeSearch *search = [BMKGeoCodeSearch new];
        search.delegate = self;

        BMFReverseGeoCodeSearchOption *option = [BMFReverseGeoCodeSearchOption bmf_modelWith:[call.arguments safeObjectForKey:@"reverseGeoCodeSearchOption"]];
        BOOL flag = [search reverseGeoCode:[option toBMKReverseGeoCodeSearchOption]];
        result(@{@"result" : @(flag)});
    } else {
        result(FlutterMethodNotImplemented);
    }

}

#pragma mark - BMKGeoCodeSearchDelegate

- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeSearchResult *)result errorCode:(BMKSearchErrorCode)error {
    if (!_channel) return;
    [[BMFSearchHandles defalutCenter].handlerArray removeObject:self];
    BMFGeoCodeSearchResult *res = [BMFGeoCodeSearchResult fromBMKGeoCodeSearchResult:result];
    [_channel invokeMethod:kBMFGeoCodeSearchMethod arguments:@{@"result" : [res bmf_toDictionary], @"errorCode" : @(error)} result:nil];
}

- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeSearchResult *)result errorCode:(BMKSearchErrorCode)error {
    if (!_channel) return;
    [[BMFSearchHandles defalutCenter].handlerArray removeObject:self];
    BMFReverseGeoCodeSearchResult *res = [BMFReverseGeoCodeSearchResult fromBMKReverseGeoCodeSearchResult:result];
    [_channel invokeMethod:kBMFReverseGeoCodeSearchMethod arguments:@{@"result" : [res bmf_toDictionary], @"errorCode" : @(error)} result:nil];
   
}

- (void)dealloc {
    NSLog(@"----BMFGeoCodeSearchHandler-dealloc-----");
}


@end

