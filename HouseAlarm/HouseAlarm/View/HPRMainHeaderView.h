//
//  HPRMainHeaderView.h
//  HouseAlarm
//
//  Created by macos on 2018/1/29.
//  Copyright © 2018年 jbu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HPRMainHeaderView : UIView
@property (nonatomic,strong)UIImageView *bgImage;
@property (nonatomic,strong)UIImageView *leftImage;
@property (nonatomic,strong)UILabel * statLabel;
@property (nonatomic,strong)UILabel *descLable;
@property (nonatomic,strong)UILabel *timeLale;


- (void)setHeaderInfo:(NSString *) stat desc:(NSString *)desc time:(NSString *) time;
@end
