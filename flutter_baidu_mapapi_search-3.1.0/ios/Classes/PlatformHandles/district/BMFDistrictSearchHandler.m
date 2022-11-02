//
//  BMFDistrictSearchHandler.m
//  flutter_baidu_mapapi_base
//
//  Created by zhangbaojin on 2020/4/15.
//

#import "BMFDistrictSearchHandler.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <flutter_baidu_mapapi_base/BMFMapModels.h>
#import <flutter_baidu_mapapi_base/BMFDefine.h>

#import "BMFSearchHandles.h"
#import "BMFSearchMethodConst.h"
#import "BMFDistrictSearch.h"

@interface BMFDistrictSearchHandler ()<BMKDistrictSearchDelegate>

@end

@implementation BMFDistrictSearchHandler

@synthesize _channel;

- (nonnull NSObject<BMFSearchHandle> *)initWith:(nonnull FlutterMethodChannel *)channel {
    _channel = channel;
    return self;
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if ([call.method isEqualToString:kBMFDistrictSearchMethod]) {
        BMKDistrictSearch *search = [BMKDistrictSearch new];
        search.delegate = self;
        BMFDistrictSearchOption *option = [BMFDistrictSearchOption bmf_modelWith:[call.arguments safeObjectForKey:@"districtSearchOption"]];
        BOOL flag = [search districtSearch:[option toBMKDistrictSearchOption]];
        result(@{@"result" : @(flag)});
    } else {
        result(FlutterMethodNotImplemented);
    }

}
#pragma mark - BMKDistrictSearchDelegate

- (void)onGetDistrictResult:(BMKDistrictSearch *)searcher result:(BMKDistrictResult *)result errorCode:(BMKSearchErrorCode)error {
    if (!_channel) return;
    [[BMFSearchHandles defalutCenter].handlerArray removeObject:self];
    BMFDistrictSearchResult *res = [BMFDistrictSearchResult fromBMKDistrictSearchResult:result];
    [_channel invokeMethod:kBMFDistrictSearchMethod arguments:@{@"result" : [res bmf_toDictionary], @"errorCode" : @(error)} result:nil];
}

- (void)dealloc {
    NSLog(@"----BMFDistrictSearchHandler-dealloc-----");
}


@end
