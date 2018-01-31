//
//  HPRLoginViewController.m
//  HouseAlarm
//
//  Created by macos on 2018/1/31.
//  Copyright © 2018年 jbu. All rights reserved.
//

#import "HPRLoginViewController.h"

@interface HPRLoginViewController ()

@end

@implementation HPRLoginViewController

- (void)viewDidLoad {
    LogHA(@"viewDidLoad");
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated{
     LogHA(@"viewWillAppear");
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated{
     LogHA(@"viewDidAppear");
    [super viewDidAppear:animated];
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
