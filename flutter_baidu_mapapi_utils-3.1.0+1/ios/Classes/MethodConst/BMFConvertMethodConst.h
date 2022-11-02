#ifndef __BMFConvertMethodConst__H__
#define __BMFConvertMethodConst__H__
#import <Foundation/Foundation.h>

/// 坐标类型转换
FOUNDATION_EXPORT NSString *const kBMFCoordTransTypeMethod;
/// 坐标是否在polygon内
FOUNDATION_EXPORT NSString *const kBMFPolygonContainsCoordMethod;
/// 坐标是否在cirlce内
FOUNDATION_EXPORT NSString *const kBMFCircleContainsCoordMethod;
/// 获取矢量坐标方向
FOUNDATION_EXPORT NSString *const kBMFGetDirectionFromCoordsMethod;
/// 计算地理矩形区域的面积
FOUNDATION_EXPORT NSString *const kBMFAreaBetweenCoordinatesMethod;
/// 计算多边形面积
FOUNDATION_EXPORT NSString *const kBMFCalculatePolygonAreaMethod;
/// 计算两点之间的距离
FOUNDATION_EXPORT NSString *const kBMFLocationDistanceMethod;
/// 获取点到折线最近的点
FOUNDATION_EXPORT NSString *const kBMFNearestPointToLineMethod;
/// 点到线段的垂足
FOUNDATION_EXPORT NSString *const kBMFPointToTheVerticalFootOfLineMethod;

#endif
