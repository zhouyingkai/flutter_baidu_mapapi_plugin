//
//  BMFLocationMethodHandles.h
//  flutter_bmflocation
//
//  Created by v_wangdachuan on 2022/1/21.
//
#import "BMFLocationHandle.h"


NS_ASSUME_NONNULL_BEGIN

@interface BMFLocationMethodHandles : NSObject

+ (instancetype)defalutCenter;

- (NSDictionary<NSString *, NSString *> *)locationHandles;

- (NSMutableDictionary *)handlerDictionary;

@end

NS_ASSUME_NONNULL_END
