//
//  HPRLeftMenuCell.m
//  HouseAlarm
//
//  Created by macos on 2018/1/30.
//  Copyright © 2018年 jbu. All rights reserved.
//

#import "HPRLeftMenuCell.h"
@interface HPRLeftMenuCell()
@property (weak, nonatomic) IBOutlet UIImageView *imgCell;
@property (weak,nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation HPRLeftMenuCell

+ (instancetype)createCellFromTableView:(UITableView *)tv indexPath:(NSIndexPath *)indexPath identifier:(NSString *)identifier{
    HPRLeftMenuCell * cell =[tv dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
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
