
//
//  MioPasswordLoginVC.m
//  orrilan
//
//  Created by Mimio on 2019/8/19.
//  Copyright © 2019 Brance. All rights reserved.
//

#import "MioPasswordLoginVC.h"

#import "MioUserAgreementVC.h"
#import "UITextField+NumberFormat.h"
@interface MioPasswordLoginVC ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *userNameField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) UIButton *agreeBtn;
@end

@implementation MioPasswordLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navView.leftButton setImage:backArrowIcon forState:UIControlStateNormal];
    self.view.backgroundColor =appWhiteColor;
    [self creatUI];
    
}

-(void)creatUI{
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NavHeight, ksWidth, ksHeight - NavHeight)];
    [self.view addSubview:scroll];
    

    
    UIImageView *logoImage = [UIImageView creatImgView:frame(23,  35, 49, 49) inView:scroll image:@"ios-template-1024" radius:12];
    UILabel *titleLabel = [UILabel creatLabel:frame(23, logoImage.bottom + 14, 200, 25) inView:scroll text:@"欢迎来到多多陪玩" color:appSubColor size:18];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    
    //======================================================================//
    //                               用户名
    //======================================================================//
    
    
    self.userNameField = [[UITextField alloc] initWithFrame:CGRectMake(23, titleLabel.bottom + 54 ,  ksWidth - 46, 17)];
    self.userNameField.delegate = self;
    self.userNameField.font = [UIFont systemFontOfSize:16];
    self.userNameField.placeholder = @"请输入手机号";
    self.userNameField.textColor = appSubColor;
    
    [self.userNameField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.userNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.userNameField.keyboardType = UIKeyboardTypeNumberPad;
    [scroll addSubview:self.userNameField];
    
    UIView *split1 = [UIView creatView:frame(23, self.userNameField.bottom + margin, ksWidth - 46, 0.5) inView:scroll bgColor:appBottomLineColor];
    
    //======================================================================//
    //                               密码
    //======================================================================//
    self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake(23, split1.bottom + 18 ,  ksWidth - 46, 17)];
    self.passwordField.font = [UIFont systemFontOfSize:16];
    self.passwordField.placeholder = @"请输入登录密码";
    self.passwordField.textColor = appSubColor;
    self.passwordField.secureTextEntry = YES;
    self.passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [scroll addSubview:self.passwordField];
    
    UIView *split2 = [UIView creatView:frame(23, self.passwordField.bottom + margin, ksWidth - 46, 0.5) inView:scroll bgColor:appBottomLineColor];
    
    _agreeBtn = [UIButton creatBtn:frame(23, split2.bottom + margin, 16, 16) inView:scroll bgImage:@"" WithTag:1 target:self action:@selector(agreeBtnClick:)];
       [_agreeBtn setImage:[UIImage imageNamed:@"mine_Great_Selected"] forState:UIControlStateSelected];
       [_agreeBtn setImage:[UIImage imageNamed:@"mine_Great_Normal"] forState:UIControlStateNormal];
    UILabel *tip = [UILabel creatLabel:frame(_agreeBtn.right + margin, _agreeBtn.top, 63, 17) inView:scroll text:@"阅读并同意" color:appGrayTextColor size:12];
    UIButton *agreeMentBtn = [UIButton creatBtn:frame(tip.right, _agreeBtn.top, 150, 17) inView:scroll bgColor:appClearColor title:@"《用户协议与隐私政策》" WithTag:1 target:self action:@selector(xieyi)];
       agreeMentBtn.titleLabel.font = [UIFont systemFontOfSize:12];
       [agreeMentBtn setTitleColor:appMainColor forState:UIControlStateNormal];
    
    UIButton *btn = [UIButton creatBtn:frame(23, agreeMentBtn.bottom + 18, ksWidth - 46, 40) inView:scroll bgImage:@"denglu-anniu" WithTag:1 target:self action:@selector(handleLoginEvent:)];
    UILabel *btnlabel = [UILabel creatLabel:frame(23, agreeMentBtn.bottom + 18, ksWidth - 46, 40) inView:scroll text:@"登录" color:appWhiteColor size:14];
    btnlabel.textAlignment = NSTextAlignmentCenter;
    

}

- (void)handleLoginEvent:(id)sender {
    
    NSString *telNumber = [self.userNameField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (telNumber.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号！"];
        return;
    }
    
    
    if (self.passwordField.text.length < 6) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确密码！"];
        return;
    }
    if (!_agreeBtn.selected) {
        [SVProgressHUD showInfoWithStatus:@"请先同意用户协议！"];
        return;
    }
    
    [SVProgressHUD show];
    NSDictionary *dic = @{
                          @"phone":telNumber,
                          @"password":self.passwordField.text,
                          };
    MioPostRequest *request = [[MioPostRequest alloc] initWithRequestUrl:api_passwordLogin argument:dic];
    
    
    [request success:^(NSDictionary *result) {
        NSDictionary *data = [result objectForKey:@"data"];
        NSString * token = [data objectForKey:@"access_token"];
        MioUserInfo *user = [MioUserInfo mj_objectWithKeyValues:[data objectForKey:@"user"]];
        [userdefault setObject:token forKey:@"token"];
        [userdefault setObject:user.id forKey:@"user_id"];
        [userdefault setObject:user.nickname forKey:@"nickname"];
        [userdefault setObject:user.avatar forKey:@"avatar"];
        [userdefault synchronize];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccess" object:nil];

        
        if (user.gender == 2) {

        }else{
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
        

    } failure:^(NSString *errorInfo) {
        [SVProgressHUD showErrorWithStatus:errorInfo ];
        
    }];
}



-(void)xieyi{
    MioUserAgreementVC *vc = [[MioUserAgreementVC alloc] init];
    vc.url = @"https://duoduo.apphw.com/policy.html";
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)agreeBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    return [UITextField inputTextField:textField
         shouldChangeCharactersInRange:range
                     replacementString:string
                        blankLocations:@[@3,@8]
                            limitCount:11];

}

@end
