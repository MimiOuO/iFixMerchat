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
@interface MioSettingVC ()

@end

@implementation MioSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navView.leftButton setImage:backArrowIcon forState:UIControlStateNormal];
    [self.navView.centerButton setTitle:@"设置" forState:UIControlStateNormal];
    
    [self creatUI];
}

-(void)creatUI{
    UIView *statusView = [UIView creatView:frame(18, NavHeight + 18, ksWidth - 36, 50) inView:self.view bgColor:appWhiteColor];
    statusView.layer.borderColor = appBottomLineColor.CGColor;
    statusView.layer.borderWidth = 0.5;
    ViewRadius(statusView, 4);
    UILabel *label = [UILabel creatLabel:frame(16, 0, 100, 50) inView:statusView text:@"营业状态" color:appSubColor size:16 alignment:NSTextAlignmentLeft];
    UISwitch *state = [[UISwitch alloc] initWithFrame:CGRectMake(statusView.width - 58, 10, 30, 12)];
    state.transform = CGAffineTransformMakeScale(0.75, 0.75);
    [statusView addSubview:state];
    
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

@end
