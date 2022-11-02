//
//  BMFRouteSearchHandler.m
//  flutter_baidu_mapapi_base
//
//  Created by zhangbaojin on 2020/4/15.
//

#import "BMFRouteSearchHandler.h"

#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Search/BMKRouteSearch.h>
#import <BaiduMapAPI_Search/BMKRouteSearchOption.h>
#import <BaiduMapAPI_Search/BMKRouteSearchResult.h>
#import <flutter_baidu_mapapi_base/BMFMapModels.h>
#import <flutter_baidu_mapapi_base/BMFDefine.h>

#import "BMFSearchHandles.h"
#import "BMFSearchMethodConst.h"
#import "BMFRouteSearch.h"


@interface BMFRouteSearchHandler ()<BMKRouteSearchDelegate>

@end

@implementation BMFRouteSearchHandler

@synthesize _channel;

- (nonnull NSObject<BMFSearchHandle> *)initWith:(nonnull FlutterMethodChannel *)channel {
    _channel = channel;
    return self;
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if ([call.method isEqualToString:kBMFTransitSearchMethod]) {
        BMKRouteSearch *search = [BMKRouteSearch new];
        search.delegate = self;
        BMFTransitRoutePlanOption *option = [BMFTransitRoutePlanOption bmf_modelWith:[call.arguments safeObjectForKey:@"transitRoutePlanOption"]];
        BOOL flag = [search transitSearch:[option toBMKTransitRoutePlanOption]];
        result(@{@"result" : @(flag)});
        
    } else if ([call.method isEqualToString:kBMFMassTransitSearchMethod]) {
        BMKRouteSearch *search = [BMKRouteSearch new];
        search.delegate = self;
        BMFMassTransitRoutePlanOption *option = [BMFMassTransitRoutePlanOption bmf_modelWith:[call.arguments safeObjectForKey:@"massTransitRoutePlanOption"]];
        BOOL flag = [search massTransitSearch:[option toBMKMassTransitRoutePlanOption]];
        result(@{@"result" : @(flag)});
        
    } else if ([call.method isEqualToString:kBMFDrivingSearchMethod]) {
        BMKRouteSearch *search = [BMKRouteSearch new];
        search.delegate = self;
        BMFDrivingRoutePlanOption *option = [BMFDrivingRoutePlanOption bmf_modelWith:[call.arguments safeObjectForKey:@"drivingRoutePlanOption"]];
        BOOL flag = [search drivingSearch:[option toBMKDrivingRoutePlanOption]];
        result(@{@"result" : @(flag)});
    } else if ([call.method isEqualToString:kBMFWalkingSearchMethod]) {
        BMKRouteSearch *search = [BMKRouteSearch new];
        search.delegate = self;
        BMFWalkingRoutePlanOption *option = [BMFWalkingRoutePlanOption bmf_modelWith:[call.arguments safeObjectForKey:@"walkingRoutePlanOption"]];
        BOOL flag = [search walkingSearch:[option toBMKWalkingRoutePlanOption]];
        result(@{@"result" : @(flag)});
    } else if ([call.method isEqualToString:kBMFRidingSearchMethod]) {
        BMKRouteSearch *search = [BMKRouteSearch new];
        search.delegate = self;
        BMFRidingRoutePlanOption *option = [BMFRidingRoutePlanOption bmf_modelWith:[call.arguments safeObjectForKey:@"ridingRoutePlanOption"]];
        BOOL flag = [search ridingSearch:[option toBMKRidingRoutePlanOption]];
        result(@{@"result" : @(flag)});
    } else if ([call.method isEqualToString:kBMFIndoorRoutePlanSearchMethod]) {
        BMKRouteSearch *search = [BMKRouteSearch new];
        search.delegate = self;
        BMFIndoorRoutePlanOption *option = [BMFIndoorRoutePlanOption bmf_modelWith:[call.arguments safeObjectForKey:@"indoorRoutePlanOption"]];
        BOOL flag = [search indoorRoutePlanSearch:[option toBMKIndoorRoutePlanOption]];
        result(@{@"result" : @(flag)});
    } else {
         result(FlutterMethodNotImplemented);
    }
}

#pragma mark - BMKRouteSearchDelegate

- (void)onGetTransitRouteResult:(BMKRouteSearch *)searcher result:(BMKTransitRouteResult *)result errorCode:(BMKSearchErrorCode)error {
    if (!_channel) return;
    [[BMFSearchHandles defalutCenter].handlerArray removeObject:self];
    BMFTransitRouteResult *res = [BMFTransitRouteResult fromBMKTransitRouteResult:result];
    [_channel invokeMethod:kBMFTransitSearchMethod arguments:@{@"result" : [res bmf_toDictionary], @"errorCode" : @(error)} result:nil];

}

- (void)onGetMassTransitRouteResult:(BMKRouteSearch *)searcher result:(BMKMassTransitRouteResult *)result errorCode:(BMKSearchErrorCode)error {
    if (!_channel) return;
    [[BMFSearchHandles defalutCenter].handlerArray removeObject:self];
    BMFMassTransitRouteResult *res = [BMFMassTransitRouteResult fromBMKMassTransitRouteResult:result];
    [_channel invokeMethod:kBMFMassTransitSearchMethod arguments:@{@"result" : [res bmf_toDictionary], @"errorCode" : @(error)} result:nil];
}

- (void)onGetDrivingRouteResult:(BMKRouteSearch *)searcher result:(BMKDrivingRouteResult *)result errorCode:(BMKSearchErrorCode)error {
    if (!_channel) return;
    [[BMFSearchHandles defalutCenter].handlerArray removeObject:self];
    BMFDrivingRouteResult *res = [BMFDrivingRouteResult fromBMKDrivingRouteResult:result];
    [_channel invokeMethod:kBMFDrivingSearchMethod arguments:@{@"result" : [res bmf_toDictionary], @"errorCode" : @(error)} result:nil];

}

- (void)onGetWalkingRouteResult:(BMKRouteSearch *)searcher result:(BMKWalkingRouteResult *)result errorCode:(BMKSearchErrorCode)error {
    if (!_channel) return;
    [[BMFSearchHandles defalutCenter].handlerArray removeObject:self];
    BMFWalkingRouteResult *res = [BMFWalkingRouteResult fromBMKWalkingRouteResult:result];
    [_channel invokeMethod:kBMFWalkingSearchMethod arguments:@{@"result" : [res bmf_toDictionary], @"errorCode" : @(error)} result:nil];
}

- (void)onGetRidingRouteResult:(BMKRouteSearch *)searcher result:(BMKRidingRouteResult *)result errorCode:(BMKSearchErrorCode)error {
    if (!_channel) return;
    [[BMFSearchHandles defalutCenter].handlerArray removeObject:self];
    BMFRidingRouteResult *res = [BMFRidingRouteResult fromBMKRidingRouteResult:result];
    [_channel invokeMethod:kBMFRidingSearchMethod arguments:@{@"result" : [res bmf_toDictionary], @"errorCode" : @(error)} result:nil];

}

- (void)onGetIndoorRouteResult:(BMKRouteSearch *)searcher result:(BMKIndoorRouteResult *)result errorCode:(BMKSearchErrorCode)error {
    if (!_channel) return;
    [[BMFSearchHandles defalutCenter].handlerArray removeObject:self];
    BMFIndoorRouteResult *res = [BMFIndoorRouteResult fromBMKIndoorRouteResult:result];
    [_channel invokeMethod:kBMFIndoorRoutePlanSearchMethod arguments:@{@"result" : [res bmf_toDictionary], @"errorCode" : @(error)} result:nil];

}

- (void)dealloc {
    NSLog(@"----BMFRouteSearchHandler-dealloc-----");
}
@end
