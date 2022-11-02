//
//  BMFLocationHandle.h
//  flutter_bmflocation
//
//  Created by v_wangdachuan on 2022/2/18.
//

#import <Flutter/Flutter.h>
#import "BMKLocationkit/BMKLocationManager.h"

@protocol BMFLocationHandle <NSObject>

@optional
@property (nonatomic, weak) BMKLocationManager *_locManager;

@property (nonatomic, weak) FlutterMethodChannel *_channel;

@required
- (NSObject<BMFLocationHandle> *)initWithManager:(BMKLocationManager *)manager channel:(FlutterMethodChannel *)channel;

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result;
@end

/* BMFLocationHandle_h */

