//
//  BMFLocationChannelHandle.m
//  flutter_bmflocation
//
//  Created by v_wangdachuan on 2022/2/18.
//

#import "BMFLocationChannelHandle.h"


@implementation BMFLocationChannelHandle

+ (void)sendResultCallbackChannel:(FlutterMethodChannel *)channel methodId:(NSString *)methodId result:(id)result errorCode:(NSInteger)errorCode{

    [channel invokeMethod:methodId arguments:@{@"result": result, @"errorCode": [NSNumber numberWithInteger:errorCode]} result:nil];
}

@end
