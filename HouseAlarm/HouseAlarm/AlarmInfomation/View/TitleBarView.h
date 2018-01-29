//
//  TitleBarView.h
//  HouseAlarm
//
//  Created by macos on 2018/1/27.
//  Copyright © 2018年 jbu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleBarView : UIScrollView

@property (nonatomic,strong)NSMutableArray *titleButtons;
@property (nonatomic,strong) void(^titleBtnClicked)(NSUInteger index);

- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray* )titles;


- (void)reloadAllButtonsOfTitleBarWithTitles:(NSArray*)titles;
@end
