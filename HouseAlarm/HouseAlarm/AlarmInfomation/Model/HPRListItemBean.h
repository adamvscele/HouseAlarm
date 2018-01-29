//
//  AlarmItemBean.h
//  HouseAlarm
//
//  Created by macos on 2018/1/27.
//  Copyright © 2018年 jbu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class AlarmCell_layoutInfo;

#define alarm_desc_font_size 15

@interface HPRListItemBean : NSObject

@property (nonatomic,strong) NSString* desc;
@property (nonatomic,strong) NSString* time;




@property (nonatomic,strong) AlarmCell_layoutInfo *alarmCellLayoutInfo;
@end

@interface AlarmCell_layoutInfo :NSObject
@property (nonatomic,assign) CGRect descLbFrame;
@property (nonatomic,assign) CGRect timeLbFrame;
@end
