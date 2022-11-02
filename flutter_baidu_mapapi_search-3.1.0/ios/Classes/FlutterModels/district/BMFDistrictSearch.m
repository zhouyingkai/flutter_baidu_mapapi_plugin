//
//  BMFDistrictSearchOption.m
//  flutter_baidu_mapapi_base
//
//  Created by zhangbaojin on 2020/4/7.
//

#import "BMFDistrictSearch.h"
#import <BaiduMapAPI_Search/BMKDistrictSearchOption.h>
#import <BaiduMapAPI_Search/BMKDistrictSearchResult.h>
#import <BaiduMapAPI_Utils/BMKGeometry.h>
#import <flutter_baidu_mapapi_base/BMFMapModels.h>

@implementation BMFDistrictSearchOption

- (BMKDistrictSearchOption *)toBMKDistrictSearchOption {
    BMKDistrictSearchOption *option = [BMKDistrictSearchOption new];
    option.city = self.city;
    if (self.district) {
        option.district = self.district;
    }
    return option;
}

@end

@implementation BMFDistrictSearchResult

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"paths" : @"NSArray"};
}

+ (instancetype)fromBMKDistrictSearchResult:(BMKDistrictResult *)data {
    BMFDistrictSearchResult *reslut = [BMFDistrictSearchResult new];
    reslut.code = data.code;
    reslut.name = data.name;
    reslut.center = [BMFCoordinate fromCLLocationCoordinate2D:data.center];
    reslut.paths = [BMFDistrictSearchResult convertGeoInfo:data.paths].copy;
    return reslut;
}

+ (NSArray *)convertGeoInfo:(NSArray<NSString *> *)paths {
    NSMutableArray *mut = [NSMutableArray array];
    for (NSString *path in paths) {
        NSUInteger pathCount = [path componentsSeparatedByString:@";"].count;
        if (pathCount > 0) {
            NSMutableArray *coords = [NSMutableArray array];
            NSArray *pointsArray = [path componentsSeparatedByString:@";"];
            for (NSUInteger i = 0; i < pathCount; i ++) {
                if ([pointsArray[i] rangeOfString:@","].location != NSNotFound) {
                    NSArray *coordinates = [pointsArray[i] componentsSeparatedByString:@","];
                    BMKMapPoint point = BMKMapPointMake([coordinates.firstObject doubleValue], [coordinates .lastObject doubleValue]);
                    BMFCoordinate *coord = [BMFCoordinate fromCLLocationCoordinate2D:BMKCoordinateForMapPoint(point)];
                    [coords addObject:coord];
                }
            }
            [mut addObject:coords];
        }
    }
    return mut;
}

@end

@implementation BMFCoordinates

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"coords" : @"BMFCoordinate"};
}

@end
