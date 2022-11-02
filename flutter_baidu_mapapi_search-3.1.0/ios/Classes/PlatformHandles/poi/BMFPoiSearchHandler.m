//
//  BMFPoiSearchHandler.m
//  flutter_baidu_mapapi_base
//
//  Created by zhangbaojin on 2020/4/15.
//

#import "BMFPoiSearchHandler.h"
#import "BMFSearchMethodConst.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <flutter_baidu_mapapi_base/BMFMapModels.h>
#import <flutter_baidu_mapapi_base/BMFDefine.h>

#import "BMFSearchHandles.h"
#import "BMFPoiSearchType.h"
#import "BMFPoiSearch.h"


@interface BMFPoiSearchHandler ()<BMKPoiSearchDelegate>
{
    int _searchType;
}

@end

@implementation BMFPoiSearchHandler

@synthesize _channel;

- (nonnull NSObject<BMFSearchHandle> *)initWith:(nonnull FlutterMethodChannel *)channel {
    _channel = channel;
    return self;
}
// 通信回调
- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {  
    if ([call.method isEqualToString:kBMFPoiSearchInCityMethod]) { // 城市POI检索
        _searchType = 0;
        BMKPoiSearch *search = [BMKPoiSearch new];
        search.delegate = self;
        BMFPOICitySearchOption *option = [BMFPOICitySearchOption bmf_modelWith:[call.arguments safeObjectForKey:@"poiCitySearchOption"]];
        BOOL flag = [search poiSearchInCity:[option toBMKPOICitySearchOption]];
        result(@{@"result" : @(flag)});
    } else if ([call.method isEqualToString:kBMFPoiSearchInboundsMethod]) {   // 根据范围和检索词发起范围检索
        _searchType = 1;
        BMKPoiSearch *search = [BMKPoiSearch new];
        search.delegate = self;
        BMFPOIBoundSearchOption *option = [BMFPOIBoundSearchOption bmf_modelWith:[call.arguments safeObjectForKey:@"poiBoundSearchOption"]];
        BOOL flag = [search poiSearchInbounds:[option toBMKPOIBoundSearchOption]];
         result(@{@"result" : @(flag)});
    } else if ([call.method isEqualToString:kBMFPoiSearchNearByMethod]) { // 根据中心点、半径和检索词发起周边检索
        _searchType = 2;
        BMKPoiSearch *search = [BMKPoiSearch new];
        search.delegate = self;
        BMFPOINearbySearchOption *option = [BMFPOINearbySearchOption bmf_modelWith:[call.arguments safeObjectForKey:@"poiNearbySearchOption"]];
        BOOL flag = [search poiSearchNearBy:[option toBMKPOINearbySearchOption]];
        result(@{@"result" : @(flag)});
    } else if ([call.method isEqualToString:kBMFPoiDetailSearchMethod]) { // 根据poi uid 发起poi详情检索
        BMKPoiSearch *search = [BMKPoiSearch new];
        search.delegate = self;
        BMFPOIDetailSearchOption *option = [BMFPOIDetailSearchOption bmf_modelWith:[call.arguments safeObjectForKey:@"poiDetailSearchOption"]];
        BOOL flag = [search poiDetailSearch:[option toBMKPOIDetailSearchOption]];
        result(@{@"result" : @(flag)});
    } else if ([call.method isEqualToString:kBMFPoiIndoorSearchMethod]) { // poi室内检索
        BMKPoiSearch *search = [BMKPoiSearch new];
        search.delegate = self;
        BMFPOIIndoorSearchOption *option = [BMFPOIIndoorSearchOption bmf_modelWith:[call.arguments safeObjectForKey:@"poiIndoorSearchOption"]];
        BOOL flag = [search poiIndoorSearch:[option toBMKPOIIndoorSearchOption]];
        result(@{@"result" : @(flag)});
    } else {
         result(FlutterMethodNotImplemented);
    }

}

#pragma mark - BMKPoiSearchDelegate

- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPOISearchResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode {
    if (!_channel) return;
    [[BMFSearchHandles defalutCenter].handlerArray removeObject:self];
    NSString *method;
    switch (_searchType) {
        case 0:
            method = kBMFPoiSearchInCityMethod;
            break;
        case 1:
            method = kBMFPoiSearchInboundsMethod;
            break;
        case 2:
            method = kBMFPoiSearchNearByMethod;
            break;
    }
    BMFPoiSearchResult *res = [BMFPoiSearchResult fromBMKPoiSearchResult:poiResult];
    [_channel invokeMethod:method arguments:@{@"result" : [res bmf_toDictionary], @"errorCode" : @(errorCode)} result:nil];

}

- (void)onGetPoiDetailResult:(BMKPoiSearch *)searcher result:(BMKPOIDetailSearchResult *)poiDetailResult errorCode:(BMKSearchErrorCode)errorCode {
    if (!_channel) return;
    [[BMFSearchHandles defalutCenter].handlerArray removeObject:self];
    BMFPOIDetailSearchResult *res = [BMFPOIDetailSearchResult fromBMKPOIDetailSearchResult:poiDetailResult];
    [_channel invokeMethod:kBMFPoiDetailSearchMethod arguments:@{@"result" : [res bmf_toDictionary], @"errorCode" : @(errorCode)} result:nil];
}

- (void)onGetPoiIndoorResult:(BMKPoiSearch *)searcher result:(BMKPOIIndoorSearchResult *)poiIndoorResult errorCode:(BMKSearchErrorCode)errorCode {
    if (!_channel) return;
    [[BMFSearchHandles defalutCenter].handlerArray removeObject:self];
    BMFPOIIndoorSearchResult *res = [BMFPOIIndoorSearchResult fromBMKPOIIndoorSearchResult:poiIndoorResult];
    [_channel invokeMethod:kBMFPoiIndoorSearchMethod arguments:@{@"result" : [res bmf_toDictionary], @"errorCode" : @(errorCode)} result:nil];
}

- (void)dealloc {
    NSLog(@"----BMFPoiSearchHandler-dealloc-----");
}

@end
