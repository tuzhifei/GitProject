//
//  UIColor+Extention.m
//  router
//
//  Created by mark on 2019/6/6.
//  Copyright © 2019 Wireless Department. All rights reserved.
//

#import "UIColor+Extention.h"

@implementation UIColor (Extention)


+ (UIColor *)colorWithHex:(long)hexColor {
    
    CGFloat red = ((CGFloat)((hexColor & 0xFF0000) >> 16))/255.0f;
    CGFloat green = ((CGFloat)((hexColor & 0xFF00) >> 8))/255.0f;
    CGFloat blue = ((CGFloat)(hexColor & 0xFF))/255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

+ (UIColor *)colorWithHex:(long)hexColor alpha:(CGFloat)alpha{
    
    CGFloat red = ((CGFloat)((hexColor & 0xFF0000) >> 16))/255.0f;
    CGFloat green = ((CGFloat)((hexColor & 0xFF00) >> 8))/255.0f;
    CGFloat blue = ((CGFloat)(hexColor & 0xFF))/255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


+ (UIColor *)RandomColor {
    NSInteger aRedValue = arc4random() % 255;
    NSInteger aGreenValue = arc4random() % 255;
    NSInteger aBlueValue = arc4random() % 255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue / 255.0f green:aGreenValue / 255.0f blue:aBlueValue / 255.0f alpha:1.0f];
    return randColor;
}


@end
