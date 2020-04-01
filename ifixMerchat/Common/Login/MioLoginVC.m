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

    UIImageView *logoImage = [UIImageView creatImgView:frame(23, NavHeight - StatusHeight + 35, 49, 49) inView:scroll image:@"ios-template-1024" radius:12];
    UILabel *titleLabel = [UILabel creatLabel:frame(23, logoImage.bottom + 14, 200, 25) inView:scroll text:@"欢迎来到多多陪玩" color:appSubColor size:18];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];

    //======================================================================//
    //                               用户名
    //======================================================================//

    
    self.userNameField = [[UITextField alloc] initWithFrame:CGRectMake(23, titleLabel.bottom + 54 ,  ksWidth - 46, 17)];
    self.userNameField.delegate = self;
    self.userNameField.font = [UIFont systemFontOfSize:16];
    self.userNameField.placeholder = @"请输入手机号登录";
    self.userNameField.textColor = appSubColor;
    
    [self.userNameField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.userNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.userNameField.keyboardType = UIKeyboardTypeNumberPad;
    [scroll addSubview:self.userNameField];
    
    UIView *split1 = [UIView creatView:frame(23, self.userNameField.bottom + margin, ksWidth - 46, 0.5) inView:scroll bgColor:appBottomLineColor];
    
    _agreeBtn = [MioLargeButton creatBtn:frame(23, split1.bottom + margin, 16, 16) inView:scroll bgImage:@"" WithTag:1 target:self action:@selector(agreeBtnClick:)];
    [_agreeBtn setImage:[UIImage imageNamed:@"mine_Great_Selected"] forState:UIControlStateSelected];
    [_agreeBtn setImage:[UIImage imageNamed:@"mine_Great_Normal"] forState:UIControlStateNormal];

    
    UILabel *tip = [UILabel creatLabel:frame(_agreeBtn.right + margin, _agreeBtn.top, 63, 17) inView:scroll text:@"阅读并同意" color:appGrayTextColor size:12];
    UIButton *agreeMentBtn = [UIButton creatBtn:frame(tip.right, _agreeBtn.top, 150, 17) inView:scroll bgColor:appClearColor title:@"《用户协议与隐私政策》" WithTag:1 target:self action:@selector(xieyi)];
       agreeMentBtn.titleLabel.font = [UIFont systemFontOfSize:12];
       [agreeMentBtn setTitleColor:appMainColor forState:UIControlStateNormal];
    
    
    UIButton *btn = [UIButton creatBtn:frame(23, _agreeBtn.bottom + 18, ksWidth - 46, 40) inView:scroll bgImage:@"denglu-anniu" WithTag:1 target:self action:@selector(handleLoginEvent:)];
    UILabel *btnlabel = [UILabel creatLabel:frame(23, _agreeBtn.bottom + 18, ksWidth - 46, 40) inView:scroll text:@"获取验证码" color:appWhiteColor size:16];
    btnlabel.textAlignment = NSTextAlignmentCenter;

    UIButton *passwordLogin = [UIButton creatBtn:frame(23,btn.bottom + margin, 60, 14) inView:scroll bgColor:appWhiteColor title:@"密码登录" WithTag:2 target:self action:@selector(passwordLogin)];
    passwordLogin.titleLabel.font = [UIFont systemFontOfSize:14];
    [passwordLogin setTitleColor:appGrayTextColor forState:UIControlStateNormal];

    

}

- (void)handleLoginEvent:(id)sender {

    NSString *telNumber = [self.userNameField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (telNumber.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号！"];
        return;
    }
    
    if (!_agreeBtn.selected) {
        [SVProgressHUD showInfoWithStatus:@"请先同意用户协议！"];
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
