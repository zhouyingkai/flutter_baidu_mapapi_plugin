//
//  BMFOpenHandles.h
// flutter_baidu_mapapi_utils
//
//  Created by zhangbaojin on 2020/4/15.
//

#import "BMFUtilsHandle.h"

NS_ASSUME_NONNULL_BEGIN

@interface BMFOpenHandles : NSObject
/// BMFOpenHandles管理中心
+ (instancetype)defalutCenter;

- (NSDictionary<NSString *, NSString *> *)openHandles;
@end


@interface BMFOpenNavi : NSObject<BMFUtilsHandle>

@end

@interface BMFOpenRoute : NSObject<BMFUtilsHandle>

@end

@interface BMFOpenPoiDetail : NSObject<BMFUtilsHandle>

@end

@interface BMFOpenPoiNear : NSObject<BMFUtilsHandle>

@end

@interface BMFOpenPanorama : NSObject<BMFUtilsHandle>



@end
NS_ASSUME_NONNULL_END
