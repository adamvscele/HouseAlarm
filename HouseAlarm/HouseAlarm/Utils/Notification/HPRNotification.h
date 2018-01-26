//
//  HANotification.h
//  HouseAlarm
//  通知发布
//  Created by macos on 2018/1/25.
//  Copyright © 2018年 jbu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPRNotification : NSObject
+ (void) postNotification:(NSString* )notification  object:(id)object userInfo:(NSDictionary*) userInfo;

@end
