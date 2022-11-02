//
//  BMFSearchHandle.h
//  flutter_baidu_mapapi_search
//
//  Created by zhangbaojin on 2020/4/15.
//

#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BMFSearchHandle <NSObject>

@required

/// channel
@property (nonatomic, weak) FlutterMethodChannel *_channel;

- (NSObject<BMFSearchHandle> *)initWith:(FlutterMethodChannel *)channel;
/// flutter --> ios
- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result;

@end

NS_ASSUME_NONNULL_END
