//
//  UIColor+Utils.m
//  HouseAlarm
//
//  Created by macos on 2018/1/27.
//  Copyright © 2018年 jbu. All rights reserved.
//

#import "UIColor+Utils.h"

@implementation UIColor (Utils)

+(UIColor *)colorWitHex:(int)hexValue alpha:(CGFloat)alpha{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:alpha];
}

+(UIColor *)colorWitHex:(int)hex{
    
    return [UIColor colorWitHex:hex alpha:1.0];
}

+(UIColor *)selectCellColor{
    return [UIColor colorWitHex:0xfcfcfc];
}

+(UIColor *)titleColor{
    return [UIColor colorWitHex:0x111111];
}

+(UIColor *)selectBtnColor{
    return [UIColor colorWitHex:(0x24CF5F)];
}

+ (UIColor *)titleBarColor//标题滚动按钮背景色
{
    return [UIColor colorWitHex:0xf6f6f6];
}
@end
