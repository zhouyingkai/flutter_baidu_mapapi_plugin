//
//  BMFOpenNaviModel.h
// flutter_baidu_mapapi_utils
//
//  Created by zhangbaojin on 2020/4/13.
//

#import <flutter_baidu_mapapi_base/BMFModel.h>

@class BMFCoordinate;
@class BMKNaviPara;
/// 调起客户端的导航类型
typedef NS_ENUM(NSUInteger, BMFNaviType) {
    kBMFDriveNaviType = 0,    ///<调起百度地图客户端驾车导航页面(不支持调起web地图)
    kBMFWalkNaviType,      /// <调起百度地图客户端步行导航页面(不支持调起web地图)
    kBMFRideNaviType,     ///< 调起百度地图客户端骑行导航页面(不支持调起web地图)
    kBMFARWalkNaviType,    ///< 调起百度地图AR步行导航
};


NS_ASSUME_NONNULL_BEGIN

@interface BMFOpenNaviModel : BMFModel

/// 起点坐标
@property (nonatomic, strong) BMFCoordinate *startCoord;

/// 起点名称
@property (nonatomic, copy) NSString *startName;

/// 终点坐标
@property (nonatomic, strong) BMFCoordinate *endCoord;

/// 终点名称
@property (nonatomic, copy) NSString *endName;

/// 调起导航类型
@property (nonatomic, assign) NSUInteger naviType;

/// 指定返回自定义scheme
@property (nonatomic, copy) NSString *appScheme;

/// 应用名称
@property (nonatomic, copy) NSString *appName;

/// 调起百度地图客户端驾车导航失败后，是否支持调起web地图，默认：YES（步行、骑行导航设置该参数无效）
@property (nonatomic, assign) BOOL isSupportWeb;
/// BMFOpenNaviModel  -->  BMKNaviPara
- (BMKNaviPara *)toBMKNaviPara;

@end

NS_ASSUME_NONNULL_END
