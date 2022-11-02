//
//  BMFCircle.m
//  flutter_baidu_mapapi_map
//
//  Created by zbj on 2020/2/15.
//

#import "BMFCircle.h"
#import <objc/runtime.h>
#import <flutter_baidu_mapapi_base/BMFMapModels.h>
#import "BMFHollowShapeModel.h"

static const void *circleModelKey = &circleModelKey;
@implementation  BMKCircle (BMFCircle)

+ (nullable instancetype)overlayWithDictionary:(nullable NSDictionary *)dic {
    if (!dic) return nil;

    BMFCircleModel *model = [BMFCircleModel bmf_modelWith:dic];
    if (!model.center)  return nil;
    
    BMKCircle *circle = [BMKCircle circleWithCenterCoordinate:[model.center toCLLocationCoordinate2D] radius:model.radius];
    circle.flutterModel = model;
    // 镂空判断
    if (model.hollowShapes && model.hollowShapes.count > 0) {
        circle.hollowShapes = [BMFHollowShapeModel fromHollowShapes:model.hollowShapes];
    }
    return circle;
}

- (BMFModel *)flutterModel {
    return objc_getAssociatedObject(self, circleModelKey);
}

- (void)setFlutterModel:(BMFModel * _Nonnull)flutterModel {
    objc_setAssociatedObject(self, circleModelKey, flutterModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
