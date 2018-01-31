//
//  UIColor+Utils.m
//  HouseAlarm
//
//  Created by macos on 2018/1/27.
//  Copyright © 2018年 jbu. All rights reserved.
//

#import "UIColor+Utils.h"

@implementation UIColor (Utils)

+(UIColor *)colorWithHex:(int)hexValue alpha:(CGFloat)alpha{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:alpha];
}

+(UIColor *)colorWithHex:(int)hex{
    
    return [UIColor colorWithHex:hex alpha:1.0];
}
/*导航栏背景*/
+(UIColor *)navigationbarColor{
    return [UIColor colorWithHex:0x0081ff];
}

+(UIColor *)selectCellColor{
    return [UIColor colorWithHex:0xfcfcfc];
}

+(UIColor *)titleColor{
    return [UIColor colorWithHex:0x111111];
}

+(UIColor *)selectBtnColor{
    return [UIColor colorWithHex:(0x24CF5F)];
}

+ (UIColor *)titleBarColor//标题滚动按钮背景色
{
    return [UIColor colorWithHex:0xf6f6f6];
}
@end
