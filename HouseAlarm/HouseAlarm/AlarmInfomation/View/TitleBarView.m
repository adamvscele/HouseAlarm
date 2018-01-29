//
//  TitleBarView.m
//  HouseAlarm
//
//  Created by macos on 2018/1/27.
//  Copyright © 2018年 jbu. All rights reserved.
//

#import "TitleBarView.h"
#import "UIColor+Utils.h"
#define MinBtnWidth  80
#define kScreenSize [UIScreen mainScreen].bounds.size

@interface TitleBarView()


@property (nonatomic,assign)NSUInteger currentIndex;

@end

@implementation TitleBarView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles{
    self =[super initWithFrame:frame];
    if (self) {
        [self reloadAllButtonsOfTitleBarWithTitles:titles];
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

-(void)reloadAllButtonsOfTitleBarWithTitles:(NSArray *)titles{
    if (self.titleButtons) {
        NSArray* btns = self.titleButtons.copy;
        for (UIButton *btn in btns){
            [btn removeFromSuperview];
        }
    }
    
    self.currentIndex = 0;
    self.titleButtons = [NSMutableArray new];
    CGFloat btnWidth = self.frame.size.width / titles.count;
    CGFloat btnHeight = self.frame.size.height;
    
    if (titles.count * MinBtnWidth >self.frame.size.width) {
        self.contentSize = CGSizeMake(titles.count* MinBtnWidth, self.frame.size.height);
        btnWidth = MinBtnWidth;
    }
    else{
        self.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    }
    
    [titles enumerateObjectsUsingBlock:^(NSString *title,NSUInteger idx,BOOL * stop){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor =[UIColor clearColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:[UIColor colorWithHex:0x909090] forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateNormal];
        
        btn.frame = CGRectMake(btnWidth *idx, 0,btnWidth, btnHeight);
        btn.tag = idx;
        [btn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [_titleButtons addObject:btn];
        [self addSubview:btn];
        [self sendSubviewToBack:btn];
        
    }];
    //默认选择第一个按钮
    UIButton *firstTitle = _titleButtons[0];
    [firstTitle setTitleColor:[UIColor selectBtnColor] forState:UIControlStateNormal];
}

-(void)onClick:(UIButton *)button{
    if (self.currentIndex != button.tag) {
        [self scrollToCenterWithIndex:button.tag];
        self.titleBtnClicked(button.tag);
    }
}

/*
 **移动并设置按钮颜色
 */
-(void)scrollToCenterWithIndex:(NSInteger )index{
    UIButton *preBtn = _titleButtons[_currentIndex];
    [preBtn setTitleColor:[UIColor colorWithHex:0x909090] forState:(UIControlStateNormal)];
    _currentIndex = index;
    
    UIButton* btn =_titleButtons[index];
    [btn setTitleColor:[UIColor selectBtnColor] forState:UIControlStateNormal];
    //UIButton *btn = [self viewWithTag:index];
    
    if (self.contentSize.width >self.frame.size.width) {
        //scroll
        if (CGRectGetMidX(btn.frame) <kScreenSize.width/2) {
            [self setContentOffset:CGPointZero animated:YES];
        }else if(self.contentSize.width - CGRectGetMidX(btn.frame) <kScreenSize.width/2){
            [self setContentOffset:CGPointMake(self.contentSize.width-CGRectGetWidth(self.frame), 0 ) animated:YES];
        }else{
            CGFloat needScrolloWidth = CGRectGetMidX(btn.frame)  - kScreenSize.width/2;
            [self setContentOffset:CGPointMake(needScrolloWidth, 0) animated:YES];
            
        }
    }
    
}




@end
