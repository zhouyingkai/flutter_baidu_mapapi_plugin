//
//  BMFWeatherSearchHandler.m
//  flutter_baidu_mapapi_search
//
//  Created by Zhang,Baojin on 2020/11/13.
//

#import "BMFWeatherSearchHandler.h"
#import <BaiduMapAPI_Search/BMKWeatherSearch.h>
#import <flutter_baidu_mapapi_base/BMFMapModels.h>
#import <flutter_baidu_mapapi_base/BMFDefine.h>

#import "BMFSearchHandles.h"
#import "BMFSearchMethodConst.h"
#import "BMFWeatherSearch.h"

@interface BMFWeatherSearchHandler ()<BMKWeatherSearchDelegate>

@end

@implementation BMFWeatherSearchHandler

@synthesize _channel;

- (nonnull NSObject<BMFSearchHandle> *)initWith:(nonnull FlutterMethodChannel *)channel {
    _channel = channel;
    return self;
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if ([call.method isEqualToString:kBMFWeatherSearchMethod]) {
        BMKWeatherSearch *search = [BMKWeatherSearch new];
        search.delegate = self;
        BMFWeatherSearchOption *option = [BMFWeatherSearchOption bmf_modelWith:[call.arguments safeObjectForKey:@"weatherSearchOption"]];
        BOOL flag = [search weatherSearch:[option toBMKWeatherSearchOption]];
         result(@{@"result":@(flag)});
    } else {
        result(FlutterMethodNotImplemented);
    }
}

#pragma mark - BMKWeatherSearchDelegate
- (void)onGetWeatherResult:(BMKWeatherSearch *)searcher result:(BMKWeatherSearchResult *)result errorCode:(BMKSearchErrorCode)error {
    if (!_channel) return;
    [[BMFSearchHandles defalutCenter].handlerArray removeObject:self];
    BMFWeatherSearchResult *res = [BMFWeatherSearchResult fromBMKWeatherSearchResult:result];
        [_channel invokeMethod:kBMFWeatherSearchMethod arguments:@{@"result" : [res bmf_toDictionary], @"errorCode" : @(error)} result:nil];
}

- (void)dealloc{
    NSLog(@"----BMFWeatherSearchHandler-dealloc-----");
}


@end
