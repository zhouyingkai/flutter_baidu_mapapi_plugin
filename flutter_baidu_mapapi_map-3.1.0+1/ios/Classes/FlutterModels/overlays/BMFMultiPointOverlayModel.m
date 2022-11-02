//
//  BMFMultiPointOverlayModel.m
//  flutter_baidu_mapapi_map
//
//  Created by zhangbaojin on 2021/12/29.
//

#import "BMFMultiPointOverlayModel.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <flutter_baidu_mapapi_base/BMFMapModels.h>

@implementation BMFMultiPointOverlayModel

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"items" : @"BMFMultiPointItem"};
}
+ (NSDictionary *)bmf_setupReplacedKeyFromPropertyName {
    return @{@"Id" : @"id"};
}

@end

@implementation BMFMultiPointItem

- (nullable BMKMultiPointItem *)toBMKMultiPointItem {
    BMKMultiPointItem *item = [[BMKMultiPointItem alloc] init];
    item.coordinate = [self.coordinate toCLLocationCoordinate2D];
    item.title = self.title;
    item.subtitle = self.subtitle;
    return item;
}

@end
