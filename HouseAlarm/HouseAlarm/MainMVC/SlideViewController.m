//
//  SlideViewController.m
//  HouseAlarm
//
//  Created by macos on 2018/1/26.
//  Copyright © 2018年 jbu. All rights reserved.
//

#import "SlideViewController.h"
#import "HPRLeftMenuHeader.h"
#import "HPRLeftMenuCell.h"

#import "HPRAlarmListsViewController.h"
#import "UIViewController+CWLateralSlide.h"

#define HPR_SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define HPR_HEADER_HEIGHT [UIScreen mainScreen].bounds.size.width * 39 / 125
#define leftMenucellIdentifier @"LeftMenucellIdentifier"
@interface SlideViewController ()<UITableViewDelegate,UITableViewDataSource>
@property HPRLeftMenuHeader *menuHeader;
@property UITableView *tableView;
@end

@implementation SlideViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    //NSArray *ar =[[NSBundle mainBundle] loadNibNamed:@"SlideView" owner:self options:nil];
    //UITableView* tb =[ar lastObject];
   //UITableView *tb = [UINib nibWithNibName:@"SlideViewController" bundle:nil];
    //self.tableView = tb;
// Do any additionalsetup after loading the view from its nib.
}
- (void)setupTableView{
    UITableView * tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,HPR_SCREEN_WIDTH *0.75, CGRectGetHeight(self.view.bounds)) style:UITableViewStylePlain];
    self.tableView = tv;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"HPRLeftMenuCell" bundle:nil] forCellReuseIdentifier:leftMenucellIdentifier];
    [self.view addSubview:self.tableView];
    [self layoutUI];
}

- (void)layoutUI{
    self.menuHeader = [[HPRLeftMenuHeader alloc] initWithFrame:CGRectMake(0,0,HPR_SCREEN_WIDTH
                                                                         ,HPR_HEADER_HEIGHT)];
    self.tableView.tableHeaderView = self.menuHeader;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HPRLeftMenuCell *cell = [HPRLeftMenuCell createCellFromTableView:tableView indexPath:indexPath identifier:leftMenucellIdentifier];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row ==0){
        [self showAlterView:@"hello" message:@"test"];
    }else{
        HPRAlarmListsViewController *vc = [[HPRAlarmListsViewController alloc] init];
        [self cw_pushViewController:vc];

    }
}

- (void)showAlterView:(NSString *)title message:(NSString*) message{
    UIAlertController *alertc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:
                                 UIAlertControllerStyleAlert];
    UIAlertAction *action1 =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    UIAlertAction *action2 =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"确定");
    }];
    [alertc addAction:action1];
    [alertc addAction:action2];
    [self presentViewController:alertc  animated:YES completion:nil];
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
