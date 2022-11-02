#import "FlutterBmfbasePlugin.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import "BMFDefine.h"

static NSString *kBMFSDKSetApiMethod = @"flutter_bmfbase/sdk/setApiKey";
static NSString *kBMFGetBaseVersionMethod = @"flutter_bmfbase/sdk/getNativeBaseVersion";

static NSString *kBMFSDKSetAgreePrivacyApiMethod = @"flutter_bmfbase/sdk/setAgreePrivacy";


@interface FlutterBmfbasePlugin ()<BMKGeneralDelegate>
//@property (nonatomic, strong) FlutterMethodChannel *channel;

@end

@implementation FlutterBmfbasePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:@"flutter_bmfbase"
                                                                binaryMessenger:[registrar messenger]];
    FlutterBmfbasePlugin *instance = [[FlutterBmfbasePlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

/// sdk初始化通信回调
- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
//    NSLog(@"ios-call.method = %@", call.method);
    // 配置ak，初始化sdk
    if ([kBMFSDKSetApiMethod isEqualToString:call.method]) {
        NSDictionary *dic = (NSDictionary *)call.arguments;
        NSString *AK = dic[@"apiKey"];
        BMK_COORD_TYPE coordType = [dic[@"BMF_COORD_TYPE"] intValue];
        if (!AK) {
            NSLog(@"请填写正确的ak");
            return;
        }
        if (!coordType) {
            NSLog(@"请填写正确的BMK_COORD_TYPE");
            return;
        }
//        NSLog(@"ios-地图sdk初始化\n(AK = %@,经纬度类型 = %lu)", dic[@"apiKey"], (unsigned long)coordType);
        // 要使用百度地图，请先启动BMKMapManager
        BMKMapManager *_mapManager = [[BMKMapManager alloc] init];
        // 经纬度类型设置成功
        if ([BMKMapManager setCoordinateTypeUsedInBaiduMapSDK:coordType]) {
            NSLog(@"ios-经纬度类型设置成功");
        } else {
            NSLog(@"ios-经纬度类型设置失败");
        }
       
        // 启动引擎并设置AK并设置delegate
        BOOL result = [_mapManager start:AK generalDelegate:self];
        if (!result) {
            NSLog(@"ios-启动引擎失败");
        } else {
            NSLog(@"ios-启动引擎成功");
        }
    }
    else if ([kBMFGetBaseVersionMethod isEqualToString:call.method]) {
        result(@{@"platform" : @"ios", @"component" : @"base", @"version" : BMKGetMapApiBaseComponentVersion()});
    }
    else if ([kBMFSDKSetAgreePrivacyApiMethod isEqualToString:call.method]) {
        NSDictionary *dic = (NSDictionary *)call.arguments;
        BOOL isAgree = [dic[@"isAgree"] boolValue];
        [BMKMapManager setAgreePrivacy:isAgree];
        NSLog(@"ios-设置用户是否同意SDK隐私协议：%d", isAgree);
    }
    else {
        result(FlutterMethodNotImplemented);
    }

}
#pragma mark -----BMKGeneralDelegate

/// 返回网络错误
/// iError 错误号
- (void)onGetNetworkState:(int)iError {
//   if (!_channel) return;
        
//    [_channel invokeMethod:@"onGetNetworkState" arguments:@{@"":@(iError)} result:^(id  _Nullable result) {
//
//    }];
    
    if (0 == iError) {
        NSLog(@"ios-联网成功");
    } else {
        NSLog(@"ios-联网失败：%d", iError);
    }

}

/// 返回授权验证错误
/// iError 错误号 : 为0时验证通过，具体参加BMKPermissionCheckResultCode
- (void)onGetPermissionState:(int)iError {
//    if (!_channel) return;
//    [_channel invokeMethod:@"" arguments:@{@"onGetPermissionState":@(iError)} result:^(id  _Nullable result) {
//
//    }];
    if (0 == iError) {
        NSLog(@"ios-授权成功");
        
    } else {
        NSLog(@"ios-授权失败：%d", iError);
    }
}
@end
