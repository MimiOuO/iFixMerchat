//
//  MioFeedBackVC.m
//  DuoDuoPeiwan
//
//  Created by Mimio on 2019/9/5.
//  Copyright © 2019 Brance. All rights reserved.
//

#import "MioFeedBackVC.h"

@interface MioFeedBackVC ()<UITextViewDelegate>
//背景
@property(nonatomic,strong) UIView *noteTextBackgroudView;

//备注
@property(nonatomic,strong) UITextView *noteTextView;

//文字个数提示label
@property(nonatomic,strong) UILabel *textNumberLabel;

@property (nonatomic, strong) UILabel *placeholder;
@end

@implementation MioFeedBackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navView.leftButton setImage:backArrowIcon forState:UIControlStateNormal];
    [self.navView.centerButton setTitle:@"我要反馈" forState:UIControlStateNormal];
    self.view.backgroundColor = appbgColor;
    _noteTextBackgroudView = [[UIView alloc]init];
    _noteTextBackgroudView.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    
    //文本输入框
    _noteTextView = [[UITextView alloc]init];
    _noteTextView.keyboardType = UIKeyboardTypeDefault;
    
    [_noteTextView setTextColor:appSubColor];
    _noteTextView.delegate = self;
    _noteTextView.font = [UIFont systemFontOfSize:14];
    

    
    _textNumberLabel = [[UILabel alloc]init];
    _textNumberLabel.textAlignment = NSTextAlignmentRight;
    _textNumberLabel.font = [UIFont systemFontOfSize:12];
    _textNumberLabel.textColor = appGrayTextColor;
    _textNumberLabel.backgroundColor = [UIColor whiteColor];
    _textNumberLabel.text = [NSString stringWithFormat:@"0/%d    ",200];
    
    _noteTextBackgroudView.frame = CGRectMake(0, NavHeight + 10, ksWidth, 220);
    
    //文本编辑框
    _noteTextView.frame = CGRectMake(Margin, NavHeight + 17, ksWidth - 20, 176);
    
    //文字个数提示Label
    _textNumberLabel.frame = CGRectMake(0, _noteTextView.frame.origin.y + _noteTextView.frame.size.height +5, ksWidth-10, 15);
    
    [self.view addSubview:_noteTextBackgroudView];
    [self.view addSubview:_noteTextView];
    [self.view addSubview:_textNumberLabel];
    
    _placeholder = [UILabel creatLabel:frame(22, NavHeight + 22, ksWidth , 22) inView:self.view text:@"详细描述你的问题或建议，我们将及时跟进解决。" color:appGrayTextColor size:14];
    
    UIButton *submitBtn = [UIButton creatBtn:frame(Margin, NavHeight + 220 + 30, ksWidth - 2*Margin, 40) inView:self.view bgImage:@"Revisar_Button_submit" WithTag:1 target:self action:@selector(submit)];
}

- (void)textViewDidChangeSelection:(UITextView *)textView{
    
    if (textView.text.length>0) {
        _placeholder.hidden = YES;
    }else{
        _placeholder.hidden = NO;
    }
    
    NSLog(@"当前输入框文字个数:%ld",_noteTextView.text.length);
    //
    _textNumberLabel.text = [NSString stringWithFormat:@"%lu/%d    ",(unsigned long)_noteTextView.text.length,200];
    if (_noteTextView.text.length > 200) {
        _textNumberLabel.textColor = [UIColor redColor];
    }
    else{
        _textNumberLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    }
//    [self textChanged];
    

}

-(void)submit{
    if (_noteTextView.text.length == 0) {
        return;
    }
    
    NSDictionary *dic = @{
                          @"content":_noteTextView.text,
                          };
    MioPostRequest *request = [[MioPostRequest alloc] initWithRequestUrl:api_feedback argument:dic];
    
    [request success:^(NSDictionary *result) {
        NSDictionary *data = [result objectForKey:@"data"];
        [SVProgressHUD showSuccessWithStatus:@"提交成功"];
        
    } failure:^(NSString *errorInfo) {
        
        
    }];
}

@end
