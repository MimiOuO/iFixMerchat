//
//  MioSettingVC.m
//  ifixMerchat
//
//  Created by Mimio on 2020/4/13.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import "MioSettingVC.h"
#import "MioAboutUsVC.h"
//#import "MioModiPassWordVC.h"
#import "MioFeedBackVC.h"
#import "AppDelegate.h"
@interface MioSettingVC ()
@property (nonatomic, strong) UISwitch *state;
@end

@implementation MioSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navView.leftButton setImage:backArrowIcon forState:UIControlStateNormal];
    [self.navView.centerButton setTitle:@"设置" forState:UIControlStateNormal];
    
    [self creatUI];
    [self getState];
}

-(void)getState{
    [MioGetReq(api_me, @{@"k":@"v"}) success:^(NSDictionary *result){
        NSDictionary *data = [result objectForKey:@"data"];
        if ([[NSString stringWithFormat:@"%@",data[@"shop_status"]] isEqualToString:@"1"]) {
            _state.on = YES;
        }else{
            _state.on = NO;
        }
    } failure:^(NSString *errorInfo) {}];
}

-(void)creatUI{
    UIView *statusView = [UIView creatView:frame(18, NavHeight + 18, ksWidth - 36, 50) inView:self.view bgColor:appWhiteColor];
    statusView.layer.borderColor = appBottomLineColor.CGColor;
    statusView.layer.borderWidth = 0.5;
    ViewRadius(statusView, 4);
    UILabel *label = [UILabel creatLabel:frame(16, 0, 100, 50) inView:statusView text:@"营业状态" color:appSubColor size:16 alignment:NSTextAlignmentLeft];
    _state = [[UISwitch alloc] initWithFrame:CGRectMake(statusView.width - 58, 10, 30, 12)];
    _state.transform = CGAffineTransformMakeScale(0.75, 0.75);
    [statusView addSubview:_state];
    [_state addTarget:self action:@selector(onoffClick:) forControlEvents:(UIControlEventValueChanged)];
    
    UIView *otherView = [UIView creatView:frame(18, statusView.bottom + 18, ksWidth - 36, 300) inView:self.view bgColor:appWhiteColor];
    otherView.layer.borderColor = appBottomLineColor.CGColor;
    otherView.layer.borderWidth = 0.5;
    ViewRadius(otherView, 4);
    
    NSArray *otherLabArr = @[@"商户协议",@"修改密码",@"关于我们",@"清除缓存",@"意见反馈",@"客服电话"];
    for (int i = 0; i < 6; i++) {
        UIView *split = [UIView creatView:frame(0, 50 * i, ksWidth - 36, 0.5) inView:otherView bgColor:appBottomLineColor];
        UIImageView *arrow = [UIImageView creatImgView:frame(otherView.width - 18 - 7.5, 19 + 50 * i, 7.5, 12) inView:otherView image:@"rightArrow" radius:0];

        __block UIButton *btn = [UIButton creatBtn:frame(16, 50 * i, otherView.width - 32, 50) inView:otherView bgColor:appClearColor title:otherLabArr[i] action:^{
            [self btnClick:btn];
        }];
        [btn setTitleColor:appSubColor forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    
    UIButton *loginoutBtn = [UIButton creatBtn:frame(ksWidth/2 - 60, ksHeight - SafeBottomH - 70, 120, 40) inView:self.view bgColor:appWhiteColor title:@"退出登录" action:^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定退出？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"我再想想" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [userdefault setObject:nil forKey:@"token"];
//            [userdefault setObject:nil forKey:@"user_id"];
//            [userdefault setObject:nil forKey:@"nickname"];
//            [userdefault setObject:nil forKey:@"avatar"];
            [userdefault synchronize];
            
            EMError *error = [[EMClient sharedClient] logout:YES];
            if (!error) {
                NSLog(@"退出成功");
            }
            
//            AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//            MioMainViewController *tab = (MioMainViewController *)delegate.window.rootViewController;
//            tab.selectedIndex = 0;
            
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        alertController.modalPresentationStyle = 0;
        [self presentViewController:alertController animated:YES completion:nil];
    }];
    [loginoutBtn setTitleColor:appMainColor forState:UIControlStateNormal];
    loginoutBtn.titleLabel.font = Font(14);
    loginoutBtn.layer.borderColor = appMainColor.CGColor;
    loginoutBtn.layer.borderWidth = 1 ;
    ViewRadius(loginoutBtn, 4);
}

-(void)btnClick:(UIButton *)btn{
    NSLog(@"%@",btn.titleLabel.text);
    if ([btn.titleLabel.text isEqualToString:@"商户协议"]) {
        
    }
    if ([btn.titleLabel.text isEqualToString:@"修改密码"]) {
        
    }
    if ([btn.titleLabel.text isEqualToString:@"关于我们"]) {
        MioAboutUsVC *vc = [[MioAboutUsVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([btn.titleLabel.text isEqualToString:@"清除缓存"]) {
        [self clearFile];
    }
    if ([btn.titleLabel.text isEqualToString:@"意见反馈"]) {
        MioFeedBackVC *vc = [[MioFeedBackVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([btn.titleLabel.text isEqualToString:@"客服电话"]) {
        NSString *str = [[NSMutableString alloc] initWithFormat:@"tel://%@",@"028-86112645"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}


// 清理缓存

- (void)clearFile
{
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    
    NSArray * files = [[ NSFileManager defaultManager ] subpathsAtPath :cachPath];

    NSLog ( @"cachpath = %@" , cachPath);

    for ( NSString * p in files) {

        NSError * error = nil ;

        NSString * path = [cachPath stringByAppendingPathComponent :p];

        if ([[ NSFileManager defaultManager ] fileExistsAtPath :path]) {

            [[ NSFileManager defaultManager ] removeItemAtPath :path error :&error];

        }

    }

    [SVProgressHUD showSuccessWithStatus:@"清除缓存成功"];

}

-(void)onoffClick:(UISwitch *)onOff{
    if (!onOff.on) {
        [MioPutReq(api_close, @{@"k":@"v"}) success:^(NSDictionary *result){
            NSDictionary *data = [result objectForKey:@"data"];
            [SVProgressHUD showSuccessWithStatus:@"关店成功"];
        } failure:^(NSString *errorInfo) {
            NSLog(@"%@",errorInfo);
        }];
    }else{
        [MioPutReq(api_open, @{@"k":@"v"}) success:^(NSDictionary *result){
            NSDictionary *data = [result objectForKey:@"data"];
            [SVProgressHUD showSuccessWithStatus:@"开店成功"];
        } failure:^(NSString *errorInfo) {}];
    }
}

@end
