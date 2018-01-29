//
//  HPRMonitorNetTableViewCell.m
//  HouseAlarm
//
//  Created by macos on 2018/1/29.
//  Copyright © 2018年 jbu. All rights reserved.
//

#import "HPRMonitorNetTableViewCell.h"

NSString * monitorNetTableViewCell_indentifier = @"MonitorNetTableViewCell_indentifier";
@implementation HPRMonitorNetTableViewCell

+(instancetype)createReuseCellFromTableView:(UITableView *)tableview indexPath:(NSIndexPath *)indexPath identifier:(NSString *)identifier{
    HPRMonitorNetTableViewCell * cell = [tableview dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
