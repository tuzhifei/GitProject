//
//  UIColor+Extention.h
//  router
//
//  Created by mark on 2019/6/6.
//  Copyright © 2019 Wireless Department. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Extention)


+ (UIColor *)colorWithHex:(long)hexColor;

+ (UIColor *)colorWithHex:(long)hexColor alpha:(CGFloat)alpha;

//随机颜色
+ (UIColor *)RandomColor ;


@end

NS_ASSUME_NONNULL_END
