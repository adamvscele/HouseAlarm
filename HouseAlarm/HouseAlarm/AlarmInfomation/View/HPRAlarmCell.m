//
//  HPRAlarmCell.m
//  HouseAlarm
//
//  Created by macos on 2018/1/27.
//  Copyright © 2018年 jbu. All rights reserved.
//

#import "HPRAlarmCell.h"
#import "HPRUtils.h"
#import "HPRListItemBean.h"

@implementation HPRAlarmCell{
    
    UILabel *descLabel;
    UILabel *timeLabel;
}



+(instancetype)createReusedCellFromTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath identifier:(NSString *)identifier{
    HPRAlarmCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
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


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addCustomViews];
    }
    return self;
}


- (void)addCustomViews{
    descLabel = [UILabel new];
    descLabel.numberOfLines =2;
    descLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    descLabel.textColor = [UIColor titleColor];
    descLabel.font = [UIFont systemFontOfSize:alarm_desc_font_size];
    [self.contentView addSubview:descLabel];
    
     timeLabel= [UILabel new];
    timeLabel.numberOfLines =2;
    timeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    timeLabel.textColor = [UIColor titleColor];
    timeLabel.font = [UIFont systemFontOfSize:alarm_desc_font_size];
    [self.contentView addSubview:timeLabel];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    descLabel.frame = _listItemBean.alarmCellLayoutInfo.descLbFrame;
    timeLabel.frame = _listItemBean.alarmCellLayoutInfo.timeLbFrame;
}
-(void)setListItemBean:(HPRListItemBean *)listItemBean{
    _listItemBean = listItemBean;
    descLabel.text = _listItemBean.desc;
    timeLabel.text = _listItemBean.time;
    [self layoutSubviews];
}

@end
