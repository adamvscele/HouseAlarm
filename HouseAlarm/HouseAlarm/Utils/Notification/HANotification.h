//
//  HANotification.h
//  HouseAlarm
//
//  Created by macos on 2018/1/25.
//  Copyright © 2018年 jbu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HANotification : NSObject
+ (void) postNotification:(NSString* )notification userInfo:(NSDictionary*) userInfo object:(id)object;

@end
