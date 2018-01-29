//
//  SocketClient.m
//  HouseAlarm
//
//  Created by macos on 2018/1/23.
//  Copyright © 2018年 jbu. All rights reserved.
//

#import "SocketClient.h"
#import "DIYOutBuffer.h"

#import "HPRNotification.h"

#define BUFF_MAX_SIZE 1024

@interface SocketClient ()<NSStreamDelegate>

//接收缓冲区
@property (nonatomic,strong) NSMutableData * inBuf;
//发送缓冲区列表
@property (nonatomic,strong) NSMutableArray *outBufArray;
/*
 *当前是否可以发送数据 第一次以收到NSStreamEventHasSpaceAvailable消息为可以发送数据标识
 *mbCanWriteData 为false时不可 write数据 否则将会引起
 *防止多线程调用 writeData导致stream破坏
 */
@property (nonatomic,assign) BOOL   mbCanWriteData;

-(void) onEventIn:(NSStream *)aStream;
-(void) onEventOut:(NSStream *)aStream;
-(void) onEventError:(NSStream *)aStream;




- (DIYOutBuffer *)nextOutBuffer;

@end
@implementation SocketClient

#pragma mark - /*单例*/
+(instancetype)instance {
    static SocketClient *g_client;
    static dispatch_once_t _once;
    dispatch_once(&_once,^{
        //LogHA(@"dispatch_once thread %@",[NSThread currentThread]);

        g_client = [[SocketClient alloc] init];
        [g_client initBase];
    });
    return g_client;
}

//resetBase
-(void)initBase{
 
    _mbCanWriteData = FALSE;
    _inBuf= [NSMutableData data];
    _outBufArray = [NSMutableArray array];
    
    _lockInput = [[NSLock alloc] init];
    _lockOut =[[NSLock alloc] init];
}


-(void)connect:(NSString *)host port:(NSInteger)port {
    LogHA(@"********socket connect remote<ip:%@ port:%ld>",host,port);
    _mbCanWriteData = FALSE;
    NSInputStream *tmpInput =nil;
    NSOutputStream *tmpOut = nil;
    [NSStream getStreamsToHostWithName:host port:port inputStream:&tmpInput outputStream:&tmpOut];
    _inputStream = tmpInput;
    _outputStream = tmpOut;
    
    LogHA(@"_inputStream:<%@> _outputStream:<%@>",_inputStream,_outputStream);
    [_inputStream setDelegate:self];
    [_outputStream setDelegate:self];
    
    [_inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    [_outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    [_inputStream open];
    [_outputStream open];
}

-(void)disconnect {
    LogHA(@"********socket 断开");
    _mbCanWriteData = FALSE;
    _lockInput = nil;
    _lockOut = nil;
    
    //TODO 判断是否打开？？
    if (_inputStream) {
        [_inputStream close];
        [_inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        _inputStream = nil;
    }
    if (_outputStream) {
        [_outputStream close];
        [_outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        _outputStream = nil;
    }
    
    _inBuf = nil;
    _outBufArray = nil;

}




-(void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode{
//        LogHA(@"handleEvent thread %@",[NSThread currentThread]);
    

    switch (eventCode) {
        case NSStreamEventOpenCompleted:
            LogHA(@"NSStreamEventOpenCompleted aStream:<%@>",aStream);
            break;
        case NSStreamEventHasBytesAvailable://每读一条后 便回调一次。告诉后面的可继续

            LogHA(@"NSStreamEventHasBytesAvailable aStream:<%@>",aStream);

              [self onEventIn:aStream];
            break;
        case NSStreamEventHasSpaceAvailable://每发送完一条后 便回调一次。告诉后面的可继续发送0
            LogHA(@"NSStreamEventHasSpaceAvailable aStream:<%@>",aStream);

            [self onEventOut:aStream];
            break;
        case NSStreamEventEndEncountered://已经抵达流的结尾。读取结束//连接断开或结束
            LogHA(@"NSStreamEventEndEncountered aStream:<%@>",aStream);

            [self onEventError:aStream];
            break;
        case NSStreamEventErrorOccurred:
            //有错误发生时 系统不会关闭socket 因此服务端仍会显示／以为socket已连接 必须手动关闭socket
            LogHA(@"NSStreamEventErrorOccurred aStream:<%@>",aStream);

            
            [self onEventError:aStream];
            break;

        case NSStreamEventNone:
            LogHA(@"NSStreamEventNone");
            break;
            
        default:
            break;
    }
}


-(void) onEventIn:(NSStream *)aStream {
    if (aStream) {
        uint8_t buf[BUFF_MAX_SIZE] ={0};
        NSInteger lenRecv =[(NSInputStream*) aStream read:buf maxLength:BUFF_MAX_SIZE];
        //LogHA(@"received data num: %zd",lenRecv);
        
        if (lenRecv >0) {
            [_lockInput lock];
            
            [_inBuf appendBytes:(const char *)buf length:lenRecv];
            NSString *msg = [self stringWithData:_inBuf];
            LogHA(@"onEventIn dataString:<%@>",[self stringWithData:_inBuf]);
            
            
            [HPRNotification postNotification:HPRNotificationRecvdMessage object:msg userInfo:nil];
            [_lockInput unlock];
            
            
            [self testResponse];
            
        }
    }
}

- (void)writeData:(NSData *)data{
    [_lockOut lock];
    //NSLog(@"writeData  locked");
    DIYOutBuffer * tmpOutBuf =nil;
    @try {
        if (YES == self.mbCanWriteData) {
            NSInteger lenAll =[data length];
            const void* bytes = NULL;
            if ([data isKindOfClass:[NSMutableData class]]) {
                
                bytes =[(NSMutableData * )data mutableBytes] ;
            }else{
                bytes =[data bytes] ;
            }
            
            NSInteger lenWrite = [_outputStream write:bytes maxLength:lenAll];
            self.mbCanWriteData =FALSE;//防止多线程调用 writeData导致stream破坏
            LogHA(@"writing data writed %ld",lenWrite);
            if (lenWrite >0) {
                if (lenWrite < lenAll) {
                    tmpOutBuf =[DIYOutBuffer newInstance:[data subdataWithRange:NSMakeRange(lenWrite, lenAll-lenWrite)]];
                }
            }else{
                //                NSInteger status =[_outputStream streamStatus];
                //                if (status ==NSStreamStatusError) {
                //                    LogHA(@"NSStreamStatusError ");
                //                }
                //                NSError *error = [_outputStream streamError];
                //                LogHA(@"writing error %@",error);
            }

        }else{
            NSLog(@"NO == self.mbCanWriteData");
            tmpOutBuf = [DIYOutBuffer newInstance:data];
        }
        //测试数据
//        for (int i=0 ; i<5; i++) {
//            DIYOutBuffer* tmp =[DIYOutBuffer newInstance:data];
//            if (i == 3) {
//                [tmp setLength];
//            }
//            [_outBufArray addObject:tmp];
//
//        }
        
        if (tmpOutBuf) {
            [_outBufArray addObject:tmpOutBuf];
        }
        
    } @catch (NSException *exception) {
        LogHA(@" ***** NSException in writeData :%@  ******* ",exception);
        
    } @finally {
        [_lockOut unlock];
        //        NSLog(@"writeData unlock");
    }
}

- (void)onEventOut:(NSStream *)aStream {
    //NSLog(@"onEventOut prepare lock");
    [_lockOut lock];
     //NSLog(@"onEventOut  locked");
    @try {
        
        DIYOutBuffer *outbuf  =[self nextOutBuffer];
        if (!outbuf) {//没有未发出的数据了
            return;
        }
        NSInteger lenWillWrite = [outbuf getLength] - outbuf.offset;
        
        NSInteger lenWrited = [_outputStream write:[outbuf mutableBytes] maxLength:lenWillWrite];
       
        NSInteger lenLeft = lenWillWrite - lenWrited;
        if (!lenLeft) {
            [_outBufArray removeObjectAtIndex:0];
        }else if(lenLeft >0){
            //增加偏移量
            [outbuf dirtyDataLen:lenWrited];
        }
        
        self.mbCanWriteData =NO;//发送中等待发送结果
        
    } @catch (NSException *exception) {
        LogHA(@" ***** NSException in MGJMTalkCleint :%@  ******* ",exception);

    } @finally {
        [_lockOut unlock];
        //NSLog(@"onEventOut unlock");
    }
    
}



/*
 *  只要有一个Socket发生错误 就断开整个连接
 ** 保证整个通信的完整性
 **/

-(void)onEventError:(NSStream *)aStream{
    [self disconnect];
}



/**
 *输出缓冲区内的 数组中的下一条将要发送的数据
 **/
- (DIYOutBuffer *)nextOutBuffer{
    DIYOutBuffer *outbuf = nil;
    for (int i=0 ; i< [_outBufArray count]; i++) {
        outbuf = [_outBufArray objectAtIndex:0];
        NSInteger lenAll = [outbuf getLength];
        
        if (!lenAll || !(lenAll - outbuf.offset)) {
            //该条数据是已发送或空数据
            [_outBufArray removeObjectAtIndex:0];
            continue;
        }
        return outbuf;
    }
    self.mbCanWriteData =YES;
    return nil;
}



-(void) testResponse{
    NSString *myString = @"123我收到了123";
    size_t strLen =[myString length];
    const char *utfString = [myString UTF8String];
    
    strLen =strlen(utfString);
    
    
    NSData *data;
    data = [NSData dataWithBytes:utfString length:strLen];
    NSMutableData *data2 =[[NSMutableData alloc]init];
    [data2 appendData:data];
    [self writeData:data];
    
}




- (NSString *)stringWithData:(NSData *)d{
    NSString * str =[[NSString alloc]initWithData:d encoding:NSUTF8StringEncoding];
    return str;
}


@end
