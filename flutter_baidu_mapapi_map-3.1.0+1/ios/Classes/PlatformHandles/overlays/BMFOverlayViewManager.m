//
//  BMFOverlayViewManager.m
//  flutter_baidu_mapapi_map
//
//  Created by Zhang,Baojin on 2020/11/12.
//

#import "BMFOverlayViewManager.h"

#import <flutter_baidu_mapapi_base/BMFMapModels.h>
#import <flutter_baidu_mapapi_base/UIColor+BMFString.h>
//#import <flutter_baidu_mapapi_base/NSObject+BMFThread.h>

#import "BMFFileManager.h"
#import "BMFPolyline.h"
#import "BMFArcline.h"
#import "BMFCircle.h"
#import "BMFPolygon.h"
#import "BMFGeodesicLine.h"
#import "BMFGradientLine.h"
#import "BMFPrismOverlay.h"
#import "BMF3DModelOverlay.h"
#import "BMFMultiPointOverlay.h"
#import "BMFTraceOverlay.h"

@implementation BMFOverlayViewManager

+ (nullable BMFPolylineModel *)polylineModelWith:(BMKPolylineView *)view {
    return (BMFPolylineModel *)view.polyline.flutterModel;;
}

+ (BMKMultiColorPolylineView *)multiColorPolylineViewForMultiPolyline:(BMKMultiPolyline *)multiPolyline {
    BMFPolylineModel *model = (BMFPolylineModel *)multiPolyline.flutterModel;
    BMKMultiColorPolylineView *view = [[BMKMultiColorPolylineView alloc] initWithMultiPolyline:multiPolyline];
    
    view.lineWidth = model.width;
    view.lineDashType = model.lineDashType;
    view.lineCapType = model.lineCapType;
    view.lineJoinType = model.lineJoinType;
    
    if (multiPolyline.lineType == kBMFColorsLine || multiPolyline.lineType == kBMFMultiDashLine) {
        size_t colorsCount = model.colors.count;
        NSMutableArray<UIColor *> *colors = [NSMutableArray array];
        for (size_t i = 0; i < colorsCount; i++) {
            // TODO: colors加入空值判断
            [colors addObject:[UIColor fromColorString:model.colors[i]]];
        }
        view.strokeColors = colors;
    }

    return view;
}

+ (BMKMultiTexturePolylineView *)multiTexturePolylineViewForMultiPolyline:(BMKMultiPolyline *)multiPolyline {
    BMFPolylineModel *model = (BMFPolylineModel *)multiPolyline.flutterModel;
    BMKMultiTexturePolylineView *view = [[BMKMultiTexturePolylineView alloc] initWithMultiPolyline:multiPolyline];
    
    view.lineWidth = model.width;
    view.lineCapType = model.lineCapType;
    view.lineJoinType = model.lineJoinType;
    
    if (multiPolyline.lineType == kBMFTexturesLine) {
        NSMutableArray<UIImage *> *images = [NSMutableArray array];
        size_t imagesCount = model.textures.count;
        NSString *imagePath = nil;
        for (size_t i = 0; i < imagesCount; i++) {
            imagePath = model.textures[i];
            UIImage *image = [UIImage imageWithContentsOfFile:[[BMFFileManager defaultCenter] pathForFlutterImageName:imagePath]];
            [images addObject:image];
        }
        view.textureImages = images;
    }

    return view;
}

+ (BMKPolylineView *)viewForPolyline:(BMKPolyline *)polyline {
    if ([polyline isKindOfClass:[BMKMultiPolyline class]]) {
        if (polyline.lineType == kBMFColorsLine || polyline.lineType == kBMFMultiDashLine) {
            return [BMFOverlayViewManager multiColorPolylineViewForMultiPolyline:(BMKMultiPolyline *)polyline];
        } else if (polyline.lineType == kBMFTexturesLine) {
            return [BMFOverlayViewManager multiTexturePolylineViewForMultiPolyline:(BMKMultiPolyline *)polyline];
        }
    }

    BMFPolylineModel *model = (BMFPolylineModel *)polyline.flutterModel;
    BMKPolylineView *view = [[BMKPolylineView alloc] initWithPolyline:polyline];
    view.lineWidth = model.width;
    view.lineDashType = model.lineDashType;
    view.lineCapType = model.lineCapType;
    view.lineJoinType = model.lineJoinType;
    
    if (polyline.lineType == kBMFDashLine || polyline.lineType == kBMFColorLine) {
        if ([model.colors firstObject]) {
            view.strokeColor = [UIColor fromColorString:[model.colors firstObject]];
        } else {
            // TODO: strokeColor 默认值
//            view.strokeColor =  [UIColor colorWithRed:0.f green:0.f blue:1.f alpha:1.f];
        }
    } else if (polyline.lineType == kBMFTextureLine) {
        NSString *imagePath = [[BMFFileManager defaultCenter] pathForFlutterImageName:[model.textures firstObject]];
        view.textureImage = [UIImage imageWithContentsOfFile:imagePath];
    }
    
    return view;
}

+ (BMKArclineView *)viewForArcline:(BMKArcline *)arcline {
    BMFArclineModel *model = (BMFArclineModel *)arcline.flutterModel;
    BMKArclineView *arclineView = [[BMKArclineView alloc] initWithArcline:arcline];
    if (model.color) {
        arclineView.strokeColor = [UIColor fromColorString:model.color];
    } else {
        arclineView.strokeColor = [UIColor colorWithRed:0.f green:0.f blue:1.f alpha:1.f];
    }
    arclineView.lineWidth = model.width;
    arclineView.lineDashType = model.lineDashType;
    return arclineView;
}

+ (BMKPolygonView *)viewForPolygon:(BMKPolygon *)polygon {
    BMFPolygonModel *model = (BMFPolygonModel *)polygon.flutterModel;
    BMKPolygonView *view = [[BMKPolygonView alloc] initWithPolygon:polygon];
    if (model.strokeColor) {
        view.strokeColor = [UIColor fromColorString:model.strokeColor];
    } else {
        view.strokeColor = [UIColor colorWithRed:0.f green:0.f blue:1.f alpha:1.f];
    }
    if (model.fillColor) {
        view.fillColor = [UIColor fromColorString:model.fillColor];
    }
    view.lineWidth = model.width;
    view.lineDashType = model.lineDashType;
    return view;
}

+ (BMKCircleView *)viewForCircleline:(BMKCircle *)circle {
    BMFCircleModel *model = (BMFCircleModel *)circle.flutterModel;
    BMKCircleView *view = [[BMKCircleView alloc] initWithCircle:circle];
    if (model.strokeColor) {
        view.strokeColor = [UIColor fromColorString:model.strokeColor];
    } else {
        view.strokeColor = [UIColor colorWithRed:0.f green:0.f blue:1.f alpha:1.f];
    }
    if (model.fillColor) {
        view.fillColor = [UIColor fromColorString:model.fillColor];
    }
    view.lineWidth = model.width;
    view.lineDashType = model.lineDashType;
    return view;
}

+ (BMKGeodesicLineView *)viewForGeodesicLine:(BMKGeodesicLine *)geodesicline {
    BMFGeodesicLineModel *model = (BMFGeodesicLineModel *)geodesicline.flutterModel;
    BMKGeodesicLineView *view = [[BMKGeodesicLineView alloc] initWithGeodesicLine:geodesicline];
    if (model.strokeColor) {
        view.strokeColor = [UIColor fromColorString:model.strokeColor];
    } else {
        view.strokeColor = [UIColor colorWithRed:0.f green:0.f blue:1.f alpha:1.f];
    }
    if (model.textureImage) {
        UIImage *image = [UIImage imageWithContentsOfFile:[[BMFFileManager defaultCenter] pathForFlutterImageName:model.textureImage]];
        view.textureImage = image;
    }
    view.lineWidth = model.width;
    view.lineDashType = model.lineDashType;

    return view;
}

+ (BMKGradientLineView *)viewForGradientLine:(BMKGradientLine *)gradientLine {
    BMFGradientLineModel *model = (BMFGradientLineModel *)gradientLine.flutterModel;
    BMKGradientLineView *view = [[BMKGradientLineView alloc] initWithGradientLine:gradientLine];
    if (model.colors) {
        size_t colorsCount = model.colors.count;
        NSMutableArray<UIColor *> *colors = [NSMutableArray array];
        for (size_t i = 0; i < colorsCount; i++) {
            [colors addObject:[UIColor fromColorString:model.colors[i]]];
        }
        view.strokeColors = colors;
    }
    view.lineWidth = model.width;
    return view;
}

+ (BMKPrismOverlayView *)viewForPrismOverlay:(BMKPrismOverlay *)prismOverlay {
    BMFPrismOverlayModel *model =(BMFPrismOverlayModel *)prismOverlay.flutterModel;
    BMKPrismOverlayView *view = [[BMKPrismOverlayView alloc] initWithPrismOverlay:prismOverlay];
    if (model.sideFaceColor) {
        view.sideFaceColor = [UIColor fromColorString:model.sideFaceColor];
    } else {
        view.sideFaceColor = [UIColor colorWithRed:0.f green:0.f blue:1.f alpha:1.f];
    }
    if (model.topFaceColor) {
        view.topFaceColor = [UIColor fromColorString:model.topFaceColor];
    } else {
        view.topFaceColor= [UIColor colorWithRed:0.f green:0.f blue:1.f alpha:1.f];
    }
    if (model.sideFacTexture) {
        NSString *imagePath = [[BMFFileManager defaultCenter] pathForFlutterImageName:model.sideFacTexture];
        view.sideTextureImage = [UIImage imageWithContentsOfFile:imagePath];
    }
    return view;
}

+ (BMKMultiPointOverlayView *)viewForMultiPointOverlay:(BMKMultiPointOverlay *)multiPointOverlay {
    BMFMultiPointOverlayModel *model = (BMFMultiPointOverlayModel *)multiPointOverlay.flutterModel;
    BMKMultiPointOverlayView *view = [[BMKMultiPointOverlayView alloc] initWithMultiPointOverlay:multiPointOverlay];
    if (model.icon) {
        NSString *imagePath = [[BMFFileManager defaultCenter] pathForFlutterImageName:model.icon];
        view.icon = [UIImage imageWithContentsOfFile:imagePath];
    }
    if (model.pointSize) {
        view.pointSize = CGSizeMake(model.pointSize.width, model.pointSize.height);
    }
    if (model.anchor) {
        view.anchor = CGPointMake(model.anchor.x, model.anchor.y);
    }
    return view;
}

+ (BMKTraceOverlayView *)viewForTraceOverlay:(BMKTraceOverlay *)traceOverlay {
    BMFTraceOverlayModel *model = (BMFTraceOverlayModel *)traceOverlay.flutterModel;
    BMKTraceOverlayView *view = [[BMKTraceOverlayView alloc] initWithTraceOverlay:traceOverlay];
    if (model.strokeColor) {
        view.strokeColor = [UIColor fromColorString:model.strokeColor];
    } else {
        view.strokeColor = [UIColor colorWithRed:0.f green:0.f blue:1.f alpha:1.f];
    }
    if (model.fillColor) {
        view.fillColor = [UIColor fromColorString:model.fillColor];
    }
    view.lineWidth = model.width;
    return view;
}

+ (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay {
    if ([overlay isKindOfClass:[BMKGeodesicLine class]]) {
        return [BMFOverlayViewManager viewForGeodesicLine:(BMKGeodesicLine *)overlay];
    }
    else if ([overlay isKindOfClass:[BMKGradientLine class]]) {
        return [BMFOverlayViewManager viewForGradientLine:(BMKGradientLine *)overlay];
    }
    else if ([overlay isKindOfClass:[BMKPolyline class]]) {
        return [BMFOverlayViewManager viewForPolyline:(BMKPolyline *)overlay];
    }
    else if ([overlay isKindOfClass:[BMKArcline class]]) {
        return [BMFOverlayViewManager viewForArcline:(BMKArcline *)overlay];
    }
    else if ([overlay isKindOfClass:[BMKPolygon class]]) {
        return [BMFOverlayViewManager viewForPolygon:(BMKPolygon *)overlay];
    }
    else if ([overlay isKindOfClass:[BMKCircle class]]) {
        return [BMFOverlayViewManager viewForCircleline:(BMKCircle *)overlay];
    }
    else if ([overlay isKindOfClass:[BMKPrismOverlay class]]) {
        return [BMFOverlayViewManager viewForPrismOverlay:(BMKPrismOverlay *)overlay];
    }
    else if ([overlay isKindOfClass:[BMKMultiPointOverlay class]]) {
        return [BMFOverlayViewManager viewForMultiPointOverlay:(BMKMultiPointOverlay *)overlay];
    }
    else if ([overlay isKindOfClass:[BMKTraceOverlay class]]) {
        return [BMFOverlayViewManager viewForTraceOverlay:(BMKTraceOverlay *)overlay];
    }
    else if ([overlay isKindOfClass:[BMKTileLayer class]]) {
        return [[BMKTileLayerView alloc] initWithOverlay:overlay];
    }
    else if ([overlay isKindOfClass:[BMKGroundOverlay class]]) {
        return [[BMKGroundOverlayView alloc] initWithOverlay:overlay];
    }
    else if ([overlay isKindOfClass:[BMK3DModelOverlay class]]) {
        return [[BMK3DModelOverlayView alloc] initWithOverlay:overlay];
    }
    return nil;
}

@end
