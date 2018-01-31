//
//  HPRLeftMenuCell.h
//  HouseAlarm
//
//  Created by macos on 2018/1/30.
//  Copyright © 2018年 jbu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HPRLeftMenuCell : UITableViewCell

+ (instancetype)createCellFromTableView:(UITableView *) tv
                              indexPath:(NSIndexPath *)indexPath
                             identifier:(NSString *)identifier;
@end
