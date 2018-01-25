//
//  HANotification.m
//  HouseAlarm
//
//  Created by macos on 2018/1/25.
//  Copyright © 2018年 jbu. All rights reserved.
//

#import "HANotification.h"

@implementation HANotification

+ (void) postNotification:(NSString* )notification userInfo:(NSDictionary*) userInfo object:(id)object{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:notification object:object];
    });
}

@end
