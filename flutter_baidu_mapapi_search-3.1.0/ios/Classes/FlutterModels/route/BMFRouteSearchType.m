//
//  BMFRouteSearchType.m
//  flutter_baidu_mapapi_base
//
//  Created by zhangbaojin on 2020/4/15.
//

#import "BMFRouteSearchType.h"
#import <BaiduMapAPI_Base/BMKTypes.h>
#import <BaiduMapAPI_Search/BMKRouteSearchType.h>
#import <flutter_baidu_mapapi_base/BMFMapModels.h>
#import "BMFPoiSearchType.h"

#pragma mark - 打车信息类
/// 打车信息类
@implementation BMFTaxiInfo

+ (instancetype)fromBMKTaxiInfo:(BMKTaxiInfo *)result {
    BMFTaxiInfo *res = [BMFTaxiInfo new];
    res.desc = result.desc;
    res.distance = result.distance;
    res.duration = result.duration;
    res.perKMPrice = result.perKMPrice;
    res.startPrice = result.startPrice;
    res.totalPrice = result.totalPrice;
    return res;
}

@end

#pragma mark - 路线换乘方案里的交通工具信息类
/// 路线换乘方案里的交通工具信息类
@implementation BMFVehicleInfo

+ (instancetype)fromBMKVehicleInfo:(BMKVehicleInfo *)result {
    BMFVehicleInfo *res = [BMFVehicleInfo new];
    res.uid = result.uid;
    res.title = result.title;
    res.passStationNum = result.passStationNum;
    res.totalPrice = result.totalPrice;
    res.zonePrice = result.zonePrice;
    return res;
}

@end

#pragma mark - 时间段
/// 此类代表一个时间段，每个属性都是一个时间段。
@implementation BMFTime

+ (instancetype)fromBMKTime:(BMKTime *)result {
    BMFTime *res = [BMFTime new];
    res.dates = result.dates;
    res.hours = result.hours;
    res.minutes = result.minutes;
    res.seconds = result.seconds;
    return res;
}

@end

#pragma mark - 路线中的一节点
/// 此类表示路线中的一节点，节点包括：路线起终点，公交站点等
@implementation BMFRouteNode

+ (instancetype)fromBMKRouteNode:(BMKRouteNode *)result {
    BMFRouteNode *res = [BMFRouteNode new];
    if (result.uid) {
        res.uid = result.uid;
    }
    if (result.title) {
        res.title = result.title;
    }
    res.location = [BMFCoordinate fromCLLocationCoordinate2D:result.location];
    return res;
}

@end

#pragma mark - 路线中的一个路段

/// 此类表示路线中的一个路段
@implementation BMFRouteStep

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"points" : @"BMFCoordinate"};
}

+ (instancetype)fromBMKRouteStep:(BMKRouteStep *)result {
    BMFRouteStep *res = [BMFRouteStep new];
    /// 路段长度 单位： 米
    res.distance = result.distance;
    /// 路段耗时 单位： 秒
    res.duration = result.duration;
    /// 路段所经过的地理坐标集合
    if (result.points && result.pointsCount > 0) {
        NSMutableArray <BMFCoordinate *> *mut = [NSMutableArray array];
        for (int i = 0; i < result.pointsCount; i++) {
            BMFCoordinate *coord = [BMFCoordinate fromBMKMapPoint:result.points[i]];
            [mut addObject:coord];
        }
        res.points = [mut copy];
    }

    /// 路段所经过的地理坐标集合内点的个数
    res.pointsCount = result.pointsCount;
    return res;
}

@end
#pragma mark - 此类表示公交站点信息
@implementation BMFBusStation

+ (instancetype)fromBMKBusStation:(BMKBusStation *)result {
    BMFBusStation *res = [BMFBusStation new];
    if (result.uid) {
        res.uid = result.uid;
    }
    if (result.title) {
        res.title = result.title;
    }
    res.location = [BMFCoordinate fromCLLocationCoordinate2D:result.location];
    return res;
}

@end

@implementation BMFBusStep
+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"points" : @"BMFCoordinate"};
}
+ (instancetype)fromBMKBusStep:(BMKBusStep *)result {
    BMFBusStep *res = [BMFBusStep new];
    /// 路段长度 单位： 米
    res.distance = result.distance;
    /// 路段耗时 单位： 秒
    res.duration = result.duration;
    /// 路段所经过的地理坐标集合
    if (result.points && result.pointsCount > 0) {
        NSMutableArray <BMFCoordinate *> *mut = [NSMutableArray array];
        for (int i = 0; i < result.pointsCount; i++) {
            BMFCoordinate *coord = [BMFCoordinate fromBMKMapPoint:result.points[i]];
            [mut addObject:coord];
        }
        res.points = [mut copy];
    }
    res.pointsCount = result.pointsCount;
    return res;
}

@end

#pragma mark - 公交换乘路线中的一个路段
/// 此类表示公交换乘路线中的一个路段
@implementation BMFTransitStep

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"points" : @"BMFCoordinate"};
}

+ (instancetype)fromBMKTransitStep:(BMKTransitStep *)result {
    BMFTransitStep *res = [BMFTransitStep new];
    res.distance = result.distance;
    res.duration = result.duration;
    /// 路段所经过的地理坐标集合
    if (result.points && result.pointsCount > 0) {
        NSMutableArray <BMFCoordinate *> *mut = [NSMutableArray array];
        for (int i = 0; i < result.pointsCount; i++) {
            BMFCoordinate *coord = [BMFCoordinate fromBMKMapPoint:result.points[i]];
            [mut addObject:coord];
        }
        res.points = [mut copy];
    }
    res.pointsCount = result.pointsCount;

    res.entrace = [BMFRouteNode fromBMKRouteNode:result.entrace];
    res.exit = [BMFRouteNode fromBMKRouteNode:result.exit];
    res.instruction = result.instruction;
    /// 路段类型 0 1 2
    res.stepType = result.stepType;
    res.vehicleInfo = [BMFVehicleInfo fromBMKVehicleInfo:result.vehicleInfo];
    return res;
}

@end

#pragma mark - 公共交通方案里的交通工具信息类- 公交车、地铁
/// 公共交通方案里的交通工具信息类- 公交车、地铁
@implementation BMFBusVehicleInfo

+ (instancetype)fromBMFBusVehicleInfo:(BMFBusVehicleInfo *)result {
    BMFBusVehicleInfo *res = [BMFBusVehicleInfo new];
    res.name = result.name;
    res.departureStation = result.departureStation;
    res.arriveStation = result.arriveStation;
    res.departureTime = result.departureTime;
    res.arriveTime = result.arriveTime;

    res.passStationNum = result.passStationNum;
    res.firstTime = result.firstTime;
    res.lastTime = result.lastTime;
    return res;
}

@end
#pragma mark - 公共交通方案里的交通工具信息类 - 飞机
/// 公共交通方案里的交通工具信息类 - 飞机
@implementation BMFPlaneVehicleInfo

+ (instancetype)fromBMKPlaneVehicleInfo:(BMKPlaneVehicleInfo *)result {
    BMFPlaneVehicleInfo *res = [BMFPlaneVehicleInfo new];
    res.name = result.name;
    res.departureStation = result.departureStation;
    res.arriveStation = result.arriveStation;
    res.departureTime = result.departureTime;
    res.arriveTime = result.arriveTime;

    res.price = result.price;
    res.discount = result.discount;
    res.airlines = result.airlines;
    res.bookingUrl = result.bookingUrl;
    return res;
}

@end

#pragma mark - 公共交通方案里的交通工具信息类 - 火车
/// 公共交通方案里的交通工具信息类 - 火车
@implementation BMFTrainVehicleInfo

+ (instancetype)fromBMKTrainVehicleInfo:(BMKTrainVehicleInfo *)result {
    BMFTrainVehicleInfo *res = [BMFTrainVehicleInfo new];
    res.name = result.name;
    res.departureStation = result.departureStation;
    res.arriveStation = result.arriveStation;
    res.departureTime = result.departureTime;
    res.arriveTime = result.arriveTime;

    res.price = result.price;
    res.booking = result.booking;
    return res;
}

@end

#pragma mark - 公共交通方案里的交通工具信息类 - 大巴

/// 公共交通方案里的交通工具信息类 - 大巴
@implementation BMFCoachVehicleInfo

+ (instancetype)fromBMKCoachVehicleInfo:(BMKCoachVehicleInfo *)result {
    BMFCoachVehicleInfo *res = [BMFCoachVehicleInfo new];
    res.name = result.name;
    res.departureStation = result.departureStation;
    res.arriveStation = result.arriveStation;
    res.departureTime = result.departureTime;
    res.arriveTime = result.arriveTime;

    res.price = result.price;
    res.bookingUrl = result.bookingUrl;
    res.providerName = result.providerName;
    res.providerUrl = result.providerUrl;
    return res;
}

@end

#pragma mark - 公共交通路线中的路段

/// 此类表示公共交通路线中的路段
@implementation BMFMassTransitStep

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"steps" : @"BMFMassTransitSubStep"};
}

+ (instancetype)fromBMKMassTransitStep:(BMKMassTransitStep *)result {
    BMFMassTransitStep *res = [BMFMassTransitStep new];
    res.isSubStep = result.isSubStep;
    if (result.steps && result.steps.count > 0) {
        NSMutableArray <BMFMassTransitSubStep *> *mut = [NSMutableArray array];
        for (BMKMassTransitSubStep *step in result.steps) {
            BMFMassTransitSubStep *fStep = [BMFMassTransitSubStep fromBMKMassTransitSubStep:step];
            [mut addObject:fStep];
        }
        res.steps = [mut copy];
    }
    return res;
}

@end

#pragma mark - 公共交通路线中的一个路段

/// 此类表示公共交通路线中的一个路段
@implementation BMFMassTransitSubStep

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"points" : @"BMFCoordinate"};
}

+ (instancetype)fromBMKMassTransitSubStep:(BMKMassTransitSubStep *)result {
    BMFMassTransitSubStep *res = [BMFMassTransitSubStep new];
    res.distance = result.distance;
    res.duration = result.duration;
    if (result.points && result.pointsCount > 0) {
        NSMutableArray <BMFCoordinate *> *mut = [NSMutableArray array];
        for (int i = 0; i < result.pointsCount; i++) {
            BMFCoordinate *coord = [BMFCoordinate fromBMKMapPoint:result.points[i]];
            [mut addObject:coord];
        }
        res.points = [mut copy];
    }
    res.pointsCount = result.pointsCount;
    
    res.entraceCoor = [BMFCoordinate fromCLLocationCoordinate2D:result.entraceCoor];
    res.exitCoor = [BMFCoordinate fromCLLocationCoordinate2D:result.exitCoor];
    res.instructions = result.instructions;
    res.stepType = result.stepType;

    switch (result.stepType) {
        case BMK_TRANSIT_SUBWAY:
        case BMK_TRANSIT_BUSLINE:
            res.busAndSubwayVehicleInfo = [BMFBusVehicleInfo fromBMFBusVehicleInfo:(BMFBusVehicleInfo *)result.vehicleInfo];
            break;
        case BMK_TRANSIT_COACH:
            res.coachVehicleInfo = [BMFCoachVehicleInfo fromBMKCoachVehicleInfo:(BMKCoachVehicleInfo *)result.vehicleInfo];
            break;
        case BMK_TRANSIT_PLANE:
            res.planeVehicleInfo = [BMFPlaneVehicleInfo fromBMKPlaneVehicleInfo:(BMKPlaneVehicleInfo *)result.vehicleInfo];
            break;
        case BMK_TRANSIT_TRAIN:
            res.trainVehicleInfo = [BMFTrainVehicleInfo fromBMKTrainVehicleInfo:(BMKTrainVehicleInfo *)result.vehicleInfo];
            break;
        default:
            break;
    }

    return res;
}

@end

#pragma mark - 驾车路线中的一个路段

/// 此类表示驾车路线中的一个路段
@implementation BMFDrivingStep

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"points" : @"BMFCoordinate",
             @"traffics": @"NSNumber"
    };
}

+ (instancetype)fromBMKDrivingStep:(BMKDrivingStep *)result {
    BMFDrivingStep *res = [BMFDrivingStep new];
    res.distance = result.distance;
    res.duration = result.duration;
    if (result.points && result.pointsCount > 0) {
        NSMutableArray <BMFCoordinate *> *mut = [NSMutableArray array];
        for (int i = 0; i < result.pointsCount; i++) {
            BMFCoordinate *coord = [BMFCoordinate fromBMKMapPoint:result.points[i]];
            [mut addObject:coord];
        }
        res.points = [mut copy];
    }
    res.pointsCount = result.pointsCount;
    
    res.direction = result.direction;
    res.entrace = [BMFRouteNode fromBMKRouteNode:result.entrace];
    res.entraceInstruction = result.entraceInstruction;
    res.exit = [BMFRouteNode fromBMKRouteNode:result.exit];
    res.exitInstruction = result.exitInstruction;
    res.instruction = result.instruction;
    res.numTurns = result.numTurns;
    res.hasTrafficsInfo = result.hasTrafficsInfo;
    res.traffics = [result.traffics copy];
    res.roadLevel = result.roadLevel;
    res.roadName = result.roadName;
    return res;
}

@end

#pragma mark - 室内路线结点
/// 室内路线结点
@implementation BMFIndoorStepNode

+ (instancetype)fromBMKIndoorStepNode:(BMKIndoorStepNode *)result {
    BMFIndoorStepNode *res = [BMFIndoorStepNode new];
    res.coordinate = [BMFCoordinate fromCLLocationCoordinate2D:result.coordinate];
    /// 1,2,3,4
    res.type = result.type - 1;
    res.desc = result.desc;
    return res;
}

@end

#pragma mark - 室内路线的一个路段
/// 此类表示室内路线的一个路段
@implementation BMFIndoorRouteStep

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"points" : @"BMFCoordinate",
             @"indoorStepNodes": @"BMFIndoorStepNode"
    };
}

+ (instancetype)fromBMKIndoorRouteStep:(BMKIndoorRouteStep *)result {
    BMFIndoorRouteStep *res = [BMFIndoorRouteStep new];
    res.distance = result.distance;
    res.duration = result.duration;
    if (result.points && result.pointsCount > 0) {
        NSMutableArray <BMFCoordinate *> *mut = [NSMutableArray array];
        for (int i = 0; i < result.pointsCount; i++) {
            BMFCoordinate *coord = [BMFCoordinate fromBMKMapPoint:result.points[i]];
            [mut addObject:coord];
        }
        res.points = [mut copy];
    }
    res.pointsCount = result.pointsCount;
    
    res.entrace = [BMFRouteNode fromBMKRouteNode:result.entrace];
    res.exit = [BMFRouteNode fromBMKRouteNode:result.exit];
    res.instructions = result.instructions;
    res.buildingid = result.buildingid;
    res.floorid = result.floorid;
    if (result.indoorStepNodes && result.indoorStepNodes.count > 0) {
        NSMutableArray <BMFIndoorStepNode *> *mut = [NSMutableArray array];
        for (BMKIndoorStepNode *node in result.indoorStepNodes) {
            BMFIndoorStepNode *fNode = [BMFIndoorStepNode fromBMKIndoorStepNode:node];
            [mut addObject:fNode];
        }
        res.indoorStepNodes = [mut copy];
    }
    return res;
}

@end

#pragma mark - 步行路线中的一个路段

/// 此类表示步行路线中的一个路段
@implementation BMFWalkingStep

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"points" : @"BMFCoordinate"};
}

+ (instancetype)fromBMKWalkingStep:(BMKWalkingStep *)result {
    BMFWalkingStep *res = [BMFWalkingStep new];
    res.distance = result.distance;
    res.duration = result.duration;
    if (result.points && result.pointsCount > 0) {
        NSMutableArray <BMFCoordinate *> *mut = [NSMutableArray array];
        for (int i = 0; i < result.pointsCount; i++) {
            BMFCoordinate *coord = [BMFCoordinate fromBMKMapPoint:result.points[i]];
            [mut addObject:coord];
        }
        res.points = [mut copy];
    }
    res.pointsCount = result.pointsCount;

    res.direction = result.direction;
    res.entrace = [BMFRouteNode fromBMKRouteNode:result.entrace];
    res.entraceInstruction = result.entraceInstruction;
    res.exit = [BMFRouteNode fromBMKRouteNode:result.exit];
    res.exitInstruction = result.exitInstruction;
    res.instruction = result.instruction;
    return res;
}

@end

#pragma mark - 骑行路线中的一个路段
/// 此类表示骑行路线中的一个路段
@implementation BMFRidingStep

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"points" : @"BMFCoordinate"};
}

+ (instancetype)fromBMKRidingStep:(BMKRidingStep *)result {
    BMFRidingStep *res = [BMFRidingStep new];
    res.duration = result.duration;
    if (result.points && result.pointsCount > 0) {
        NSMutableArray <BMFCoordinate *> *mut = [NSMutableArray array];
        for (int i = 0; i < result.pointsCount; i++) {
            BMFCoordinate *coord = [BMFCoordinate fromBMKMapPoint:result.points[i]];
            [mut addObject:coord];
        }
        res.points = [mut copy];
    }
    res.pointsCount = result.pointsCount;

    res.direction = result.direction;
    res.entrace = [BMFRouteNode fromBMKRouteNode:result.entrace];
    res.entraceInstruction = result.entraceInstruction;
    res.exit = [BMFRouteNode fromBMKRouteNode:result.exit];
    res.exitInstruction = result.exitInstruction;
    res.instruction = result.instruction;
    /// sdk6.2.0 之后添加name 和 turnType
//    res.name = result.name;
//    res.turnType = result.turnType;
    return res;
}

@end

#pragma mark - BMFTransitRouteLine

/// 此类表示一个换乘路线，换乘路线将根据既定策略调配多种交通工具
@implementation BMFTransitRouteLine

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"steps" : @"BMFTransitStep"};
}

+ (instancetype)fromBMKTransitRouteLine:(BMKTransitRouteLine *)result {
    BMFTransitRouteLine *res = [BMFTransitRouteLine new];
    res.distance = result.distance;
    res.duration = [BMFTime fromBMKTime:result.duration];
    res.starting = [BMFRouteNode fromBMKRouteNode:result.starting];
    res.terminal = [BMFRouteNode fromBMKRouteNode:result.terminal];
//    res.title = result.title;
    if (result.steps && result.steps.count) {
        NSMutableArray <BMFTransitStep *> *mut = [NSMutableArray array];
        for (BMKTransitStep *step in result.steps) {
            BMFTransitStep *fStep = [BMFTransitStep fromBMKTransitStep:step];
            [mut addObject:fStep];
        }
        res.steps = [mut copy];
    }
    return res;
}

@end

#pragma mark - BMFMassTransitRouteLine
/// 此类表示一条公共交通路线
@implementation BMFMassTransitRouteLine

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"steps" : @"BMFMassTransitStep"};
}

+ (instancetype)fromBMKMassTransitRouteLine:(BMKMassTransitRouteLine *)result {
    BMFMassTransitRouteLine *res = [BMFMassTransitRouteLine new];
    res.distance = result.distance;
    res.duration = [BMFTime fromBMKTime:result.duration];
    res.starting = [BMFRouteNode fromBMKRouteNode:result.starting];
    res.terminal = [BMFRouteNode fromBMKRouteNode:result.terminal];
//    res.title = result.title;
    if (result.steps && result.steps.count) {
        NSMutableArray <BMFMassTransitStep *> *mut = [NSMutableArray array];
        for (BMKMassTransitStep *step in result.steps) {
            BMFMassTransitStep *fStep = [BMFMassTransitStep fromBMKMassTransitStep:step];
            [mut addObject:fStep];
        }
        res.steps = [mut copy];
    }
    res.price = result.price;
    return res;
}

@end

#pragma mark - BMFIndoorRouteLine

/// 此类表示一个室内路线
@implementation BMFIndoorRouteLine

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"steps" : @"BMFIndoorRouteStep"};
}

+ (instancetype)fromBMKIndoorRouteLine:(BMKIndoorRouteLine *)result {
    BMFIndoorRouteLine *res = [BMFIndoorRouteLine new];
    res.distance = result.distance;
    res.duration = [BMFTime fromBMKTime:result.duration];
    res.starting = [BMFRouteNode fromBMKRouteNode:result.starting];
    res.terminal = [BMFRouteNode fromBMKRouteNode:result.terminal];
//    res.title = result.title;
    if (result.steps && result.steps.count) {
        NSMutableArray <BMFIndoorRouteStep *> *mut = [NSMutableArray array];
        for (BMKIndoorRouteStep *step in result.steps) {
            BMFIndoorRouteStep *fStep = [BMFIndoorRouteStep fromBMKIndoorRouteStep:step];
            [mut addObject:fStep];
        }
        res.steps = [mut copy];
    }
    return res;
}

@end

#pragma mark - BMFDrivingRouteLine

@implementation BMFDrivingRouteLine

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"steps" : @"BMFDrivingStep",
             @"wayPoints" : @"BMFPlanNode"
    };
}

+ (instancetype)fromBMKDrivingRouteLine:(BMKDrivingRouteLine *)result {
    BMFDrivingRouteLine *res = [BMFDrivingRouteLine new];
    res.distance = result.distance;
    res.duration = [BMFTime fromBMKTime:result.duration];
    res.starting = [BMFRouteNode fromBMKRouteNode:result.starting];
    res.terminal = [BMFRouteNode fromBMKRouteNode:result.terminal];
//    res.title = result.title;
    if (result.steps && result.steps.count) {
        NSMutableArray <BMFDrivingStep *> *mut = [NSMutableArray array];
        for (BMKDrivingStep *step in result.steps) {
            BMFDrivingStep *fStep = [BMFDrivingStep fromBMKDrivingStep:step];
            [mut addObject:fStep];
        }
        res.steps = [mut copy];
    }
    /// 路线途经点列表，成员类型为BMFPlanNode
    if (result.wayPoints && result.wayPoints.count > 0) {
        NSMutableArray <BMFPlanNode *> *mut = [NSMutableArray array];
        for (BMKPlanNode *node in result.wayPoints) {
            BMFPlanNode *fNode = [BMFPlanNode fromBMKPlanNode:node];
            [mut addObject:fNode];
        }
        res.wayPoints = [mut copy];
    }
    res.lightNum = result.lightNum;
    res.congestionMetres = result.congestionMetres;
    res.taxiFares = result.taxiFares;
    return res;
}

@end

#pragma mark - BMFWalkingRouteLine

@implementation BMFWalkingRouteLine

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"steps" : @"BMFWalkingStep"};
}

+ (instancetype)fromBMKWalkingRouteLine:(BMKWalkingRouteLine *)result {
    BMFWalkingRouteLine *res = [BMFWalkingRouteLine new];
    res.distance = result.distance;
    res.duration = [BMFTime fromBMKTime:result.duration];
    res.starting = [BMFRouteNode fromBMKRouteNode:result.starting];
    res.terminal = [BMFRouteNode fromBMKRouteNode:result.terminal];
//    res.title = result.title;
    if (result.steps && result.steps.count) {
        NSMutableArray <BMFWalkingStep *> *mut = [NSMutableArray array];
        for (BMKWalkingStep *step in result.steps) {
            BMFWalkingStep *fStep = [BMFWalkingStep fromBMKWalkingStep:step];
            [mut addObject:fStep];
        }
        res.steps = [mut copy];
    }
    return res;
}
@end

#pragma mark - BMFRidingRouteLine

@implementation BMFRidingRouteLine

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"steps" : @"BMFRidingStep"};
}

+ (instancetype)fromBMKRidingRouteLine:(BMKRidingRouteLine *)result {
    BMFRidingRouteLine *res = [BMFRidingRouteLine new];
    res.distance = result.distance;
    res.duration = [BMFTime fromBMKTime:result.duration];
    res.starting = [BMFRouteNode fromBMKRouteNode:result.starting];
    res.terminal = [BMFRouteNode fromBMKRouteNode:result.terminal];
//    res.title = result.title;
    if (result.steps && result.steps.count) {
        NSMutableArray <BMFRidingStep *> *mut = [NSMutableArray array];
        for (BMKRidingStep *step in result.steps) {
            BMFRidingStep *fStep = [BMFRidingStep fromBMKRidingStep:step];
            [mut addObject:fStep];
        }
        res.steps = [mut copy];
    }
    return res;
}

@end

#pragma mark -  BMFSuggestAddrInfo

/// 路线搜索地址结果类.当输入的起点或终点有多个地点选择时，或者选定的城市没有此地点，但其它城市有(驾乘或步行)，返回该类的实例
@implementation BMFSuggestAddrInfo

+ (NSDictionary *)bmf_setupObjectClassInArray {
    return @{@"startPoiList" : @"BMFPoiInfo",
             @"startCityList" : @"BMFCityListInfo",
             @"endPoiList" : @"BMFPoiInfo",
             @"endCityList" : @"BMFCityListInfo",
             @"wayPointPoiList" : @"NSArray",
             @"wayPointCityList" : @"NSArray"
    };
}

+ (instancetype)fromBMKSuggestAddrInfo:(BMKSuggestAddrInfo *)result {
    BMFSuggestAddrInfo *res = [BMFSuggestAddrInfo new];
    /// 起点POI列表，成员类型为BMFPoiInfo
    if (result.startPoiList && result.startPoiList.count > 0) {
        NSMutableArray <BMFPoiInfo *> *mut = [NSMutableArray array];
        for (BMKPoiInfo *info in result.startPoiList) {
            BMFPoiInfo *fInfo = [BMFPoiInfo fromBMKPoiInfo:info];
            [mut addObject:fInfo];
        }
        res.startPoiList = [mut copy];
    }
    if (result.startCityList && result.startCityList.count > 0) {
        NSMutableArray <BMFCityListInfo *> *mut = [NSMutableArray array];
        for (BMKCityListInfo *info in result.startCityList) {
            BMFCityListInfo *fInfo = [BMFCityListInfo fromBMKCityListInfo:info];
            [mut addObject:fInfo];
        }
        res.startCityList = [mut copy];
    }
    if (result.endPoiList && result.endPoiList.count > 0) {
        NSMutableArray <BMFPoiInfo *> *mut = [NSMutableArray array];
        for (BMKPoiInfo *info in result.endPoiList) {
            BMFPoiInfo *fInfo = [BMFPoiInfo fromBMKPoiInfo:info];
            [mut addObject:fInfo];
        }
        res.endPoiList = [mut copy];
    }
    if (result.endCityList && result.endCityList.count > 0) {
        NSMutableArray <BMFCityListInfo *> *mut = [NSMutableArray array];
        for (BMKCityListInfo *info in result.endCityList) {
            BMFCityListInfo *fInfo = [BMFCityListInfo fromBMKCityListInfo:info];
            [mut addObject:fInfo];
        }
        res.endCityList = [mut copy];
    }
    if (result.wayPointPoiList && result.wayPointPoiList.count > 0) {
        NSMutableArray <NSMutableArray<BMFPoiInfo *> *> *mut = [NSMutableArray array];
        for (NSArray *list in result.wayPointPoiList) {
            NSMutableArray <BMFPoiInfo *> *listPoi = [NSMutableArray array];
            for (BMKPoiInfo *info in list) {
                BMFPoiInfo *fInfo = [BMFPoiInfo fromBMKPoiInfo:info];
                [listPoi addObject:fInfo];
            }
          
            [mut addObject:listPoi];
        }
        res.wayPointPoiList = [mut copy];
    }
    if (result.wayPointCityList && result.wayPointCityList.count > 0) {
        NSMutableArray <NSMutableArray<BMFCityListInfo *> *> *mut = [NSMutableArray array];
        for (NSArray *list in result.wayPointCityList) {
            NSMutableArray <BMFCityListInfo *> *listCity = [NSMutableArray array];
            for (BMKCityListInfo *info in list) {
                BMFCityListInfo *fInfo = [BMFCityListInfo fromBMKCityListInfo:info];
                [listCity addObject:fInfo];
            }
            [mut addObject:listCity];
        }
      
        res.wayPointCityList = [mut copy];
    }
    return res;
}

@end


#pragma mark - 城市列表信息类

/// 城市列表信息类
@implementation BMFCityListInfo

+ (instancetype)fromBMKCityListInfo:(BMKCityListInfo *)result {
    BMFCityListInfo *res = [BMFCityListInfo new];
    res.city = result.city;
    res.count = result.num;
    return res;
}

@end


#pragma mark - 以下数据结构之前存放在base组件中

@implementation BMFPlanNode

+ (instancetype)fromBMKPlanNode:(BMKPlanNode *)node{
    BMFPlanNode *planNode = [BMFPlanNode new];
    if (node.cityName) {
        planNode.cityName = node.cityName;
    }
    if (node.name) {
        planNode.name = node.name;
    }
    if (node.cityID) {
        planNode.cityID = node.cityID;
    }
    planNode.pt = [BMFCoordinate fromCLLocationCoordinate2D:node.pt];
    return planNode;
}

- (BMKPlanNode *)toBMKPlanNode{
    BMKPlanNode *node = [BMKPlanNode new];
    if (self.cityName) {
        node.cityName = self.cityName;
    }
    if (self.name) {
        node.name = self.name;
    }
    if (self.cityID > 0) {
        node.cityID = self.cityID;
    }
    if (self.pt) {
        node.pt = [self.pt toCLLocationCoordinate2D];
    }
    return node;
}

@end


@implementation BMFIndoorPlanNode

+ (instancetype)fromBMKIndoorPlanNode:(BMKIndoorPlanNode *)result {
    BMFIndoorPlanNode *res = [BMFIndoorPlanNode new];
    res.floor = result.floor;
    res.pt = [BMFCoordinate fromCLLocationCoordinate2D:result.pt];
    return res;
}

- (BMKIndoorPlanNode *)toBMKIndoorPlanNode{
    BMKIndoorPlanNode *node = [BMKIndoorPlanNode new];
    if (self.floor) {
        node.floor = self.floor;
    }
    if (self.pt) {
        node.pt = [self.pt toCLLocationCoordinate2D];
    }
    return node;
}

@end


@implementation BMFAddressComponent

+ (instancetype)fromBMKAddressComponent:(BMKAddressComponent *)result {
    BMFAddressComponent *res = [BMFAddressComponent new];

    // 国家
    res.country = result.country;

    // 省份名称
    res.province = result.province;

    // 城市名称
    res.city = result.city;

    // 区县名称
    res.district = result.district;

    // 乡镇
    res.town = result.town;

    // 街道名称
    res.streetName = result.streetName;

    // 街道号码
    res.streetNumber = result.streetNumber;

    /// 行政区域编码
    res.adCode = result.adCode;

    /// 国家代码
    res.countryCode = result.countryCode;

    // 相对当前坐标点的方向，当有门牌号的时候返回数据
    res.direction = result.direction;

    // 相对当前坐标点的距离，当有门牌号的时候返回数据
    res.distance = result.distance;
    return res;
}

@end
