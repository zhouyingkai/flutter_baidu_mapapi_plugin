//
//  BMFTraceOverlayModel.m
//  flutter_baidu_mapapi_map
//
//  Created by zhangbaojin on 2021/12/29.
//

#import "BMFTraceOverlayModel.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@implementation BMFTraceOverlayModel

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"coordinates" : @"BMFCoordinate"};
}
+ (NSDictionary *)bmf_setupReplacedKeyFromPropertyName {
    return @{@"Id" : @"id"};
}

@end

@implementation BMFTraceOverlayOption

- (nullable BMKTraceOverlayOption *)toBMKTraceOverlayOption {
    BMKTraceOverlayOption *option = [[BMKTraceOverlayOption alloc] init];
    option.animate = self.animate;
    option.delay = self.delay;
    option.duration = self.duration;
    option.easingCurve = self.easingCurve;
    option.fromValue = self.fromValue;
    option.toValue = self.toValue;
    option.trackMove = self.trackMove;
    return option;
}

@end
