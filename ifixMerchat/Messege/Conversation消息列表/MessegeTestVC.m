//
//  MessegeTestVC.m
//  DuoDuoPeiwan
//
//  Created by Mimio on 2020/1/15.
//  Copyright © 2020 Brance. All rights reserved.
//

#import "MessegeTestVC.h"

@interface MessegeTestVC ()

@end

@implementation MessegeTestVC

-(MioNavView *)navView{
    if (!_navView) {
        MioNavView *navView = [[MioNavView alloc] init];
        [self.view addSubview:navView];
        self.navView = navView;
        self.navView.frame = CGRectMake(0, 0, ksWidth, NavHeight);
        [self.navView.superview layoutIfNeeded];
    }
    return _navView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    //设置背景颜色
    self.view.backgroundColor = appbgColor;
    //隐藏自带的导航栏
    self.navigationController.navigationBar.hidden = YES;
    
    [self.navView.leftButton setImage:backArrowIcon forState:UIControlStateNormal];
    [self.navView.centerButton setTitle:@"测试" forState:UIControlStateNormal];
}



@end
