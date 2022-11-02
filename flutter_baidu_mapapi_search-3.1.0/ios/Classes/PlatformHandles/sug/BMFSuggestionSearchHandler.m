//
//  BMFSuggestionSearchHandler.m
//  flutter_baidu_mapapi_base
//
//  Created by zhangbaojin on 2020/4/15.
//

#import "BMFSuggestionSearchHandler.h"

#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <flutter_baidu_mapapi_base/BMFMapModels.h>
#import <flutter_baidu_mapapi_base/BMFDefine.h>

#import "BMFSearchHandles.h"
#import "BMFSearchMethodConst.h"
#import "BMFSuggestionSearch.h"

@interface BMFSuggestionSearchHandler ()<BMKSuggestionSearchDelegate>

@end

@implementation BMFSuggestionSearchHandler

@synthesize _channel;

- (nonnull NSObject<BMFSearchHandle> *)initWith:(nonnull FlutterMethodChannel *)channel {
    _channel = channel;
    return self;
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if ([call.method isEqualToString:kBMFSuggestionSearchMethod]) {
        BMKSuggestionSearch *search = [BMKSuggestionSearch new];
        search.delegate = self;
        BMFSuggestionSearchOption *option = [BMFSuggestionSearchOption bmf_modelWith:[call.arguments safeObjectForKey:@"suggestionSearchOption"]];
        BOOL flag = [search suggestionSearch:[option toBMKSuggestionSearchOption]];
         result(@{@"result":@(flag)});
    } else {
        result(FlutterMethodNotImplemented);
    }
}

#pragma mark - BMKSuggestionSearchDelegate

- (void)onGetSuggestionResult:(BMKSuggestionSearch *)searcher result:(BMKSuggestionSearchResult *)result errorCode:(BMKSearchErrorCode)error {
    if (!_channel) return;
    [[BMFSearchHandles defalutCenter].handlerArray removeObject:self];
    BMFSuggestionSearchResult *res = [BMFSuggestionSearchResult fromBMKSuggestionSearchResult:result];
    [_channel invokeMethod:kBMFSuggestionSearchMethod arguments:@{@"result" : [res bmf_toDictionary], @"errorCode" : @(error)} result:nil];
}

- (void)dealloc{
    NSLog(@"----BMFSuggestionSearchHandler-dealloc-----");
}

@end
