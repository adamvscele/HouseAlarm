//
//  HPRMainViewController.m
//  HouseAlarm
//
//  Created by macos on 2018/1/26.
//  Copyright © 2018年 jbu. All rights reserved.
//

#import "HPRMainViewController.h"
#import "UIViewController+CWLateralSlide.h"
#import "SlideViewController.h"

#import "PushNotificationManager.h"
#import <TSMessage.h>
@interface HPRMainViewController ()<UNUserNotificationCenterDelegate>


@end

@implementation HPRMainViewController

- (void)regNotificationCenter{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                  selector:@selector(cbRecvMsg:)
                                  name:HPRNotificationRecvdMessage
                             object:nil];
}

- (void) cbRecvMsg:(NSNotification*) notification{
    LogHA(@"Main UI  cbRecvMsg");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self regNotificationCenter];
    self.slideLeftVC = [[SlideViewController alloc] initWithNibName:@"SlideViewController" bundle:nil];
       [[UNUserNotificationCenter currentNotificationCenter] setDelegate:self];
    
    
}

-(IBAction)onClickLeftSlide:(id)sender{
    
    [self cw_showDefaultDrawerViewController: self.slideLeftVC];

}

-(IBAction)onClickRightFunc:(id)sender{
    
     [[PushNotificationManager sharedInstance]normalPushNotificationWithTitle:@"John Winston Lennon" subTitle:@"《Imagine》" body:@"You may say that I'm a dreamer, but I'm not the only one" identifier:@"1-1" timeInterval:3 repeat:NO];   //`repeat` if you pick the repeat property 'YES',you require to set the timeInterval value >= 60second ->是否重复,若要重复->时间间隔应>=60s
    
}

#pragma mark - `Receives the push notification in the foreground`->`前台收到推送`
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
{
    NSString *identifier = notification.request.identifier;
    NSString *categoryIdentifier = notification.request.content.categoryIdentifier;
    //    NSDictionary * userInfo = notification.request.content.userInfo;
    if ([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //remote notification,do nothing
    }else{
        //reminder
        if (identifier) {
            [TSMessage showNotificationWithTitle:[NSString stringWithFormat:@"identifier:%@",identifier] type:TSMessageNotificationTypeMessage];
        }
        if (categoryIdentifier) {
            [TSMessage showNotificationWithTitle:[NSString stringWithFormat:@"categoryIdentifier:%@",categoryIdentifier] type:TSMessageNotificationTypeMessage];
        }
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
}
#pragma mark - `Receives the push notification in the background`->`应用在后台收到推送的处理方法`
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler
{
    //   NSDictionary * userInfo = response.notification.request.content.userInfo;
    
    NSString *identifier =  response.notification.request.identifier;
    NSString *categoryIdentifier = response.notification.request.content.categoryIdentifier;
    DLog(@"identifier:%@\n,categoryIdentifier:%@",identifier,categoryIdentifier);
    
    if ([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //remote notification,do nothing
    }else{
        if ([identifier isEqualToString:@"5-2"]) {
            if ([response.actionIdentifier isEqualToString:@"reply"]) {
                UNTextInputNotificationResponse *textResponse = (UNTextInputNotificationResponse *)response;
                DLog(@"%@",textResponse.userText);
                [TSMessage showNotificationWithTitle:[NSString stringWithFormat:@"%@",textResponse.userText] type:TSMessageNotificationTypeMessage];
            }else if ([response.actionIdentifier isEqualToString:@"enter"]){
                [TSMessage showNotificationWithTitle:@"进入" type:TSMessageNotificationTypeMessage];
            }else if ([response.actionIdentifier isEqualToString:@"cancel"]){
                [TSMessage showNotificationWithTitle:@"取消" type:TSMessageNotificationTypeMessage];
            }
        }
        
        //reminder
        if (identifier) {
            [TSMessage showNotificationWithTitle:[NSString stringWithFormat:@"identifier:%@",identifier] type:TSMessageNotificationTypeMessage];
        }
        if (categoryIdentifier) {
            [TSMessage showNotificationWithTitle:[NSString stringWithFormat:@"categoryIdentifier:%@",categoryIdentifier] type:TSMessageNotificationTypeMessage];
        }
    }
    completionHandler();
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
