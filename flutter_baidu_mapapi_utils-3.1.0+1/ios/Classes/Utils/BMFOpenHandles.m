//
//  BMFOpenHandles.m
// flutter_baidu_mapapi_utils
//
//  Created by zhangbaojin on 2020/4/15.
//

#import "BMFOpenHandles.h"
#import <flutter_baidu_mapapi_base/NSObject+BMFVerify.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <flutter_baidu_mapapi_base/BMFDefine.h>

#import "BMFOpenMethodConst.h"
#import "BMFOpenRouteModel.h"
#import "BMFOpenNaviModel.h"
#import "BMFOpenPoiModel.h"
#import "BMFOpenPanoramaModel.h"


@interface BMFOpenHandles ()
{
    NSDictionary<NSString *, NSString *> *_handles;
}
@end
@implementation BMFOpenHandles

static BMFOpenHandles *_instance = nil;
+ (instancetype)defalutCenter {
    return [[BMFOpenHandles alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    @synchronized(self) { // 同步
        if (!_instance) {
            _instance = [super allocWithZone:zone];
        }
    }
    return _instance;
}
 
- (instancetype)copyWithZone:(struct _NSZone *)zone {
    return _instance;
}

- (instancetype)mutableCopyWithZone:(nullable NSZone *)zone {
    return _instance;
}

- (NSDictionary<NSString *, NSString *> *)openHandles {
    if (!_handles) {
        _handles = @{
            kBMFOpenBaiduMapNaviMethod: NSStringFromClass([BMFOpenNavi class]),
            kBMFOpenBaiduMapRouteMethod: NSStringFromClass([BMFOpenRoute class]),
            kBMFOpenBaiduMapPoiDetailMethod: NSStringFromClass([BMFOpenPoiDetail class]),
            kBMFOpenBaiduMapPoiNearMethod: NSStringFromClass([BMFOpenPoiNear class]),
            kBMFOpenBaiduMapPanoramaMethod: NSStringFromClass([BMFOpenPanorama class])
        };
    }
    return _handles;
}
@end

#pragma mark - navi

@implementation BMFOpenNavi

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    if (!call.arguments || !call.arguments[@"naviOption"]) {
        result(@{@"result" : @(BMK_OPEN_OPTION_NULL)});
        return;
    }
    
    BMFOpenNaviModel *model = [BMFOpenNaviModel bmf_modelWith:[call.arguments safeObjectForKey:@"naviOption"]];
    BMKOpenErrorCode errorCode;
    switch (model.naviType) {
        case kBMFDriveNaviType:{
            errorCode = [BMKNavigation openBaiduMapNavigation:[model toBMKNaviPara]];
            result(@{@"result": @(errorCode)});
            break;
        }
        case kBMFRideNaviType:{
            errorCode = [BMKNavigation openBaiduMapRideNavigation:[model toBMKNaviPara]];
            result(@{@"result": @(errorCode)});
            break;
        }
        case kBMFWalkNaviType:{
            errorCode = [BMKNavigation openBaiduMapWalkNavigation:[model toBMKNaviPara]];
            result(@{@"result": @(errorCode)});
            break;
        }
        case kBMFARWalkNaviType:{
            errorCode = [BMKNavigation openBaiduMapwalkARNavigation:[model toBMKNaviPara]];
            result(@{@"result": @(errorCode)});
            break;
        }
    }
}

@end

#pragma mark - route
@implementation BMFOpenRoute

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    if (!call.arguments || !call.arguments[@"routeOption"]) {
        result(@{@"result" : @(BMK_OPEN_OPTION_NULL)});
        return;
    }
    BMFOpenRouteModel *model = [BMFOpenRouteModel bmf_modelWith:[call.arguments safeObjectForKey:@"routeOption"]];
    BMKOpenErrorCode errorCode;
    switch (model.routeType) {
        case kBMFWalkingRoute:{
            errorCode = [BMKOpenRoute openBaiduMapWalkingRoute:[model toBMKOpenWalkingRouteOption]];
            result(@{@"result": @(errorCode)});
            break;
        }

        case kBMFDrivingRoute:{
            errorCode = [BMKOpenRoute openBaiduMapDrivingRoute:[model toBMKOpenDrivingRouteOption]];
            result(@{@"result": @(errorCode)});
            break;
        }

        case kBMFTransitRoute:{
            errorCode = [BMKOpenRoute openBaiduMapTransitRoute:[model toBMKOpenTransitRouteOption]];
            result(@{@"result": @(errorCode)});
            break;
        }
    }

}

@end


#pragma mark - poiDetail

@implementation BMFOpenPoiDetail

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    if (!call.arguments || !call.arguments[@"poiDetailOption"]) {
        result(@{@"result" : @(BMK_OPEN_OPTION_NULL)});
        return;
    }
    BMFOpenPoiDetailModel *model = [BMFOpenPoiDetailModel bmf_modelWith:[call.arguments safeObjectForKey:@"poiDetailOption"]];
    BMKOpenErrorCode errorCode = [BMKOpenPoi openBaiduMapPoiDetailPage:[model toBMKOpenPoiDetailOption]];
    result(@{@"result": @(errorCode)});
}

@end

#pragma mark - poiNear

@implementation BMFOpenPoiNear

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result { 
    if (!call.arguments || !call.arguments[@"poiNearOption"]) {
        result(@{@"result" : @(BMK_OPEN_OPTION_NULL)});
        return;
    }
    BMFOpenPoiNearbyModel *model = [BMFOpenPoiNearbyModel bmf_modelWith:[call.arguments safeObjectForKey:@"poiNearOption"]];
    BMKOpenErrorCode errorCode = [BMKOpenPoi openBaiduMapPoiNearbySearch:[model toBMKOpenPoiNearbyOption]];
    result(@{@"result": @(errorCode)});
}

@end

#pragma mark - panorama
@interface BMFOpenPanorama ()<BMKOpenPanoramaDelegate>

/// 回调
@property (nonatomic, copy) FlutterResult result;

@end

static BMFOpenPanorama *_shareInstance = nil;
@implementation BMFOpenPanorama
+ (instancetype)share {
    return [[BMFOpenPanorama alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    @synchronized(self) { // 同步
        if (!_shareInstance) {
            _shareInstance = [super allocWithZone:zone];
        }
    }
    return _shareInstance;
}
 
- (instancetype)copyWithZone:(struct _NSZone *)zone {
    return _shareInstance;
}

- (instancetype)mutableCopyWithZone:(nullable NSZone *)zone {
    return _shareInstance;
}

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    if (!call.arguments || !call.arguments[@"panoramaOption"]) {
        result(@{@"result" : @(BMK_OPEN_OPTION_NULL)});
        return;
    }
    [BMFOpenPanorama share].result = result;
    BMFOpenPanoramaModel *model = [BMFOpenPanoramaModel bmf_modelWith:[call.arguments safeObjectForKey:@"panoramaOption"]];
    BMKOpenPanorama *openPanorama = [BMKOpenPanorama new];
    openPanorama.delegate = [BMFOpenPanorama share];
    [openPanorama openBaiduMapPanorama:[model toBMKOpenPanoramaOption]];
    
}

#pragma mark - BMKOpenPanoramaDelegate
- (void)onGetOpenPanoramaStatus:(BMKOpenErrorCode)ecode{
//    NSLog(@"ios-BMKOpenPanoramaDelegate-onGetOpenPanoramaStatus-");
    _result(@{@"result": @(ecode)});
}

//-(void)dealloc{
//    NSLog(@"ios-dealloc");
//}
@end

