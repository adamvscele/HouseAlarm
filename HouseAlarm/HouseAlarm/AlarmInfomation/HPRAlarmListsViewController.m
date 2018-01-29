//
//  HPRAlarmListsViewController.m
//  HouseAlarm
//
//  Created by macos on 2018/1/27.
//  Copyright © 2018年 jbu. All rights reserved.
//

#import "HPRAlarmListsViewController.h"
#include "TitleBarView.h"
#import "HPRUtils.h"
#import "AlarmTableViewController.h"
#import <YYKit.h>

@interface HPRAlarmListsViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) NSArray *vcs;

@property (nonatomic,strong) TitleBarView *titleBar;
@property (nonatomic,weak) UIScrollView *scrollView;
@end

@implementation HPRAlarmListsViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
        //initWithTitle:@"报警队列"
        _titles = @[@"火警",@"故障",@"屏蔽",@"其他"];
        _vcs =@[
                [[AlarmTableViewController alloc] init],
                [[AlarmTableViewController alloc] init],
                [[AlarmTableViewController alloc] init],
                [[AlarmTableViewController alloc] init]];
        
        
        
       
        
        //作用
        //for (AlarmTableViewController *vc in self.vcs) {
        //[self addChildViewController:vc];
        //}
        
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setSelf];
    [self addContentView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tabBarController.tabBar.translucent = YES;
}

- (void)setSelf{
    self.title = @"报警队列";
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)addContentView{
    CGFloat titleBarHeight = 36;
    TitleBarView *barView = [[TitleBarView alloc]
                 initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, titleBarHeight) andTitles:_titles];
    barView.backgroundColor = [UIColor titleBarColor];
    barView.titleBtnClicked = ^(NSUInteger index){
        [_scrollView setContentOffset:CGPointMake(kScreenSize.width * index, 0) animated:YES];
    };
    self.titleBar = barView;
    [self.view addSubview:self.titleBar];
    
    UIScrollView *scrollView = [[UIScrollView alloc]
                                initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleBar.frame)
                                                         , kScreenSize.width, kScreenSize.height - CGRectGetMaxY(_titleBar.frame) - 64)];
    scrollView.contentSize = CGSizeMake(kScreenSize.width * _vcs.count, 0);
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView = scrollView;
    [self.view addSubview:_scrollView];
    
    for (UIViewController * c in _vcs) {
        NSInteger index = [_vcs indexOfObject:c];
        c.view.frame = CGRectMake(kScreenSize.width * index, 0, kScreenSize.width, CGRectGetHeight(_scrollView.frame));
        [_scrollView addSubview:c.view];
    }
    
}



//- (instancetype)init{
//    self = [super init];
//    if (self) {
//        AlarmTableViewController *fireTVC =[[AlarmTableViewController alloc] init];
//        AlarmTableViewController *faultTVC =[[AlarmTableViewController alloc] init];
//        AlarmTableViewController *shieldTVC =[[AlarmTableViewController alloc] init];
//        AlarmTableViewController *otherTVC =[[AlarmTableViewController alloc] init];
//        _titles = @[@"1",@"2",@"3",@"4"];
//        _vcs =@[fireTVC,faultTVC,shieldTVC,otherTVC];
//
//        for (AlarmTableViewController * c in _vcs){
//            [self addChildViewController:c];
//        }
//
//    }
//    return self;
//}


#pragma mark ---UISCrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x /kScreenSize.width;
    [self.titleBar scrollToCenterWithIndex:index];
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
