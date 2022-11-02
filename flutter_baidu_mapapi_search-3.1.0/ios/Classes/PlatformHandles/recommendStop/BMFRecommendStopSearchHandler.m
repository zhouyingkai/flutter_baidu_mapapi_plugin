//
//  BMFRecommendStopSearchHandler.m
//  flutter_baidu_mapapi_search
//
//  Created by Zhang,Baojin on 2020/11/12.
//

#import "BMFRecommendStopSearchHandler.h"
#import <BaiduMapAPI_Search/BMKRecommendStopSearch.h>
#import <flutter_baidu_mapapi_base/BMFMapModels.h>
#import <flutter_baidu_mapapi_base/BMFDefine.h>

#import "BMFSearchHandles.h"
#import "BMFSearchMethodConst.h"
#import "BMFRecommendStopSearch.h"

@interface BMFRecommendStopSearchHandler ()<BMKRecommendStopSearchDelegate>

@end
@implementation BMFRecommendStopSearchHandler

@synthesize _channel;

- (nonnull NSObject<BMFSearchHandle> *)initWith:(nonnull FlutterMethodChannel *)channel {
    _channel = channel;
    return self;
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if ([call.method isEqualToString:kBMFRecommendStopSearchMethod]) {
        BMKRecommendStopSearch *search = [BMKRecommendStopSearch new];
        search.delegate = self;
        BMFRecommendStopSearchOption *option = [BMFRecommendStopSearchOption bmf_modelWith:[call.arguments safeObjectForKey:@"recommendStopSearchOption"]];
        BOOL flag = [search recommendStopSearch:[option toBMKRecommendStopSearchOption]];
         result(@{@"result":@(flag)});
    } else {
        result(FlutterMethodNotImplemented);
    }
}

#pragma mark - BMKRecommendStopSearchDelegate
- (void)onGetRecommendStopResult:(BMKRecommendStopSearch *)searcher result:(BMKRecommendStopSearchResult *)recommendStopResult errorCode:(BMKSearchErrorCode)errorCode {
    if (!_channel) return;
    [[BMFSearchHandles defalutCenter].handlerArray removeObject:self];
    BMFRecommendStopSearchResult *res = [BMFRecommendStopSearchResult fromBMKRecommendStopSearchResult:recommendStopResult];
        [_channel invokeMethod:kBMFRecommendStopSearchMethod arguments:@{@"result" : [res bmf_toDictionary], @"errorCode" : @(errorCode)} result:nil];
}


- (void)dealloc {
    NSLog(@"----BMFRecommendStopSearchHandler-dealloc-----");
}

@end
