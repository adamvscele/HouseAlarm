//
//  DIYOutBuffer.m
//  HouseAlarm
//
//  Created by macos on 2018/1/23.
//  Copyright © 2018年 jbu. All rights reserved.
//

#import "DIYOutBuffer.h"


@interface DIYOutBuffer ()

@end

@implementation DIYOutBuffer

+ (instancetype)newInstance:(NSData *)data{
    return [[DIYOutBuffer alloc] initWithData:data];
}


-(instancetype)initWithData:(NSData *)data {
    self = [super init];
    if (self) {
        self.datas = [NSMutableData dataWithData:data];
        self.offset = 0;
    }
    return self;
}


- (NSInteger)getLength {
    return [_datas length];
}

-(void)setLength{
    [_datas setLength:0];
}

- (void*)mutableBytes{
    return [_datas mutableBytes];
}

- (void)dirtyDataLen:(NSUInteger)length{
    self.offset += length;
}

@end
