//
//  UIColor+BMFString.h
//  flutter_baidu_mapapi_base
//
//  Created by zbj on 2020/2/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor(BMFString)

/// 16进制colorString -> UIColor
+ (UIColor *)fromColorString:(NSString *)colorString;

/// UIColor -> 16进制colorString
+ (NSString *)colorStringFrom:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
