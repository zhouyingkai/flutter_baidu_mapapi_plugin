//
//  NSObject+BMFThread.m
//  flutter_baidu_mapapi_base
//
//  Created by Zhang,Baojin on 2020/11/11.
//

#import "NSObject+BMFThread.h"

@implementation NSObject (BMFThread)

- (void)bmf_performBlockOnMainThreadAsync:(void(^)(void))block {
    if (!block) {return;}
    dispatch_async(dispatch_get_main_queue(), block);
}

@end
