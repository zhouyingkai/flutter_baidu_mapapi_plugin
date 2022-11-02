//
//  BMFBuslineSearchHandler.m
//  flutter_baidu_mapapi_base
//
//  Created by zhangbaojin on 2020/4/15.
//

#import "BMFBuslineSearchHandler.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <flutter_baidu_mapapi_base/BMFMapModels.h>
#import <flutter_baidu_mapapi_base/BMFDefine.h>

#import "BMFSearchHandles.h"
#import "BMFSearchMethodConst.h"
#import "BMFBusLineSearch.h"


@interface BMFBuslineSearchHandler ()<BMKBusLineSearchDelegate>

@end

@implementation BMFBuslineSearchHandler

@synthesize _channel;

- (nonnull NSObject<BMFSearchHandle> *)initWith:(nonnull FlutterMethodChannel *)channel {
    _channel = channel;
    return self;
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if ([call.method isEqualToString:kBMFBusLineSearchMethod]) {
        BMKBusLineSearch *search = [BMKBusLineSearch new];
        search.delegate = self;
        BMFBusLineSearchOption *option = [BMFBusLineSearchOption bmf_modelWith:[call.arguments safeObjectForKey:@"busLineSearchOption"]];
        BOOL flag = [search busLineSearch:[option toBMKBusLineSearchOption]];
        result(@{@"result" : @(flag)});
    } else {
        result(FlutterMethodNotImplemented);
    }

}

#pragma mark - BMKBusLineSearchDelegate

- (void)onGetBusDetailResult:(BMKBusLineSearch *)searcher result:(BMKBusLineResult *)busLineResult errorCode:(BMKSearchErrorCode)error {
    if (!_channel) return;
    [[BMFSearchHandles defalutCenter].handlerArray removeObject:self];
    BMFBusLineResult *res = [BMFBusLineResult fromBMKBusLineSearchResult:busLineResult];
    [_channel invokeMethod:kBMFBusLineSearchMethod arguments:@{@"result" : [res bmf_toDictionary], @"errorCode" : @(error)} result:nil];
}
- (void)dealloc {
    NSLog(@"----BMFBuslineSearchHandler-dealloc-----");
}

@end
