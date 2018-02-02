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
#import "HPRAlarmListsViewController.h"
#import "PushNotificationManager.h"
#import <TSMessage.h>
#import "AlarmTableViewController.h"
#import "HPRMainHeaderView.h"
#import "UIColor+Utils.h"
#import "HPRMonitorNetTableViewCell.h"

#import "JMDropMenu.h"
#import "HPRLoginViewController.h"
#import <MJRefresh.h>

#define HPR_SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define HPR_HEADER_HEIGHT [UIScreen mainScreen].bounds.size.width * 39 / 125

static NSString * const monitorNetReuseIdentifier = @"monitorNetTableViewCell";

@interface HPRMainViewController ()<UNUserNotificationCenterDelegate,JMDropMenuDelegate>

/** titleArr */
@property (nonatomic, strong) NSArray *titleArr;
/** imgArr */
@property (nonatomic, strong) NSArray *imageArr;


@property (nonatomic,weak) HPRMainHeaderView * headerView;


@property (nonatomic,strong) NSMutableArray* monitorNetDatas;

- (void) cbRecvMsg:(NSNotification*) notification;


@end



@implementation HPRMainViewController

- (void)regNotificationCenter{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                  selector:@selector(cbRecvMsg:)
                                  name:HPRNotificationRecvdMessage
                             object:nil];
}

- (void)insideNotification:(NSString*) nitification{
    
    [[PushNotificationManager sharedInstance]normalPushNotificationWithTitle:@"John Winston Lennon" subTitle:@"《Imagine》"
                                                                        body: nitification identifier:@"1-1" timeInterval:1 repeat:NO];   //`repeat` if you pick the repeat property 'YES',you require to set the timeInterval value >= 60second ->是否重复,若要重复->时间间隔应>=60s
}

- (void)didSelectRowAtIndex:(NSInteger)index Title:(NSString *)title Image:(NSString *)image {
    NSLog(@"index----%zd,  title---%@, image---%@", index, title, image);
}


#pragma mark - 右边
- (IBAction)navRightClick:(id)sender {
    
    JMDropMenu *menu =[JMDropMenu showDropMenuFrame:CGRectMake(self.view.frame.size.width - 128, 64, 120, 52*_titleArr.count) ArrowOffset:102.f TitleArr:self.titleArr ImageArr:self.imageArr Type:JMDropMenuTypeQQ LayoutType:JMDropMenuLayoutTypeNormal RowHeight:40.f Delegate:self];
    
   
}

- (void) cbRecvMsg:(NSNotification*) notification{
    LogHA(@"Main UI  cbRecvMsg");
     NSString* body = (NSString*)notification.object;
     [self insideNotification:body];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
     LogHA(@"viewDidAppear");
}
 - (void)viewWillAppear:(BOOL)animated
{
     LogHA(@"viewWillAppear");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HPRMonitorNetTableViewCell" bundle:nil]
        forCellReuseIdentifier:monitorNetReuseIdentifier];
    [self layoutUI];
     LogHA(@"viewDidLoad");
    // Do any additional setup after loading the view.
    [self regNotificationCenter];
       //self.slideLeftVC = [[SlideViewController alloc] initWithNibName:@"SlideViewController" bundle:nil];
    [[UNUserNotificationCenter currentNotificationCenter] setDelegate:self];
    
    self.titleArr = @[@"添加设备"];
    self.imageArr = @[@"img3"];

    [self setTitle:@"监控"];
    
}

- (void)layoutUI{
    self.view.backgroundColor = [UIColor colorWithHex:0xfcfcfc];
   
    self.tableView.estimatedRowHeight = 132;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    HPRMainHeaderView *tbheader
     = [[HPRMainHeaderView alloc] initWithFrame:CGRectMake(0,0, HPR_SCREEN_WIDTH, HPR_HEADER_HEIGHT)];
    self.headerView = tbheader;
    
    self.tableView.tableHeaderView = tbheader;//self.headerView;
    MJRefreshNormalHeader *header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.tableView.mj_header endRefreshing];
         }];
     [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开即可刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新数据中..." forState:MJRefreshStateRefreshing];

   
        self.tableView.mj_header =header;
        
  
    [self.tableView.mj_header beginRefreshing];
}



-(IBAction)onClickLeftSlide:(id)sender{
    
    SlideViewController *slideLeftVC = [[SlideViewController alloc] init];

    [self cw_showDefaultDrawerViewController: slideLeftVC];

    //[self presentViewController:vc animated:YES completion:nil];
}

-(IBAction)onClickRightFunc:(id)sender{
    
     [[PushNotificationManager sharedInstance] normalPushNotificationWithTitle:@"John Winston Lennon" subTitle:@"《Imagine》" body:@"You may say that I'm a dreamer, but I'm not the only one" identifier:@"1-1" timeInterval:3 repeat:NO];   //`repeat` if you pick the repeat property 'YES',you require to set the timeInterval value >= 60second ->是否重复,若要重复->时间间隔应>=60s
    
}


-(NSMutableArray *)monitorNetDatas{
    if (_monitorNetDatas == nil) {
        _monitorNetDatas = [NSMutableArray array];
    }
    return _monitorNetDatas;
}

#pragma mark - tableview delegate &datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HPRMonitorNetTableViewCell *cell = [HPRMonitorNetTableViewCell createReuseCellFromTableView:tableView indexPath:indexPath identifier:monitorNetReuseIdentifier];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //HPRAlarmListsViewController *vc = [[HPRAlarmListsViewController alloc] init];
   // [self.navigationController pushViewController:vc animated:YES];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    HPRLoginViewController *loginVC = [storyboard instantiateInitialViewController];
    [self presentViewController:loginVC animated:YES completion:nil];

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
