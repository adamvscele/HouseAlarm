//
//  SocketClient.h
//  HouseAlarm
//
//  Created by macos on 2018/1/23.
//  Copyright © 2018年 jbu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DIYOutBuffer;
@interface SocketClient : NSObject{
    @private
    //输入 读
    NSInputStream *_inputStream;
    //输出 写
    NSOutputStream *_outputStream;
    
    NSLock *_lockOut;
    NSLock *_lockInput;
    
}

+ (instancetype) instance;

- (void)connect:(NSString *)host port:(NSInteger )port;
- (void)disconnect;
- (void)writeData:(NSData *)data;

@end
