//
//  BMFOpenHandle.h
// flutter_baidu_mapapi_utils
//
//  Created by zhangbaojin on 2020/4/15.
//

#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BMFUtilsHandle <NSObject>

@required
/// flutter --> ios
- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result;

@end
NS_ASSUME_NONNULL_END
