//
//  BMFLocationManager.m
//  flutter_bmflocation
//
//  Created by v_wangdachuan on 2022/1/21.
//

#import "BMFLocationManager.h"
#import "BMFLocationMethodHandles.h"
#import "BMFLocationMethodConst.h"
#import "BMFLocationHandle.h"
#import "BMFCircleGeofenceHandle.h"
#import "BMKLocationkit/BMKLocationComponent.h"

@interface BMFLocationManager ()<BMKLocationAuthDelegate>

@property (nonatomic, strong) BMKLocationManager *locationManager;

@end

@implementation BMFLocationManager

+ (void)registerWithRegistrar:(nonnull NSObject<FlutterPluginRegistrar> *)registrar {
    FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:@"flutter_bmflocation" binaryMessenger:[registrar messenger]];
    BMFLocationManager *manager = [[BMFLocationManager alloc] init];
    manager.channel = channel;
    [registrar addMethodCallDelegate:manager channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
//    NSLog(@"bdmap_loc_flutter_plugin:handleMethodCall:%@", call.method);

    BMFLocationMethodHandles *handleCenter = [BMFLocationMethodHandles defalutCenter];
    NSArray *methods = [[handleCenter locationHandles] allKeys];
    NSObject<BMFLocationHandle> *handler;
    
    if ([methods containsObject:call.method]) {
        
        if ([handleCenter.handlerDictionary.allKeys containsObject:@"BMFCircleGeofenceHandle"]) {
            handler = [handleCenter.handlerDictionary objectForKey:@"BMFCircleGeofenceHandle"];
        } else {
            handler = [[NSClassFromString(handleCenter.locationHandles[call.method]) new] initWithManager:self.locationManager channel:_channel];
            [handleCenter.handlerDictionary setObject:handler forKey:NSStringFromClass([handler class])];
        }

        [handler handleMethodCall:call result:result];
        
    } else {
        result(FlutterMethodNotImplemented);
    }
}



//懒加载
- (BMKLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [BMKLocationManager new];
    }
    return _locationManager;
}

@end
