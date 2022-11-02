//
//  BMFDicModel.h
//  flutter_baidu_mapapi_base
//
//  Created by zbj on 2020/2/10.
//  Copyright © 2020 zbj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BMFDicModel <NSObject>

@optional
/// 数组中需要转换的模型类
/// array model class配置
+ (NSDictionary *)bmf_setupObjectClassInArray;


/// 将属性名换为其他key去字典中取值
+ (NSDictionary *)bmf_setupReplacedKeyFromPropertyName;

/// 数组中的属性将忽略转换(dic -> model)
+ (NSArray *)bmf_setupIgnorePropertyNames;

@required

/// dic -- > model
+ (instancetype)bmf_modelWith:(nullable NSDictionary *)dic;


/// model -- > dic
- (NSDictionary *)bmf_toDictionary;

@end

NS_ASSUME_NONNULL_END
