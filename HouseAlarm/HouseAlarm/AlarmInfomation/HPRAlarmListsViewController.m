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

@property (nonatomic,weak) TitleBarView *titleBar;
@property (nonatomic,weak) UIScrollView *scrollView;
@end

@implementation HPRAlarmListsViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        AlarmTableViewController *fireTVC =[[AlarmTableViewController alloc] init];
        AlarmTableViewController *faultTVC =[[AlarmTableViewController alloc] init];
        AlarmTableViewController *shieldTVC =[[AlarmTableViewController alloc] init];
        AlarmTableViewController *otherTVC =[[AlarmTableViewController alloc] init];
        _titles = @[@"1",@"2",@"3",@"4"];
        _vcs =@[fireTVC,faultTVC,shieldTVC,otherTVC];
        
        for (AlarmTableViewController * c in _vcs){
            [self addChildViewController:c];
        }
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSelf];
    [self addContentView];
    // Do any additional setup after loading the view.
}


- (void)setSelf{
    self.navigationItem.title = @"报警列表";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)addContentView{
    TitleBarView *titleBar =[[TitleBarView alloc] initWithFrame:CGRectMake(0, 64,kScreenSize.width, 36) andTitles:_titles];
    titleBar.backgroundColor = [UIColor titleColor];
    titleBar.titleBtnClicked = ^(NSUInteger index){
        [_scrollView setContentOffset:CGPointMake(kScreenSize.width * index, 0) animated:YES];
    };
    
    _titleBar = titleBar;
    [self.view addSubview:_titleBar];
    
     UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleBar.frame), kScreenSize.width, kScreenSize.height - CGRectGetMaxY(_titleBar.frame) - 49)];
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
