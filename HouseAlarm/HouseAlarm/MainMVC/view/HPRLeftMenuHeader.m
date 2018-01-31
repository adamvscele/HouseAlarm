//
//  HPRLeftMenuHeader.m
//  HouseAlarm
//
//  Created by macos on 2018/1/30.
//  Copyright © 2018年 jbu. All rights reserved.
//

#import "HPRLeftMenuHeader.h"
#import "HPRUtils.h"
#import <Masonry.h>
#import <MMPlaceHolder.h>

#define HPR_SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width

@implementation HPRLeftMenuHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUi:frame];
    }
    return self;
}

-(void)setupUi:(CGRect) frame{
    _bgImage = [[UIImageView alloc] initWithFrame:frame];
    _bgImage.contentMode = UIViewContentModeScaleAspectFill;
   
    _bgImage.backgroundColor = [UIColor lightGrayColor];
    _bgImage.clipsToBounds = YES;
    [self addSubview:_bgImage];
    
    _portraitImage = [[UIImageView alloc] init];
    _portraitImage.backgroundColor = [UIColor redColor];
    _portraitImage.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:_portraitImage];
    
    _goDetail = [[UIImageView alloc] init];
    _goDetail.backgroundColor = [UIColor redColor];
    _goDetail.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:_goDetail];
    
    
    _userNameLabel = [[UILabel alloc] init];
    _userNameLabel.font = [UIFont systemFontOfSize:14];
    _userNameLabel.numberOfLines =1;
    _userNameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _userNameLabel.textColor= [UIColor colorWithHex:0xffffff];;
    [self addSubview:_userNameLabel];
    _userNameLabel.text = @"userName21212121";
    
    _descLabel = [[UILabel alloc] init];
    _descLabel.font = [UIFont systemFontOfSize:14];
    _descLabel.numberOfLines =0;
    _descLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _descLabel.textColor= [UIColor colorWithHex:0xffffff];;
    [self addSubview:_descLabel];
    _descLabel.text = @"desc";
    
    
    [self layoutUi];
}

-(void)layoutUi{
    [_bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_portraitImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(18);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
        make.width.equalTo(@120);
    }];
    
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_portraitImage.mas_right).offset(18);
        make.centerY.equalTo(self.mas_centerY);
        make.bottom.equalTo(_descLabel.mas_top).offset(-2);
         make.right.equalTo(_goDetail.mas_left);
        
    }];
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_portraitImage.mas_right).offset(18);
      
        make.top.equalTo(_userNameLabel.mas_bottom).offset(2);
       
    }];
    
    
    [_goDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.and.width.equalTo(@20);
        make.right.equalTo(self.mas_right);
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(_userNameLabel.mas_right);
   }];
    
    [self showPlaceHolder];
}


@end
