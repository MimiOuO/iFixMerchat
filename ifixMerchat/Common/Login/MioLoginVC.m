//
//  ZMLoginViewController.m
//  ZMBCY
//
//  Created by ZOMAKE on 2018/1/5.
//  Copyright © 2018年 Brance. All rights reserved.
//

#import "MioLoginVC.h"
#import "MioVerifyCodeVC.h"
#import "MioPasswordLoginVC.h"
#import "MioUserAgreementVC.h"
#import "UITextField+NumberFormat.h"
#import "MioBoundPhoneVC.h"
#import "MioLargeButton.h"
#import <SVGA.h>
@interface MioLoginVC ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *userNameField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) MioLargeButton *agreeBtn;
@property (nonatomic, strong) MioLargeButton *aaa;
@property (nonatomic, strong) MioLargeButton *friendshipBtn1;
@end

@implementation MioLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = appWhiteColor;

    [self.navView.centerButton setTitle:@"" forState:UIControlStateNormal];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wxLoginSuccess:) name:@"wxLoginSuccess" object:nil];
    [self creatUI];
}

-(void)creatUI{
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, StatusHeight, ksWidth, ksHeight - StatusHeight)];
    [self.view addSubview:scroll];
    
    
    UIButton *close = [[UIButton alloc] initWithFrame:CGRectMake(23, 15, 15, 15)];
    [close setBackgroundImage:[UIImage imageNamed:@"login_alert_cancel"] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(handlecloseEvent:) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:close];

    UILabel *titleLabel = [UILabel creatLabel:frame(19, IPHONE_X?104:74, 200, 30) inView:scroll text:@"欢迎来到iFIX" color:appSubColor size:30];
    titleLabel.font = [UIFont boldSystemFontOfSize:30];

    //======================================================================//
    //                               用户名
    //======================================================================//
    UILabel *accoutLab = [UILabel creatLabel:frame(19, titleLabel.bottom + 60, 35, 16) inView:scroll text:@"账号" color:appSubColor size:16 alignment:NSTextAlignmentLeft];

    
    self.userNameField = [[UITextField alloc] initWithFrame:CGRectMake(80, titleLabel.bottom + 60 ,  ksWidth - 46, 16)];
    self.userNameField.delegate = self;
    self.userNameField.font = [UIFont systemFontOfSize:16];
    self.userNameField.placeholder = @"请输入手机号";
    self.userNameField.textColor = appSubColor;
    
    [self.userNameField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.userNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.userNameField.keyboardType = UIKeyboardTypeNumberPad;
    [scroll addSubview:self.userNameField];
    
    UIView *split1 = [UIView creatView:frame(19, self.userNameField.bottom + 21, ksWidth - 38, 0.5) inView:scroll bgColor:appBottomLineColor];
    
    SVGAPlayer *logoPlayer = [[SVGAPlayer alloc] initWithFrame:CGRectMake(0, ksHeight -  ksWidth*0.972 - StatusHeight, ksWidth, ksWidth*0.972)];
    [scroll addSubview:logoPlayer];
    SVGAParser *parser = [[SVGAParser alloc] init];
    [parser parseWithNamed:@"login" inBundle:nil completionBlock:^(SVGAVideoEntity * _Nonnull videoItem) {
            if (videoItem != nil) {
                NSLog(@"请求完毕");
                logoPlayer.videoItem = videoItem;
                [logoPlayer startAnimation];
                

            
        }
    } failureBlock:^(NSError * _Nonnull error) {
         NSLog(@"%@",error);
     }];

    
    UILabel *tip = [UILabel creatLabel:frame(ksWidth/2 - 120, ksHeight - StatusHeight - SafeBottomH - 34, 100, 17) inView:scroll text:@"登录即代表您同意" color:appSubColor size:12];
    UIButton *agreeMentBtn = [UIButton creatBtn:frame(tip.right, tip.top, 140, 17) inView:scroll bgColor:appClearColor title:@"《用户协议与隐私政策》" WithTag:1 target:self action:@selector(xieyi)];
       agreeMentBtn.titleLabel.font = [UIFont systemFontOfSize:12];
       [agreeMentBtn setTitleColor:rgb(113, 140, 255) forState:UIControlStateNormal];
    
    
    UIButton *btn = [UIButton creatBtn:frame(19, split1.bottom + 40, ksWidth - 38, 44) inView:scroll bgImage:@"button" WithTag:1 target:self action:@selector(handleLoginEvent:)];
    UILabel *btnlabel = [UILabel creatLabel:frame(19, split1.bottom + 40, ksWidth - 38, 44) inView:scroll text:@"获取验证码" color:appWhiteColor size:16];
    btnlabel.textAlignment = NSTextAlignmentCenter;

    UIButton *passwordLogin = [UIButton creatBtn:frame(ksWidth/2 - 50 ,btn.bottom + 10, 100, 34) inView:scroll bgColor:appWhiteColor title:@"密码登陆" WithTag:2 target:self action:@selector(passwordLogin)];
    passwordLogin.titleLabel.font = [UIFont systemFontOfSize:14];
    [passwordLogin setTitleColor:appSubColor forState:UIControlStateNormal];




}

- (void)handleLoginEvent:(id)sender {

    NSString *telNumber = [self.userNameField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (telNumber.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号！"];
        return;
    }
    
    [SVProgressHUD show];
    NSDictionary *dic = @{
                          @"phone":telNumber,
                          };
    MioPostRequest *request = [[MioPostRequest alloc] initWithRequestUrl:api_getVerifyCode argument:dic];
    
    [request success:^(NSDictionary *result) {
        NSDictionary *data = [result objectForKey:@"data"];
        
        [SVProgressHUD dismiss];
        MioVerifyCodeVC *vc = [[MioVerifyCodeVC alloc] init];
        vc.phoneNumber = self.userNameField.text;
        vc.verification_key = [data objectForKey:@"key"];
        [self.navigationController pushViewController:vc animated:YES];
        
    } failure:^(NSString *errorInfo) {
        [SVProgressHUD showErrorWithStatus:errorInfo ];
        
    }];
}

-(void)passwordLogin{
    
    
    MioPasswordLoginVC *vc = [[MioPasswordLoginVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)handlecloseEvent:(id)sender {
	[self dismissViewControllerAnimated:YES completion:^{
		
	}];
}

//-(void)textFieldDidChange:(UITextField *)textField
//{
//    if ( (unsigned long)textField.text.length > 11) {
//        self.userNameField.text = [self.userNameField.text substringToIndex:11];
//    }
//}

-(void)xieyi{
    MioUserAgreementVC *vc = [[MioUserAgreementVC alloc] init];
    vc.url = @"https://duoduo.apphw.com/policy.html";
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)agreeBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
}

#pragma mark - UITextFieldDelegate
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
//    return YES;
//}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    return [UITextField inputTextField:textField
         shouldChangeCharactersInRange:range
                     replacementString:string
                        blankLocations:@[@3,@8]
                            limitCount:11];

}





@end
