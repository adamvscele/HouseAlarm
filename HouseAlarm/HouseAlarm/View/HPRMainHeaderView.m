//
//  HPRMainHeaderView.m
//  HouseAlarm
//
//  Created by macos on 2018/1/29.
//  Copyright © 2018年 jbu. All rights reserved.
//

#import "HPRMainHeaderView.h"
#import "UIColor+Utils.h"
#import <Masonry.h>
#import <MMPlaceHolder.h>
@implementation HPRMainHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setUpUI:frame];
    }
    return self;
}

- (void)setUpUI:(CGRect)frame{
    _bgImage = [[UIImageView alloc] initWithFrame:frame];
    _bgImage.contentMode = UIViewContentModeScaleAspectFill;
    _bgImage.backgroundColor = [UIColor lightGrayColor];
    
    _bgImage.clipsToBounds = YES;
    
    [self addSubview:_bgImage];
    
    _leftImage=[[UIImageView alloc] init];
    _leftImage.image = [UIImage imageNamed:@"new_fire_ico"];
    //_leftImage.backgroundColor = [UIColor redColor];
    _leftImage.contentMode = UIViewContentModeScaleToFill;////图片拉伸变形
    [self addSubview:_leftImage];
    
    
    _statLabel = [[UILabel alloc] init];
    _statLabel.font = [UIFont systemFontOfSize:14];
    _statLabel.numberOfLines =0;
    _statLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _statLabel.textColor= [UIColor colorWithHex:0xffffff];;
    [self addSubview:_statLabel];
    _statLabel.text =@"stat";
    
    _descLable = [[UILabel alloc] init];
    _descLable.font = [UIFont systemFontOfSize:14];
    _descLable.numberOfLines =0;
    _descLable.lineBreakMode = NSLineBreakByTruncatingTail;
    _descLable.textColor= [UIColor colorWithHex:0xffffff];;
    [self addSubview:_descLable];
    _descLable.text =@"desc";
    
    _timeLale = [[UILabel alloc] init];
    _timeLale.font = [UIFont systemFontOfSize:14];
    _timeLale.numberOfLines =0;
    _timeLale.lineBreakMode = NSLineBreakByTruncatingTail;
    _timeLale.textColor= [UIColor colorWithHex:0xffffff];;
    [self addSubview:_timeLale];
    _timeLale.text = @"time";
    
    [self setLayout];
    
}
- (void)setLayout{
    [_bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(18);
        make.centerY.equalTo(self.mas_centerY);
       // make.top.equalTo(self).offset(10);
        //make.bottom.equalTo(self).offset(-10);
       // make.width.equalTo(@120);
    }];
    
    [_descLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(_leftImage.mas_right).offset(10);
    }];
    
    [_statLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftImage.mas_right).offset(10);
        make.bottom.equalTo(_descLable.mas_top).offset(-5);
        

    }];
    [_timeLale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftImage.mas_right).offset(10);
        make.top.equalTo(_descLable.mas_bottom).offset(5);
        
    }];
//    [_timeLale showPlaceHolder];

  //  [self showPlaceHolder];
    
}

-(void) setHeaderInfo:(NSString *)stat desc:(NSString *)desc time:(NSString *)time{
    _statLabel.text =stat;
    _descLable.text = desc;
    _timeLale.text = time;
}

@end
