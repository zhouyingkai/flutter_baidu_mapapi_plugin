//
//  BMFConvertHandles.h
// flutter_baidu_mapapi_utils
//
//  Created by zhangbaojin on 2020/4/15.
//

#import "BMFUtilsHandle.h"

NS_ASSUME_NONNULL_BEGIN

@interface BMFConvertHandles : NSObject
/// BMFConvertHandles管理中心
+ (instancetype)defalutCenter;

- (NSDictionary<NSString *, NSString *> *)convertHandles;
@end


#pragma mark - 坐标转换

@interface BMFCoordTransType : NSObject<BMFUtilsHandle>

@end

#pragma mark - 几何

@interface BMFPolygonContainsCoord : NSObject<BMFUtilsHandle>

@end

@interface BMFCircleContainsCoord : NSObject<BMFUtilsHandle>

@end

@interface BMFGetDirectionFromCoords : NSObject<BMFUtilsHandle>

@end

@interface BMFAreaBetweenCoordinates : NSObject<BMFUtilsHandle>

@end

@interface BMFCalculatePolygonArea : NSObject<BMFUtilsHandle>

@end

@interface BMFLocationDistance : NSObject<BMFUtilsHandle>

@end

@interface BMFNearestPointToLine : NSObject<BMFUtilsHandle>

@end

@interface BMFPointToTheVerticalFootOfLine : NSObject<BMFUtilsHandle>

@end
NS_ASSUME_NONNULL_END
