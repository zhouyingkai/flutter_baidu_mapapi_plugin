//
//  BMFOpenPoiModel.m
// flutter_baidu_mapapi_utils
//
//  Created by zhangbaojin on 2020/4/13.
//

#import "BMFOpenPoiModel.h"
#import <flutter_baidu_mapapi_base/BMFMapModels.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>

@implementation BMFOpenPoiDetailModel

- (BMKOpenPoiDetailOption *)toBMKOpenPoiDetailOption {
    BMKOpenPoiDetailOption *detailOption = [BMKOpenPoiDetailOption new];
    detailOption.poiUid = self.poiUid;
    if (self.appScheme) {
        detailOption.appScheme = self.appScheme;
    }
    detailOption.isSupportWeb = self.isSupportWeb;
    return detailOption;
}

@end


@implementation BMFOpenPoiNearbyModel

- (BMKOpenPoiNearbyOption *)toBMKOpenPoiNearbyOption {
    BMKOpenPoiNearbyOption *nearOption = [BMKOpenPoiNearbyOption new];
    nearOption.location = [self.location toCLLocationCoordinate2D];
    nearOption.radius = self.radius;
    nearOption.keyword = self.keyword;
    if (self.appScheme) {
        nearOption.appScheme = self.appScheme;
    }
    nearOption.isSupportWeb = self.isSupportWeb;
    return nearOption;
}

@end
