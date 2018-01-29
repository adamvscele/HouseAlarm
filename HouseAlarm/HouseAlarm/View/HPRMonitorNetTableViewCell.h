//
//  HPRMonitorNetTableViewCell.h
//  HouseAlarm
//
//  Created by macos on 2018/1/29.
//  Copyright © 2018年 jbu. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * monitorNetTableViewCell_indentifier;

@interface HPRMonitorNetTableViewCell : UITableViewCell

+ (instancetype)createReuseCellFromTableView:(UITableView *) tableview
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;



@end
