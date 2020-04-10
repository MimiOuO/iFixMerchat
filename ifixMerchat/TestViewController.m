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
#import "MioApplyWaitVC.h"
#import "MioApplyErrorVC.h"
#import "MioCommentVC.h"
@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navView.centerButton setTitle:@"首页" forState:UIControlStateNormal];
    
    self.view.backgroundColor = [UIColor whiteColor];
    

    
//    {if (![MioUserInfo shareUserInfo].isLogin) {\
//        MioLoginVC *vc = [[MioLoginVC alloc] init];\
//        MioBaseNavigationController *nav = [[MioBaseNavigationController alloc] initWithRootViewController:vc];\
//        nav.modalPresentationStyle = 0;\
//        [self presentViewController:nav animated:NO completion:nil];\
//        return;\
//    }}
    
    
//    NSString *state = [NSString stringWithFormat:@"%@",[userdefault objectForKey:@"shop_status"]] ;
//
//    if ([state isEqualToString:@"3"]) {//
//        MioBaseNavigationController *nav = [[MioBaseNavigationController alloc] initWithRootViewController:[MioApplyErrorVC new]];
//        nav.modalPresentationStyle = 0;
//        [self presentViewController:nav animated:NO completion:nil];
//    }
//    if ([state isEqualToString:@"4"]) {//
//        MioBaseNavigationController *nav = [[MioBaseNavigationController alloc] initWithRootViewController:[MioApplyWaitVC new]];
//        nav.modalPresentationStyle = 0;
//        [self presentViewController:nav animated:NO completion:nil];
//    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestShop];
}

-(void)requestShop{
    goLogin
    [MioGetReq(api_me, @{@"k":@"v"}) success:^(NSDictionary *result){
        NSDictionary *data = [result objectForKey:@"data"];
        NSString *state = [NSString stringWithFormat:@"%@",[data  objectForKey:@"shop_status"]];
        if ([state isEqualToString:@"1"]) {
            MioBaseNavigationController *nav = [[MioBaseNavigationController alloc] initWithRootViewController:[MioApplyShopVC new]];
            nav.modalPresentationStyle = 0;
            [self presentViewController:nav animated:NO completion:nil];
        }
        
        else if ([state isEqualToString:@"3"]) {
            MioBaseNavigationController *nav = [[MioBaseNavigationController alloc] initWithRootViewController:[MioApplyErrorVC new]];
            nav.modalPresentationStyle = 0;
            [self presentViewController:nav animated:NO completion:nil];
        }
        else if ([state isEqualToString:@"4"]) {
            MioBaseNavigationController *nav = [[MioBaseNavigationController alloc] initWithRootViewController:[MioApplyWaitVC new]];
            nav.modalPresentationStyle = 0;
            [self presentViewController:nav animated:NO completion:nil];
        }
        else{
            [self creatUI];
        }
    } failure:^(NSString *errorInfo) {}];
}

-(void)creatUI{
    UIButton *loginbtn = [UIButton creatBtn:frame(100, 100, 100, 50) inView:self.view bgColor:appMainColor title:@"审核结果" action:^{
        MioApplyWaitVC *vc = [[MioApplyWaitVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    UIButton *login2btn = [UIButton creatBtn:frame(100, 200, 100, 50) inView:self.view bgColor:appMainColor title:@"评论" action:^{
        ChartTestVCViewController *vc = [[ChartTestVCViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    UIButton *login3btn = [UIButton creatBtn:frame(100, 300, 100, 50) inView:self.view bgColor:appMainColor title:@"登录" action:^{
        MioLoginVC *vc = [[MioLoginVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

@end
