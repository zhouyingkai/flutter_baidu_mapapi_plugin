//
//  BMFBuildingSearchHandler.m
//  flutter_baidu_mapapi_search
//
//  Created by zhangbaojin on 2022/1/6.
//

#import "BMFBuildingSearchHandler.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <flutter_baidu_mapapi_base/BMFMapModels.h>
#import <flutter_baidu_mapapi_base/BMFDefine.h>

#import "BMFSearchHandles.h"
#import "BMFSearchMethodConst.h"
#import "BMFBuildingSearch.h"

@interface BMFBuildingSearchHandler ()<BMKBuildingSearchDelegate>

@end

@implementation BMFBuildingSearchHandler

@synthesize _channel;

- (nonnull NSObject<BMFSearchHandle> *)initWith:(nonnull FlutterMethodChannel *)channel {
    _channel = channel;
    return self;
}

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    if ([call.method isEqualToString:kBMFBuildingSearchMethod]) {
        BMKBuildingSearch *search = [BMKBuildingSearch new];
        search.delegate = self;
        BMFBuildingSearchOption *option = [BMFBuildingSearchOption bmf_modelWith:[call.arguments safeObjectForKey:@"buildingSearchOption"]];
        BOOL flag = [search buildingSearch:[option toBMKBuildingSearchOption]];
         result(@{@"result":@(flag)});
    } else {
        result(FlutterMethodNotImplemented);
    }
}

#pragma mark - BMKBuildingSearchDelegate

- (void)onGetBuildingResult:(BMKBuildingSearch *)searcher result:(BMKBuildingSearchResult *)result errorCode:(BMKSearchErrorCode)error {
    if (!_channel) return;
    [[BMFSearchHandles defalutCenter].handlerArray removeObject:self];
    BMFBuildingSearchResult *res = [BMFBuildingSearchResult fromBMKBuildingSearchResult:result];
    [_channel invokeMethod:kBMFBuildingSearchMethod arguments:@{@"result" : [res bmf_toDictionary], @"errorCode" : @(error)} result:nil];
}

- (void)dealloc {
    NSLog(@"----BMFBuildingSearchHandler-dealloc-----");
}

@end
