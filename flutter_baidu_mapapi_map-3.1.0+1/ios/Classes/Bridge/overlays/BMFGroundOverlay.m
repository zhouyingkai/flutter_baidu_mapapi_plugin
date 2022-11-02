//
//  BMFGroundOverlay.m
//  flutter_baidu_mapapi_map
//
//  Created by zhangbaojin on 2020/3/22.
//

#import "BMFGroundOverlay.h"
#import <objc/runtime.h>
#import <flutter_baidu_mapapi_base/BMFMapModels.h>
#import "BMFGroundModel.h"
#import "BMFFileManager.h"

static const void *groundModelKey = &groundModelKey;

@implementation BMKGroundOverlay (BMFGroundOverlay)

+ (nullable instancetype)overlayWithDictionary:(nullable NSDictionary *)dic {
    if (!dic) return nil;
    BMFGroundModel *model = [BMFGroundModel bmf_modelWith:dic];
    model.groundOptions = [BMFGroundModelOptions bmf_modelWith:dic];
    if (!model || !model.Id || !model.groundOptions || !model.groundOptions.image) {
        return nil;
    }
    // 构造一
    if (model.groundOptions.position) {
        CLLocationCoordinate2D position = [model.groundOptions.position toCLLocationCoordinate2D];
        CGPoint point = CGPointMake(model.groundOptions.anchorX, model.groundOptions.anchorY);
        NSString *imagePath = [[BMFFileManager defaultCenter] pathForFlutterFileName:model.groundOptions.image];
        
        BMKGroundOverlay *groundOverlay = [BMKGroundOverlay groundOverlayWithPosition:position
                                                                            zoomLevel:model.groundOptions.zoomLevel
                                                                               anchor:point
                                                                                 icon:[UIImage imageWithContentsOfFile:imagePath]];
        groundOverlay.alpha = model.groundOptions.transparency;
        groundOverlay.flutterModel = model;
        return groundOverlay;
    }
    // 构造二
    if (model.groundOptions.bounds) {
        BMKCoordinateBounds bounds = [model.groundOptions.bounds toBMKCoordinateBounds];
        NSString *imagePath = [[BMFFileManager defaultCenter] pathForFlutterFileName:model.groundOptions.image];
        
        BMKGroundOverlay *groundOverlay = [BMKGroundOverlay groundOverlayWithBounds:bounds
                                                                               icon:[UIImage imageWithContentsOfFile:imagePath]];
        groundOverlay.alpha = model.groundOptions.transparency;
        groundOverlay.flutterModel = model;
        return groundOverlay;
    }
    
    return nil;
}

- (BMFModel *)flutterModel {
    return objc_getAssociatedObject(self, groundModelKey);
}

- (void)setFlutterModel:(BMFModel * _Nonnull)flutterModel {
    objc_setAssociatedObject(self, groundModelKey, flutterModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
