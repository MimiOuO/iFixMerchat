//
//  ViewController.m
//  ifixMerchat
//
//  Created by Mimio on 2020/3/30.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import "TestViewController.h"
#import "MioLoginVC.h"
#import "MioApplyShopVC.h"
#import "ChartTestVCViewController.h"
@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navView.centerButton setTitle:@"首页" forState:UIControlStateNormal];
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *loginbtn = [UIButton creatBtn:frame(100, 100, 100, 200) inView:self.view bgColor:appMainColor title:@"login" action:^{
        MioApplyShopVC *vc = [[MioApplyShopVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    {if (![MioUserInfo shareUserInfo].isLogin) {\
        MioLoginVC *vc = [[MioLoginVC alloc] init];\
        MioBaseNavigationController *nav = [[MioBaseNavigationController alloc] initWithRootViewController:vc];\
        nav.modalPresentationStyle = 0;\
        [self presentViewController:nav animated:NO completion:nil];\
        return;\
    }}
}


@end
