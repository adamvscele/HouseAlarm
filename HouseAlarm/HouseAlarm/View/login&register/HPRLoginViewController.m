//
//  HPRLoginViewController.m
//  HouseAlarm
//
//  Created by macos on 2018/1/31.
//  Copyright © 2018年 jbu. All rights reserved.
//

#import "HPRLoginViewController.h"
#import "HPRRegisterViewController.h"

@interface HPRLoginViewController ()
@property UINavigationController * registerVc;

- (IBAction)btnClickRegister:(id)sender;

@end

@implementation HPRLoginViewController

- (void)viewDidLoad {
    LogHA(@"viewDidLoad");
    [super viewDidLoad];
    [self addRelateVCs];
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


-(IBAction)btnClickRegister:(id)sender{
    [self presentViewController:_registerVc animated:YES completion:nil];
    
}

- (void)addRelateVCs{
    //HPRRegisterViewController *reg =[HPRRegisterViewController new];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    UIViewController *regVc = [story instantiateViewControllerWithIdentifier:@"reg"];
    
    _registerVc=[self addVCwithNav:regVc];
}

- (void)dismissCurVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (UINavigationController*) addVCwithNav:(UIViewController *)vc{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    UIImage *img = [UIImage imageNamed:@"back_pre"];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame =CGRectMake(0, 0, 10, 20);
    [backBtn setBackgroundImage:img forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(dismissCurVC) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item =[[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    vc.navigationItem.leftBarButtonItem = item;
    //vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
    //     initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward
    //       target:self
    //       action:@selector(popVc)];
    //vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain
    //                                                                      target:self action:@selector(dismissCurVC)];
    return nav;

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
