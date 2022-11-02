//
//  BMFLocationManager.h
//  flutter_bmflocation
//
//  Created by v_wangdachuan on 2022/1/21.
//

#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMFLocationManager : NSObject<FlutterPlugin>

@property (nonatomic, strong) FlutterMethodChannel *channel;


@property (nonatomic, strong) FlutterMethodChannel *geofenceChannel;

@end

NS_ASSUME_NONNULL_END
