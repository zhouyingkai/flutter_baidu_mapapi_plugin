//
//  BMFSuggestionSearch.h
//  flutter_baidu_mapapi_base
//
//  Created by zhangbaojin on 2020/4/15.
//

#import <flutter_baidu_mapapi_base/BMFModel.h>



@class BMFCoordinate;
@class BMKSuggestionSearchOption;


@class BMKSuggestionChildrenInfo;
@class BMKSuggestionInfo;
@class BMKSuggestionSearchResult;

NS_ASSUME_NONNULL_BEGIN

/// sug检索信息类
@interface BMFSuggestionSearchOption : BMFModel

/// 搜索关键字，必选
@property (nonatomic, copy) NSString *keyword;

/// 城市名，参数也可以传入citycode，必选
@property (nonatomic, copy) NSString *cityname;

/// 指定位置，可选，注：会影响关键字不在设置城市范围内时的检索结果，故不建议使用。
@property (nonatomic, strong) BMFCoordinate *location;

/// 是否只返回指定城市检索结果（默认：NO）（提示：海外区域暂不支持设置cityLimit）
@property (nonatomic, assign) BOOL cityLimit;

- (BMKSuggestionSearchOption *)toBMKSuggestionSearchOption;

@end

#pragma mark - Sug检索子节点结果类
@interface BMFSuggestionChildrenInfo : BMFModel
/// poi子点uid
@property (nonatomic, copy) NSString *uid;
/// poi子点名称
@property (nonatomic, copy) NSString *name;
/// poi子点简称
@property (nonatomic, copy) NSString *showName;

+ (instancetype)fromBMKSuggestionChildrenInfo:(BMKSuggestionChildrenInfo *)result;

@end
#pragma mark - Sug检索结果类

@interface BMFSuggestionInfo : BMFModel

/// 联想词联想词名称
@property (nonatomic, copy) NSString *key;
/// 联想结果经纬度坐标
@property (nonatomic, strong) BMFCoordinate *location;
/// 联想结果唯一标示，ID
@property (nonatomic, copy) NSString *uid;
/// 联想结果所在城市
@property (nonatomic, copy) NSString *city;
/// 联想结果所在区县
@property (nonatomic, copy) NSString *district;
/// 联想结果分类，默认不召回，需要权限。
@property (nonatomic, copy) NSString *tag;
/// 联想结果地址，默认不召回，需要权限。
@property (nonatomic, copy) NSString *address;
/// 联想结果子节点，默认不召回，需要权限。
@property (nonatomic, copy) NSArray <BMFSuggestionChildrenInfo *> *children;

+ (instancetype)fromBMKSuggestionInfo:(BMKSuggestionInfo *)result;

@end

@interface BMFSuggestionSearchResult : BMFModel

/// Sug检索结果列表
@property (nonatomic, copy) NSArray <BMFSuggestionInfo *> *suggestionList;

+ (instancetype)fromBMKSuggestionSearchResult:(BMKSuggestionSearchResult *)result;

@end

NS_ASSUME_NONNULL_END
