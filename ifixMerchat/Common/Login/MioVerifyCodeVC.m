//
//  MioVerifyCodeVC.m
//  orrilan
//
//  Created by Mimio on 2019/8/16.
//  Copyright © 2019 Brance. All rights reserved.
//

#import "MioVerifyCodeVC.h"
#import "HWTFCursorView.h"

@interface MioVerifyCodeVC ()
@property (nonatomic, strong) HWTFCursorView *code4View;
@end

@implementation MioVerifyCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = appWhiteColor;
    [self.navView.leftButton setImage:backArrowIcon forState:UIControlStateNormal];
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHiden:) name:@"verifyCode" object:nil];
    
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NavHeight, ksWidth, ksHeight - NavHeight)];
    [self.view addSubview:scroll];
    UILabel *titleLabel = [UILabel creatLabel:frame(23,  94, 200, 25) inView:scroll text:@"请输入验证码" color:appSubColor size:18];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    
    UILabel *tipLab = [UILabel creatLabel:frame(23, titleLabel.bottom + 26, 200, 17) inView:scroll text:[NSString stringWithFormat:@"验证码已发送至 %@",self.phoneNumber] color:appGrayTextColor size:12];
    
    _code4View = [[HWTFCursorView alloc] initWithCount:6 kmargin:20];
    _code4View.frame = CGRectMake(23, tipLab.bottom + margin, ksWidth - 46  , 50);
    
    [scroll addSubview:_code4View];

}

- (void)keyboardWillBeHiden:(NSNotification *)notification
{
    if (self.code4View.code.length == 4) {
        if (self.wx) {
            
        }else{
            [self loginRequest];
        }
    }
    
}


-(void)loginRequest{
    NSDictionary *dic = @{
                          @"verification_key":self.verification_key,
                          @"verification_code":self.code4View.code,
                          };

    MioPostRequest *request = [[MioPostRequest alloc] initWithRequestUrl:api_login argument:dic];
    if (self.wx) {
        MioPostRequest *request = [[MioPostRequest alloc] initWithRequestUrl:api_login argument:dic];
    }
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
        [SVProgressHUD showErrorWithStatus:@"验证码不正确"];
    }];
}



@end
