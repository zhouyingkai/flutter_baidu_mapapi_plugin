//
//  BMFRouteSearchType.h
//  flutter_baidu_mapapi_base
//
//  Created by zhangbaojin on 2020/4/15.
//

#import <flutter_baidu_mapapi_base/BMFModel.h>

@class BMFCoordinate;
@class BMFPoiInfo;
@class BMFMapPoint;


@class BMFTaxiInfo;
@class BMKTaxiInfo;
@class BMFVehicleInfo;
@class BMKVehicleInfo;
@class BMFTime;
@class BMKTime;

@class BMFRouteNode;
@class BMKRouteNode;
@class BMFRouteStep;
@class BMKRouteStep;

// bus
@class BMFBusStation;
@class BMKBusStation;
@class BMFBusStep;
@class BMKBusStep;
@class BMFTransitStep;
@class BMKTransitStep;
@class BMFBusVehicleInfo;
@class BMKBusVehicleInfo;
@class BMFPlaneVehicleInfo;
@class BMKPlaneVehicleInfo;
@class BMFTrainVehicleInfo;
@class BMKTrainVehicleInfo;
@class BMFCoachVehicleInfo;
@class BMKCoachVehicleInfo;
@class BMFMassTransitStep;
@class BMKMassTransitStep;
@class BMFMassTransitSubStep;
@class BMKMassTransitSubStep;


@class BMFDrivingStep;
@class BMKDrivingStep;
@class BMFWalkingStep;
@class BMKWalkingStep;
@class BMFRidingStep;
@class BMKRidingStep;

@class BMFIndoorStepNode;
@class BMKIndoorStepNode;
@class BMFIndoorRouteStep;
@class BMKIndoorRouteStep;

// routeline
@class BMFTransitRouteLine;
@class BMKTransitRouteLine;
@class BMFMassTransitRouteLine;
@class BMKMassTransitRouteLine;
@class BMFIndoorRouteLine;
@class BMKIndoorRouteLine;
@class BMFDrivingRouteLine;
@class BMKDrivingRouteLine;
@class BMFWalkingRouteLine;
@class BMKWalkingRouteLine;
@class BMFRidingRouteLine;
@class BMKRidingRouteLine;

@class BMFSuggestAddrInfo;
@class BMKSuggestAddrInfo;
@class BMFCityListInfo;
@class BMKCityListInfo;

@class BMFPlanNode;
@class BMKPlanNode;
@class BMFIndoorPlanNode;
@class BMKIndoorPlanNode;
@class BMFAddressComponent;
@class BMKAddressComponent;

NS_ASSUME_NONNULL_BEGIN

/// 打车信息类
@interface BMFTaxiInfo : BMFModel

/// 路线打车描述信息
@property (nonatomic, copy) NSString *desc;

/// 总路程，单位： 米
@property (nonatomic, assign) int distance;

/// 总耗时，单位： 秒
@property (nonatomic, assign) int duration;

/// 每千米单价(白天)，单位 元
@property (nonatomic, assign) CGFloat perKMPrice;

/// 起步价(白天)，单位 元
@property (nonatomic, assign) CGFloat startPrice;

/// 总价(预估) , 单位： 元
@property (nonatomic, assign) CGFloat totalPrice;

+ (instancetype)fromBMKTaxiInfo:(BMKTaxiInfo *)result;

@end


/// 路线换乘方案里的交通工具信息类
@interface BMFVehicleInfo : BMFModel

/// 该交通路线的标识
@property (nonatomic, copy) NSString *uid;

/// 该交通路线的名称
@property (nonatomic, copy) NSString *title;

/// 该交通路线的所乘站数
@property (nonatomic, assign) int passStationNum;

/// 该交通路线的全程价格
@property (nonatomic, assign) int totalPrice;

/// 该交通路线的所乘区间的区间价格
@property (nonatomic, assign) int zonePrice;

+ (instancetype)fromBMKVehicleInfo:(BMKVehicleInfo *)result;

@end

/// 此类代表一个时间段，每个属性都是一个时间段。
@interface BMFTime : BMFModel

/// 时间段，单位（天）
@property (nonatomic, assign) int dates;

/// 时间段，单位（小时）
@property (nonatomic, assign) int hours;

/// 时间段，单位（分）
@property (nonatomic, assign) int minutes;

/// 时间段，单位（秒）
@property (nonatomic, assign) int seconds;

+ (instancetype)fromBMKTime:(BMKTime *)result;

@end


/// 此类表示路线中的一节点，节点包括：路线起终点，公交站点等
@interface BMFRouteNode : BMFModel

/// 该节点uid
@property (nonatomic, copy) NSString *uid;

/// 该节点的名称
@property (nonatomic, copy) NSString *title;

/// 该节点的坐标
@property (nonatomic, strong) BMFCoordinate *location;

+ (instancetype)fromBMKRouteNode:(BMKRouteNode *)result;
@end


/// 此类表示公交站点信息
@interface BMFBusStation : BMFModel

/// 该节点uid
@property (nonatomic, copy) NSString *uid;

/// 该节点的名称
@property (nonatomic, copy) NSString *title;

/// 该节点的坐标
@property (nonatomic, strong) BMFCoordinate *location;

+ (instancetype)fromBMKBusStation:(BMKBusStation *)result;

@end


/// 此类表示路线中的一个路段（基类）
@interface BMFRouteStep : BMFModel

/// 路段长度 单位： 米
@property (nonatomic, assign) int distance;

/// 路段耗时 单位： 秒
@property (nonatomic, assign) int duration;

/// 路段所经过的地理坐标集合
@property (nonatomic, copy) NSArray<BMFCoordinate *> *points;

/// 路段所经过的地理坐标集合内点的个数
@property (nonatomic, assign) int pointsCount;

+ (instancetype)fromBMKRouteStep:(BMKRouteStep *)result;

@end


///此类表示公交线路中的一个路段
@interface BMFBusStep : BMFModel

/// 路段长度 单位： 米
@property (nonatomic, assign) int distance;

/// 路段耗时 单位： 秒
@property (nonatomic, assign) int duration;

/// 路段所经过的地理坐标集合
@property (nonatomic, copy) NSArray<BMFCoordinate *> *points;

/// 路段所经过的地理坐标集合内点的个数
@property (nonatomic, assign) int pointsCount;

+ (instancetype)fromBMKBusStep:(BMKBusStep *)result;

@end


/// 此类表示公交换乘路线中的一个路段
@interface BMFTransitStep : BMFModel

/// 路段长度 单位： 米
@property (nonatomic, assign) int distance;

/// 路段耗时 单位： 秒
@property (nonatomic, assign) int duration;

/// 路段所经过的地理坐标集合
@property (nonatomic, copy) NSArray<BMFCoordinate *> *points;

/// 路段所经过的地理坐标集合内点的个数
@property (nonatomic, assign) int pointsCount;

/// 路段入口信息
@property (nonatomic, strong) BMFRouteNode *entrace;

/// 路段出口信息
@property (nonatomic, strong) BMFRouteNode *exit;

/// 路段换乘说明
@property (nonatomic, copy) NSString *instruction;

/// 路段类型
@property (nonatomic, assign) int stepType;

/// 当路段为公交路段或地铁路段时，可以获取交通工具信息
@property (nonatomic, strong) BMFVehicleInfo *vehicleInfo;

+ (instancetype)fromBMKTransitStep:(BMKTransitStep *)result;

@end

/// 公共交通方案里的交通工具信息类- 公交车、地铁
@interface BMFBusVehicleInfo : BMFModel

/// 该交通路线的名称
@property (nonatomic, copy) NSString *name;

/// 出发站
@property (nonatomic, copy) NSString *departureStation;

/// 到达站
@property (nonatomic, copy) NSString *arriveStation;

/// 出发时间(BMFBusVehicleInfo时departureTime为空)
@property (nonatomic, copy) NSString *departureTime;

/// 到达时间(BMFBusVehicleInfo时arriveTime为空)
@property (nonatomic, copy) NSString *arriveTime;

/// 该交通路线的所乘站数
@property (nonatomic, assign) NSInteger passStationNum;

/// 始发车发车时间
@property (nonatomic, copy) NSString *firstTime;

/// 末班车发车时间
@property (nonatomic, copy) NSString *lastTime;

+ (instancetype)fromBMFBusVehicleInfo:(BMFBusVehicleInfo *)result;

@end


/// 公共交通方案里的交通工具信息类 - 飞机
@interface BMFPlaneVehicleInfo : BMFModel

/// 该交通路线的名称
@property (nonatomic, copy) NSString *name;

/// 出发站
@property (nonatomic, copy) NSString *departureStation;

/// 到达站
@property (nonatomic, copy) NSString *arriveStation;

/// 出发时间(BMFBusVehicleInfo时departureTime为空)
@property (nonatomic, copy) NSString *departureTime;

/// 到达时间(BMFBusVehicleInfo时arriveTime为空)
@property (nonatomic, copy) NSString *arriveTime;

/// 价格（单位：元）
@property (nonatomic, assign) CGFloat price;

/// 折扣
@property (nonatomic, assign) CGFloat discount;

/// 航空公司
@property (nonatomic, copy) NSString *airlines;

/// 订票网址
@property (nonatomic, copy) NSString *bookingUrl;

+ (instancetype)fromBMKPlaneVehicleInfo:(BMKPlaneVehicleInfo *)result;

@end


/// 公共交通方案里的交通工具信息类 - 火车
@interface BMFTrainVehicleInfo : BMFModel

/// 该交通路线的名称
@property (nonatomic, copy) NSString *name;

/// 出发站
@property (nonatomic, copy) NSString *departureStation;

/// 到达站
@property (nonatomic, copy) NSString *arriveStation;

/// 出发时间(BMFBusVehicleInfo时departureTime为空)
@property (nonatomic, copy) NSString *departureTime;

/// 到达时间(BMFBusVehicleInfo时arriveTime为空)
@property (nonatomic, copy) NSString *arriveTime;

/// 价格（单位：元）
@property (nonatomic, assign) CGFloat price;

/// 订票电话
@property (nonatomic, copy) NSString *booking;

+ (instancetype)fromBMKTrainVehicleInfo:(BMKTrainVehicleInfo *)result;

@end

/// 公共交通方案里的交通工具信息类 - 大巴
@interface BMFCoachVehicleInfo : BMFModel

/// 该交通路线的名称
@property (nonatomic, copy) NSString *name;

/// 出发站
@property (nonatomic, copy) NSString *departureStation;

/// 到达站
@property (nonatomic, copy) NSString *arriveStation;

/// 出发时间(BMFBusVehicleInfo时departureTime为空)
@property (nonatomic, copy) NSString *departureTime;

/// 到达时间(BMFBusVehicleInfo时arriveTime为空)
@property (nonatomic, copy) NSString *arriveTime;

/// 价格（单位：元）
@property (nonatomic, assign) CGFloat price;

/// 订票网址
@property (nonatomic, copy) NSString *bookingUrl;

/// 合作方名称
@property (nonatomic, copy) NSString *providerName;

/// 合作方官网
@property (nonatomic, copy) NSString *providerUrl;

+ (instancetype)fromBMKCoachVehicleInfo:(BMKCoachVehicleInfo *)result;

@end


/// 此类表示公共交通路线中的路段
@interface BMFMassTransitStep : BMFModel

/// steps中是方案还是子路段，YES:steps是BMFMassTransitStep的子路段（A到B需要经过多个steps）;NO:steps是多个方案（A到B有多个方案选择）
@property (nonatomic, assign) BOOL isSubStep;

/// 本BMFMassTransitStep中的有几个方案或几个子路段，成员类型为BMFMassTransitSubStep
@property (nonatomic, copy) NSArray <BMFMassTransitSubStep *> *steps;


+ (instancetype)fromBMKMassTransitStep:(BMKMassTransitStep *)result;

@end


/// 此类表示公共交通路线中的一个路段
@interface BMFMassTransitSubStep : BMFModel

/// 路段长度 单位： 米
@property (nonatomic, assign) int distance;

/// 路段耗时 单位： 秒
@property (nonatomic, assign) int duration;

/// 路段所经过的地理坐标集合
@property (nonatomic, copy) NSArray<BMFCoordinate *> *points;

/// 路段所经过的地理坐标集合内点的个数
@property (nonatomic, assign) int pointsCount;

/// 路段入口经纬度
@property (nonatomic, strong) BMFCoordinate *entraceCoor;

/// 路段出口经纬度
@property (nonatomic, strong) BMFCoordinate *exitCoor;

/// 路段说明
@property (nonatomic, copy) NSString *instructions;

/// 路段类型
@property (nonatomic, assign) int stepType;

/// 该路段交通工具信息（当stepType为公交地铁时，BMFBusVehicleInfo对象；stepType为大巴时，BMFCoachVehicleInfo对象；stepType为飞机时，BMFPlaneVehicleInfo对象；stepType为火车时，BMFTrainVehicleInfo对象；其它为nil）

/// 当stepType为公交地铁时有值
@property (nonatomic, strong) BMFBusVehicleInfo *busAndSubwayVehicleInfo;

/// stepType为大巴时有值
@property (nonatomic, strong) BMFCoachVehicleInfo *coachVehicleInfo;

/// stepType为飞机时有值
@property (nonatomic, strong) BMFPlaneVehicleInfo *planeVehicleInfo;

/// stepType为火车时有值
@property (nonatomic, strong) BMFTrainVehicleInfo *trainVehicleInfo;

+ (instancetype)fromBMKMassTransitSubStep:(BMKMassTransitSubStep *)result;

@end


/// 此类表示驾车路线中的一个路段
@interface BMFDrivingStep : BMFModel

/// 路段长度 单位： 米
@property (nonatomic, assign) int distance;

/// 路段耗时 单位： 秒
@property (nonatomic, assign) int duration;

/// 路段所经过的地理坐标集合
@property (nonatomic, copy) NSArray<BMFCoordinate *> *points;

/// 路段所经过的地理坐标集合内点的个数
@property (nonatomic, assign) int pointsCount;

/// 该路段起点方向值
@property (nonatomic, assign) int direction;

/// 路段入口信息
@property (nonatomic, strong) BMFRouteNode *entrace;

/// 路段入口的指示信息
@property (nonatomic, copy) NSString *entraceInstruction;

/// 路段出口信息
@property (nonatomic, strong) BMFRouteNode *exit;

/// 路段出口指示信息
@property (nonatomic, copy) NSString *exitInstruction;

/// 路段总体指示信息
@property (nonatomic, copy) NSString *instruction;

/// 路段需要转弯数
@property (nonatomic, assign) int numTurns;

/// 路段是否有路况信息
@property (nonatomic, assign) BOOL hasTrafficsInfo;

/// 路段的路况信息，成员为NSNumber。0：无数据；1：畅通；2：缓慢；3：拥堵
@property (nonatomic, copy) NSArray <NSNumber *> *traffics;

/**
 道路类型(Since 5.1.0)
 枚举值：返回0-9之间的值
 0：高速路  1：城市高速路  2:   国道  3：省道   4：县道    5：乡镇村道
 6：其他道路  7：九级路  8：航线(轮渡)  9：行人道路
 */
@property (nonatomic, assign) int roadLevel;

/// roadName since 6.3.0
@property (nonatomic, copy) NSString *roadName;

+ (instancetype)fromBMKDrivingStep:(BMKDrivingStep *)result;

@end


/// 室内路线结点
@interface BMFIndoorStepNode : BMFModel

/// 坐标
@property (nonatomic, strong) BMFCoordinate *coordinate;

/// 类型
@property (nonatomic, assign) int type;

/// 描述
@property (nonatomic, copy) NSString *desc;

+ (instancetype)fromBMKIndoorStepNode:(BMKIndoorStepNode *)result;

@end


/// 此类表示室内路线的一个路段
@interface BMFIndoorRouteStep : BMFModel

/// 路段长度 单位： 米
@property (nonatomic, assign) int distance;

/// 路段耗时 单位： 秒
@property (nonatomic, assign) int duration;

/// 路段所经过的地理坐标集合
@property (nonatomic, copy) NSArray<BMFCoordinate *> *points;

/// 路段所经过的地理坐标集合内点的个数
@property (nonatomic, assign) int pointsCount;

/// 入口信息
@property (nonatomic, strong) BMFRouteNode *entrace;

/// 出口信息
@property (nonatomic, strong) BMFRouteNode *exit;

/// 路段指示信息
@property (nonatomic, copy) NSString *instructions;

/// 建筑物id
@property (nonatomic, copy) NSString *buildingid;

/// 室内楼层id
@property (nonatomic, copy) NSString *floorid;

/// 结点数组，成员类型为：BMFIndoorStepNode
@property (nonatomic, copy) NSArray <BMFIndoorStepNode *> *indoorStepNodes;

+ (instancetype)fromBMKIndoorRouteStep:(BMKIndoorRouteStep *)result;

@end


/// 此类表示步行路线中的一个路段
@interface BMFWalkingStep : BMFModel

/// 路段长度 单位： 米
@property (nonatomic, assign) int distance;

/// 路段耗时 单位： 秒
@property (nonatomic, assign) int duration;

/// 路段所经过的地理坐标集合
@property (nonatomic, copy) NSArray<BMFCoordinate *> *points;

/// 路段所经过的地理坐标集合内点的个数
@property (nonatomic, assign) int pointsCount;

/// 该路段起点方向值
@property (nonatomic, assign) int direction;

/// 路段入口信息
@property (nonatomic, strong) BMFRouteNode *entrace;

/// 获取该路段入口指示信息
@property (nonatomic, copy) NSString *entraceInstruction;

/// 路段出口信息
@property (nonatomic, strong) BMFRouteNode *exit;

/// 获取该路段出口指示信息
@property (nonatomic, copy) NSString *exitInstruction;

/// 获取该路段指示信息
@property (nonatomic, copy) NSString *instruction;

+ (instancetype)fromBMKWalkingStep:(BMKWalkingStep *)result;

@end


/// 此类表示骑行路线中的一个路段
@interface BMFRidingStep : BMFModel

/// 路段长度 单位： 米
@property (nonatomic, assign) int distance;

/// 路段耗时 单位： 秒
@property (nonatomic, assign) int duration;

/// 路段所经过的地理坐标集合
@property (nonatomic, copy) NSArray<BMFCoordinate *> *points;

/// 路段所经过的地理坐标集合内点的个数
@property (nonatomic, assign) int pointsCount;

/// 该路段起点方向值
@property (nonatomic, assign) NSInteger direction;

/// 路段入口信息
@property (nonatomic, strong) BMFRouteNode *entrace;

/// 获取该路段入口指示信息
@property (nonatomic, copy) NSString *entraceInstruction;

/// 路段出口信息
@property (nonatomic, strong) BMFRouteNode *exit;

/// 获取该路段出口指示信息
@property (nonatomic, copy) NSString *exitInstruction;

/// 获取该路段指示信息
@property (nonatomic, copy) NSString *instruction;

/// 路段名
@property (nonatomic, copy) NSString *name;

/// 转弯类型
@property (nonatomic, copy) NSString *turnType;

+ (instancetype)fromBMKRidingStep:(BMKRidingStep *)result;

@end

#pragma mark - routeline

/// 此类表示一个换乘路线，换乘路线将根据既定策略调配多种交通工具
@interface BMFTransitRouteLine : BMFModel

/// 路线长度 单位： 米
@property (nonatomic, assign) int distance;

/// 路线耗时 单位： 秒
@property (nonatomic, strong) BMFTime *duration;

/// 路线起点信息
@property (nonatomic, strong) BMFRouteNode *starting;

/// 路线终点信息
@property (nonatomic, strong) BMFRouteNode *terminal;

/// 路线名称(预留字段，现为空)
//@property (nonatomic, copy) NSString *title;

/// 路线中的所有路段
@property (nonatomic, copy) NSArray<BMFTransitStep *> *steps;

+ (instancetype)fromBMKTransitRouteLine:(BMKTransitRouteLine *)result;

@end

/// 此类表示一条公共交通路线
@interface BMFMassTransitRouteLine : BMFModel

/// 路线长度 单位： 米
@property (nonatomic, assign) int distance;

/// 路线耗时 单位： 秒
@property (nonatomic, strong) BMFTime *duration;

/// 路线起点信息
@property (nonatomic, strong) BMFRouteNode *starting;

/// 路线终点信息
@property (nonatomic, strong) BMFRouteNode *terminal;

/// 路线名称(预留字段，现为空)
//@property (nonatomic, copy) NSString *title;

/// 路线中的所有路段
@property (nonatomic, copy) NSArray<BMFMassTransitStep *> *steps;

/// 路线花费
@property (nonatomic, assign) CGFloat price;

+ (instancetype)fromBMKMassTransitRouteLine:(BMKMassTransitRouteLine *)result;

@end


/// 此类表示一个室内路线
@interface BMFIndoorRouteLine : BMFModel

/// 路线长度 单位： 米
@property (nonatomic, assign) int distance;

/// 路线耗时 单位： 秒
@property (nonatomic, strong) BMFTime *duration;

/// 路线起点信息
@property (nonatomic, strong) BMFRouteNode *starting;

/// 路线终点信息
@property (nonatomic, strong) BMFRouteNode *terminal;

/// 路线名称(预留字段，现为空)
//@property (nonatomic, copy) NSString *title;
/// 路线中的所有路段
@property (nonatomic, copy) NSArray<BMFIndoorRouteStep *> *steps;

+ (instancetype)fromBMKIndoorRouteLine:(BMKIndoorRouteLine *)result;

@end


/// 此类表示一条驾车路线
@interface BMFDrivingRouteLine : BMFModel

/// 路线长度 单位： 米
@property (nonatomic, assign) int distance;

/// 路线耗时 单位： 秒
@property (nonatomic, strong) BMFTime *duration;

/// 路线起点信息
@property (nonatomic, strong) BMFRouteNode *starting;

/// 路线终点信息
@property (nonatomic, strong) BMFRouteNode *terminal;

/// 路线名称(预留字段，现为空)
//@property (nonatomic, copy) NSString *title;

/// 路线中的所有路段
@property (nonatomic, copy) NSArray<BMFDrivingStep *> *steps;

/// 路线途经点列表，成员类型为BMFPlanNode
@property (nonatomic, copy) NSArray <BMFPlanNode *> *wayPoints;

/// 路线红绿灯个数
@property (nonatomic, assign) NSInteger lightNum;

/// 路线拥堵米数，发起请求时需设置参数 drivingRequestTrafficType = BMF_DRIVING_REQUEST_TRAFFICE_TYPE_PATH_AND_TRAFFICE 才有值
@property (nonatomic, assign) NSInteger congestionMetres;

/// 路线预估打车费(元)，负数表示无打车费信息
@property (nonatomic, assign) NSInteger taxiFares;

+ (instancetype)fromBMKDrivingRouteLine:(BMKDrivingRouteLine *)result;

@end

/// 此类表示一条步行路线
@interface BMFWalkingRouteLine : BMFModel

@property (nonatomic, assign) int distance;

/// 路线耗时 单位： 秒
@property (nonatomic, strong) BMFTime *duration;

/// 路线起点信息
@property (nonatomic, strong) BMFRouteNode *starting;

/// 路线终点信息
@property (nonatomic, strong) BMFRouteNode *terminal;

/// 路线名称(预留字段，现为空)
//@property (nonatomic, copy) NSString *title;

/// 路线中的所有路段
@property (nonatomic, copy) NSArray<BMFWalkingStep *> *steps;

+ (instancetype)fromBMKWalkingRouteLine:(BMKWalkingRouteLine *)result;

@end

/// 此类表示一条骑行路线
@interface BMFRidingRouteLine : BMFModel

/// 路线长度 单位： 米
@property (nonatomic, assign) int distance;

/// 路线耗时 单位： 秒
@property (nonatomic, strong) BMFTime *duration;

/// 路线起点信息
@property (nonatomic, strong) BMFRouteNode *starting;

/// 路线终点信息
@property (nonatomic, strong) BMFRouteNode *terminal;

/// 路线名称(预留字段，现为空)
//@property (nonatomic, copy) NSString *title;

/// 路线中的所有路段
@property (nonatomic, copy) NSArray<BMFRidingStep *> *steps;

+ (instancetype)fromBMKRidingRouteLine:(BMKRidingRouteLine *)result;

@end

/// 路线搜索地址结果类.当输入的起点或终点有多个地点选择时，或者选定的城市没有此地点，但其它城市有(驾乘或步行)，返回该类的实例
@class BMFCityListInfo;
@interface BMFSuggestAddrInfo : BMFModel

/// 起点POI列表，成员类型为BMFPoiInfo
@property (nonatomic, copy) NSArray <BMFPoiInfo *> *startPoiList;

/// 起点城市列表，成员类型为BMFCityListInfo,如果输入的地点在本城市没有而在其它城市有，则返回其它城市的信息
@property (nonatomic, copy) NSArray <BMFCityListInfo *> *startCityList;

/// 终点POI列表，成员类型为BMFPoiInfo
@property (nonatomic, copy) NSArray <BMFPoiInfo *> *endPoiList;

/// 终点城市列表，成员类型为BMFCityListInfo,如果输入的地点在本城市没有而在其它城市有，则返回其它城市的信息
@property (nonatomic, copy) NSArray <BMFCityListInfo *> *endCityList;

/// 途经点POI列表，成员类型为NSArray<BMFPoiInfo*>
@property (nonatomic, copy) NSArray <NSArray<BMFPoiInfo *> *> *wayPointPoiList;

/// 途经点城市列表，成员类型为NSArray<BMFCityListInfo*>,如果输入的地点在本城市没有而在其它城市有，则返回其它城市的信息
@property (nonatomic, copy) NSArray <NSArray<BMFCityListInfo *> *> *wayPointCityList;

+ (instancetype)fromBMKSuggestAddrInfo:(BMKSuggestAddrInfo *)result;

@end

#pragma mark - 城市列表信息类
/// 城市列表信息类
@interface BMFCityListInfo : BMFModel

/// 城市名称
@property (nonatomic, copy) NSString *city;

/// 该城市所含搜索结果数目
@property (nonatomic, assign) NSInteger count;

+ (instancetype)fromBMKCityListInfo:(BMKCityListInfo *)result;

@end

#pragma mark - 以下数据结构之前存放在base组件中
/// 线路检索节点信息,一个路线检索节点可以通过经纬度坐标或城市名加地名确定
@interface BMFPlanNode : BMFModel

/// 节点所在城市
@property (nonatomic, copy) NSString *cityName;

/// 节点所在城市ID
@property (nonatomic, assign) NSInteger cityID;

/// 节点名称
@property (nonatomic, copy) NSString *name;

/// 节点坐标
@property (nonatomic, strong) BMFCoordinate *pt;

+ (instancetype)fromBMKPlanNode:(BMKPlanNode *)node;

- (BMKPlanNode *)toBMKPlanNode;

@end

/// 室内路线检索节点信息
@interface BMFIndoorPlanNode : BMFModel

/// 节点所在楼层
@property (nonatomic, copy) NSString *floor;

/// 节点坐标
@property (nonatomic, strong) BMFCoordinate *pt;

+ (instancetype)fromBMKIndoorPlanNode:(BMKIndoorPlanNode *)result;

- (BMKIndoorPlanNode *)toBMKIndoorPlanNode;

@end

///此类表示地址结果的层次化信息
@interface BMFAddressComponent : BMFModel

// 国家
@property (nonatomic, copy) NSString *country;

// 省份名称
@property (nonatomic, copy) NSString *province;

// 城市名称
@property (nonatomic, copy) NSString *city;

// 区县名称
@property (nonatomic, copy) NSString *district;

// 乡镇
@property (nonatomic, copy) NSString *town;

// 街道名称
@property (nonatomic, copy) NSString *streetName;

// 街道号码
@property (nonatomic, copy) NSString *streetNumber;

/// 行政区域编码
@property (nonatomic, copy) NSString *adCode;

/// 国家代码
@property (nonatomic, copy) NSString *countryCode;

// 相对当前坐标点的方向，当有门牌号的时候返回数据
@property (nonatomic, copy) NSString *direction;

// 相对当前坐标点的距离，当有门牌号的时候返回数据
@property (nonatomic, copy) NSString *distance;

+ (instancetype)fromBMKAddressComponent:(BMKAddressComponent *)result;

@end
NS_ASSUME_NONNULL_END
