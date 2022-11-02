//
//  BMFSearchHandles.h
//  flutter_baidu_mapapi_search
//
//  Created by zhangbaojin on 2020/4/15.
//

#import "BMFSearchHandle.h"

NS_ASSUME_NONNULL_BEGIN

@interface BMFSearchHandles : NSObject

+ (instancetype)defalutCenter;

- (NSDictionary<NSString *, NSString *> *)searchHandles;

- (NSMutableArray<NSObject<BMFSearchHandle> *> *)handlerArray;
@end

NS_ASSUME_NONNULL_END
