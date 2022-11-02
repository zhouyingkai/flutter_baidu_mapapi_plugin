//
//  BMFOpenRouteModel.m
// flutter_baidu_mapapi_utils
//
//  Created by zhangbaojin on 2020/4/13.
//

#import "BMFOpenRouteModel.h"
#import <flutter_baidu_mapapi_base/BMFMapModels.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>

@implementation BMFOpenRouteModel
- (BMKOpenWalkingRouteOption *)toBMKOpenWalkingRouteOption {
    BMKOpenWalkingRouteOption *walkOption = [BMKOpenWalkingRouteOption new];
    BMKPlanNode *start = [BMKPlanNode new];
    start.pt = [self.startCoord toCLLocationCoordinate2D];
    start.name = self.startName;
    BMKPlanNode *end = [BMKPlanNode new];
    end.pt = [self.endCoord toCLLocationCoordinate2D];
    end.name = self.endName;
    walkOption.startPoint = start;
    walkOption.endPoint = end;
    if (self.appScheme) {
        walkOption.appScheme = self.appScheme;
    }
    walkOption.isSupportWeb = self.isSupportWeb;
    return walkOption;
}

- (BMKOpenDrivingRouteOption *)toBMKOpenDrivingRouteOption {
    BMKOpenDrivingRouteOption *driveOption = [BMKOpenDrivingRouteOption new];
    BMKPlanNode *start = [BMKPlanNode new];
    start.pt = [self.startCoord toCLLocationCoordinate2D];
    start.name = self.startName;
    BMKPlanNode *end = [BMKPlanNode new];
    end.pt = [self.endCoord toCLLocationCoordinate2D];
    end.name = self.endName;
    driveOption.startPoint = start;
    driveOption.endPoint = end;
    if (self.appScheme) {
        driveOption.appScheme = self.appScheme;
    }
    driveOption.isSupportWeb = self.isSupportWeb;
    return driveOption;
}

- (BMKOpenTransitRouteOption *)toBMKOpenTransitRouteOption {
    BMKOpenTransitRouteOption *transitOption = [BMKOpenTransitRouteOption new];
    BMKPlanNode *start = [BMKPlanNode new];
    start.pt = [self.startCoord toCLLocationCoordinate2D];
    start.name = self.startName;
    BMKPlanNode *end = [BMKPlanNode new];
    end.pt = [self.endCoord toCLLocationCoordinate2D];
    end.name = self.endName;
    transitOption.startPoint = start;
    transitOption.endPoint = end;
    transitOption.openTransitPolicy = (int)self.openTransitPolicy;
    if (self.appScheme) {
        transitOption.appScheme = self.appScheme;
    }
    transitOption.isSupportWeb = self.isSupportWeb;
    return transitOption;
}
@end
