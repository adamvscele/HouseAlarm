//
//  AppDelegate.m
//  HouseAlarm
//
//  Created by macos on 2018/1/23.
//  Copyright © 2018年 jbu. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

#import "SocketClient.h"
#import "HPRMainViewController.h"
#import "UIColor+Utils.h"
#import "HcdGuideView.h"
#import "HPRLoginViewController.h"

#define kSystemVersion [[UIDevice currentDevice].systemVersion floatValue]
@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    /*
    if (1) {
        self.window =[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds] ];
         UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
         HPRMainViewController *vc =[storyboard instantiateInitialViewController];
         self.window.rootViewController =vc;
        self.window.backgroundColor =[UIColor whiteColor];
        [self.window makeKeyAndVisible];
    }*/
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    BOOL bLogined = [userDefaults boolForKey:@"user_logined"];
  
    bLogined = true;
    self.window =[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds] ];
      self.window.backgroundColor =[UIColor whiteColor];
    if (bLogined) {
        
    //app init over 后 HPRMainViewController再显示 因为navcontroller过滤
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        HPRMainViewController *vc =[storyboard instantiateInitialViewController];
        self.window.rootViewController =vc;
        

    }else{
        //HPRLoginViewController先显示 后app init over
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        HPRLoginViewController *vc =[storyboard instantiateInitialViewController];
        self.window.rootViewController =vc;
    }
     [self.window makeKeyAndVisible];
    
    [[HcdGuideView sharedInstance] showGuideViews:self.window];

    
    
     LogHA(@"app init over");
    int sysVer =kSystemVersion;
    if (sysVer >= 10.0) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        //center.delegate = self;
        UNAuthorizationOptions types=UNAuthorizationOptionBadge|UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
        [center requestAuthorizationWithOptions:types completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                    
                }];
            } else {
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@""} completionHandler:^(BOOL success) { }];
            }
        }];
    }else if (sysVer >= 8.0){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil]];
#pragma clang diagnostic pop
    }
    
    
   //[self test];
    
    LogHA(@"*******application launched main thread %@",[NSThread currentThread]);
    [[SocketClient instance] connect:REMOTE_HOST port:REMOTE_PORT];
    
    [self setupWholeAppearance];
    
    //self.window =[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds] ];
   // UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
   // HPRMainViewController *vc =[storyboard instantiateViewControllerWithIdentifier:@"mainface"];
   // self.window.rootViewController =vc;
   // self.window.backgroundColor =[UIColor whiteColor];
   // [self.window makeKeyAndVisible];
//
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark -设置外观

- (void)setupWholeAppearance{
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    
    NSDictionary *navBarTitletextAttr = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:navBarTitletextAttr];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor navigationbarColor]];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"HouseAlarm"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}




- (NSString *)stringWithData:(NSData *)d{
    NSString * str =[[NSString alloc]initWithData:d encoding:NSUTF8StringEncoding];
    return str;
}


-(void) test{
    /*
     *汉字一般来说：GBK\GB2312编码是2个字节，但是unicode\utf-8编码是3个字节。
     
     NSData NSMakeRange  是从 0 index 开始的
     */
    NSString *myString = @"你好吗bABCDEFG";
    size_t strLen =[myString length];
    const char *utfString = [myString UTF8String];
    
    strLen =strlen(utfString);
    
    
    NSData *data;
    data = [NSData dataWithBytes:utfString length:strLen];
    LogHA(@"%@",[self stringWithData:data]);

    
    NSInteger len = [data length];
    
    NSData *data2;
    data2 = [data subdataWithRange:NSMakeRange(0, len)];
    
    LogHA(@"%@",[self stringWithData:data2]);
    LogHA(@"%s",[data2 bytes]);
    
    data2 = [data subdataWithRange:NSMakeRange(0, 6)];
    LogHA(@"%@",[self stringWithData:data2]);
    LogHA(@"%s",[data2 bytes]);
    
    
    data2 = [data subdataWithRange:NSMakeRange(0, 3)];
    LogHA(@"%@",[self stringWithData:data2]);
    LogHA(@"%s",[data2 bytes]);
    
    data2 = [data subdataWithRange:NSMakeRange(3, 3)];
    LogHA(@"%@",[self stringWithData:data2]);
    LogHA(@"%s",[data2 bytes]);
    
    data2 = [data subdataWithRange:NSMakeRange(0, 7)];
    LogHA(@"%@",[self stringWithData:data2]);
    LogHA(@"%s",[data2 bytes]);
    data2 = [data subdataWithRange:NSMakeRange(1, 4)];
    
    LogHA(@"%@",[self stringWithData:data2]);
    LogHA(@"%s",[data2 bytes]);
    data2 = [data subdataWithRange:NSMakeRange(0, len)];
    LogHA(@"%@",[self stringWithData:data2]);
    LogHA(@"%s",[data2 bytes]);
    
}

@end
