//
//  ViewController.m
//  ifixMerchat
//
//  Created by Mimio on 2020/3/30.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import "ViewController.h"
#import "MioLoginVC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navView.centerButton setTitle:@"首页" forState:UIControlStateNormal];
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *loginbtn = [UIButton creatBtn:frame(100, 100, 100, 20) inView:self.view bgColor:appMainColor title:@"login" action:^{
        MioLoginVC *vc = [[MioLoginVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}


@end
