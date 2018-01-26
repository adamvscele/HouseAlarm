//
//  HANotification.m
//  HouseAlarm
//
//  Created by macos on 2018/1/25.
//  Copyright © 2018年 jbu. All rights reserved.
//

#import "HPRNotification.h"

@implementation HPRNotification
+(void)postNotification:(NSString *)notification object:(id)object userInfo:(NSDictionary *)userInfo{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:notification object:object userInfo:userInfo];
        });
}




@end
