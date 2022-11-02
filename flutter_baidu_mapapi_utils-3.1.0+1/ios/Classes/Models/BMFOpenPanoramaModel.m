//
//  BMFOpenPanoramaModel.m
// flutter_baidu_mapapi_utils
//
//  Created by zhangbaojin on 2020/4/13.
//

#import "BMFOpenPanoramaModel.h"
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>

@implementation BMFOpenPanoramaModel
- (BMKOpenPanoramaOption *)toBMKOpenPanoramaOption {
    BMKOpenPanoramaOption *panoramaOption = [BMKOpenPanoramaOption new];
    panoramaOption.poiUid = self.poiUid;
    if (self.appScheme) {
        panoramaOption.appScheme = self.appScheme;
    }
    panoramaOption.isSupportWeb = self.isSupportWeb;
    return panoramaOption;
}
@end
