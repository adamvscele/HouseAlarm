//
//  DIYOutBuffer.h
//  HouseAlarm
//  自定义的输出缓冲区
//  Created by macos on 2018/1/23.
//  Copyright © 2018年 jbu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DIYOutBuffer : NSObject
//发送数据部分
@property (nonatomic,strong)NSMutableData *datas;
//发送偏移量
@property (nonatomic,assign) NSInteger offset;


+(instancetype)newInstance:(NSData *)data;

-(instancetype)initWithData:(NSData *)data;

- (NSInteger)getLength;

- (void *)mutableBytes;

- (void) dirtyDataLen:(NSUInteger)length;



-(void)setLength;

@end
