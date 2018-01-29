//
//  HPRAlarmCell.h
//  HouseAlarm
//
//  Created by macos on 2018/1/27.
//  Copyright © 2018年 jbu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define AlarmCellReuseIdentifier  @"HPRAlarmCell"

@class HPRListItemBean;
@interface HPRAlarmCell : UITableViewCell

+ (instancetype) createReusedCellFromTableView:(UITableView *)tableView
                               indexPath:(NSIndexPath *)indexPath
                              identifier:(NSString *)identifier;

@property (nonatomic,strong) HPRListItemBean *listItemBean;
@end
