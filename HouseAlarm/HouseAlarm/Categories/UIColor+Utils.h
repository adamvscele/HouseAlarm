//
//  UIColor+Utils.h
//  HouseAlarm
//
//  Created by macos on 2018/1/27.
//  Copyright © 2018年 jbu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Utils)
+ (UIColor *)colorWithCGColor:(CGColorRef)cgColor alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHex:(int)hex;


+ (UIColor *)navigationbarColor;
+ (UIColor *)selectCellColor;

+ (UIColor *)titleColor;

+ (UIColor *)selectBtnColor;

+ (UIColor *)titleBarColor;
@end
