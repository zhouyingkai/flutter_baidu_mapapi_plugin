//
//  NSObject+BMFThread.h
//  flutter_baidu_mapapi_base
//
//  Created by Zhang,Baojin on 2020/11/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject(BMFThread)

/// 主线程异步执行
- (void)bmf_performBlockOnMainThreadAsync:(void(^)(void))block;

@end

NS_ASSUME_NONNULL_END
