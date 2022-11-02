//
//  BMFLocationChannelHandle.h
//  flutter_bmflocation
//
//  Created by v_wangdachuan on 2022/2/18.
//

#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

// 负责回调
@interface BMFLocationChannelHandle : NSObject


/// iOS端回调到Flutter
/// @param channel channel
/// @param methodId 方法标识
/// @param result 回调结果
/// @param errorCode 错误码 0:成功 其他参照各个业务线
+ (void)sendResultCallbackChannel:(FlutterMethodChannel *)channel methodId:(NSString *)methodId result:(id)result errorCode:(NSInteger)errorCode;

@end

NS_ASSUME_NONNULL_END
