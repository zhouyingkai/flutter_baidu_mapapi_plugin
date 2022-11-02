//
//  BMFOpenPanoramaModel.h
// flutter_baidu_mapapi_utils
//
//  Created by zhangbaojin on 2020/4/13.
//

#import <flutter_baidu_mapapi_base/BMFModel.h>

@class BMKOpenPanoramaOption;

NS_ASSUME_NONNULL_BEGIN

@interface BMFOpenPanoramaModel : BMFModel

/// poi的uid
@property (nonatomic, copy) NSString *poiUid;

/// 应用返回scheme，用于调起后返回，没有不能返回
@property (nonatomic, copy) NSString *appScheme;

/// 调起百度地图客户端失败后，是否支持调起web地图，默认：YES
@property (nonatomic, assign) BOOL isSupportWeb;

- (BMKOpenPanoramaOption *)toBMKOpenPanoramaOption;

@end


NS_ASSUME_NONNULL_END
