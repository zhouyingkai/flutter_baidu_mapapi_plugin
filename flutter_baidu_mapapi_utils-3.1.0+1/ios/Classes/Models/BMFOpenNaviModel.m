//
//  BMFOpenNaviModel.m
// flutter_baidu_mapapi_utils
//
//  Created by zhangbaojin on 2020/4/13.
//

#import "BMFOpenNaviModel.h"
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <flutter_baidu_mapapi_base/BMFMapModels.h>

@implementation BMFOpenNaviModel

// 此处需要依赖BMFMapModel
- (BMKNaviPara *)toBMKNaviPara {
    BMKNaviPara *naviPara = [BMKNaviPara new];
    BMKPlanNode *start = [BMKPlanNode new];
    start.pt = [self.startCoord toCLLocationCoordinate2D];
    start.name = self.startName;
    BMKPlanNode *end = [BMKPlanNode new];
    end.pt = [self.endCoord toCLLocationCoordinate2D];
    end.name = self.endName;
    naviPara.startPoint = start;
    naviPara.endPoint = end;
    if (self.appScheme) {
        naviPara.appScheme = self.appScheme;
    }
    if (self.appName) {
        naviPara.appName = self.appName;
    }
    naviPara.isSupportWeb = self.isSupportWeb;
    return naviPara;
}
@end
