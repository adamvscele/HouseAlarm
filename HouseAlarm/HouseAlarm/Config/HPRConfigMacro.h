//
//  HPrConfigMacro.h
//  HouseAlarm
//
//  Created by macos on 2018/1/23.
//  Copyright © 2018年 jbu. All rights reserved.
//

#ifndef HAConfig_h
#define HAConfig_h

#define REMOTE_HOST      @"192.168.20.195"
#define REMOTE_PORT      1000

#ifdef DEBUG
#define LOG_PRINT       1
#else
#define LOG_PRINT       0
#endif

#if LOG_PRINT
#define LogHA(xx, ...)       NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#else

#define LogHA(xx, ...)       nil
#endif


#endif /* HPRConfigMacro_h */
