//
//  BMFLocationMethodHandles.m
//  flutter_bmflocation
//
//  Created by v_wangdachuan on 2022/1/21.
//

#import "BMFLocationMethodHandles.h"
#import "BMFLocationMethodConst.h"
#import "BMFLocationOptionsHandle.h"
#import "BMFLocationAuthKeyHandle.h"
#import "BMFLocationResultHandle.h"
#import "BMFCircleGeofenceHandle.h"
#import "BMFAuxiliaryFunctionHandle.h"
#import "BMFLocationHeadingHandle.h"
@interface BMFLocationMethodHandles ()
{
    NSDictionary<NSString *, NSString *> *_handles;
    NSMutableDictionary *_handlerDictionary;
}
@end

@implementation BMFLocationMethodHandles
static BMFLocationMethodHandles *_instance = nil;

+ (instancetype)defalutCenter {
    return [[BMFLocationMethodHandles alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    @synchronized(self) { // 同步
        if (!_instance) {
            _instance = [super allocWithZone:zone];
        }
    }
    return _instance;
}
 
- (instancetype)copyWithZone:(struct _NSZone *)zone {
    return _instance;
}

- (instancetype)mutableCopyWithZone:(nullable NSZone *)zone {
    return _instance;
}


- (NSDictionary<NSString *, NSString *> *)locationHandles {
    if (!_handles) {
          _handles = @{
              kBMFLocationSetOptions: NSStringFromClass([BMFLocationOptionsHandle class]),
              kBMFLocationSetAK: NSStringFromClass([BMFLocationAuthKeyHandle class]),
              kBMFLocationSetAgreePrivacy: NSStringFromClass([BMFLocationAuthKeyHandle class]),
              kBMFLocationSeriesLoc: NSStringFromClass([BMFLocationResultHandle class]),
              kBMFLocationStopLoc: NSStringFromClass([BMFLocationResultHandle class]),
              kBMFLocationSingleLoc: NSStringFromClass([BMFLocationResultHandle class]),
              kBMFLocationCircleGeofence: NSStringFromClass([BMFCircleGeofenceHandle class]),
              kBMFLocationPolygonGeofence: NSStringFromClass([BMFCircleGeofenceHandle class]),
              kBMFLocationGetAllGeofence: NSStringFromClass([BMFCircleGeofenceHandle class]),
              kBMFLocationRemoveGeofenceId: NSStringFromClass([BMFCircleGeofenceHandle class]),
              kBMFLocationRemoveAllGeofence: NSStringFromClass([BMFCircleGeofenceHandle class]),
              kBMFLocationNetworkState: NSStringFromClass([BMFAuxiliaryFunctionHandle class]),
              kBMFLocationHeadingAvailable: NSStringFromClass([BMFLocationHeadingHandle class]),
              kBMFLocationStartHeading: NSStringFromClass([BMFLocationHeadingHandle class]),
              kBMFLocationStopHeading: NSStringFromClass([BMFLocationHeadingHandle class]),
              };
    }
    return _handles;
}

- (NSMutableDictionary *)handlerDictionary {
    if (!_handlerDictionary) {
        _handlerDictionary = [NSMutableDictionary dictionary];
    }
    return _handlerDictionary;
}

@end
