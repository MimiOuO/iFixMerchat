//
//  MioOrderDetailVC.m
//  ifixMerchat
//
//  Created by Mimio on 2020/4/16.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import "MioOrderDetailVC.h"

@interface MioOrderDetailVC ()

@end

@implementation MioOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navView.leftButton setImage:backArrowIcon forState:UIControlStateNormal];
    [self.navView.centerButton setTitle:@"订单详情" forState:UIControlStateNormal];
    [self getOrder];
    
}

-(void)getOrder{
    [SVProgressHUD show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        [self creatUI];
    });
}

-(void)creatUI{
    
    //用户
    UIView *userView = [UIView creatView:frame(Margin, NavHeight + Margin, ksWidth - 2*Margin, 50) inView:self.view bgColor:appWhiteColor];
    userView.layer.borderColor = appBottomLineColor.CGColor;
    userView.layer.borderWidth = 0.5;
    ViewRadius(userView, 4);
    
    UIImageView *avatar = [UIImageView creatImgView:frame(10, 10, 30, 30) inView:userView image:@"icon" radius:2];
    UILabel *nickName = [UILabel creatLabel:frame(48, 18, 200,14) inView:userView text:@"京东方电脑维修" color:appSubColor size:14 alignment:NSTextAlignmentLeft];
    UIButton *messageBtn = [UIButton creatBtn:frame(ksWidth - 38 - 24, 17, 18.6, 16.6) inView:userView bgImage:@"order_icon_chat" action:^{
        
    }];
    
    //商品
    UIView *productView = [UIView creatView:frame(Margin, userView.bottom + 10, ksWidth - 2*Margin, 90) inView:self.view bgColor:appWhiteColor];
    productView.layer.borderColor = appBottomLineColor.CGColor;
    productView.layer.borderWidth = 0.5;
    ViewRadius(productView, 4);
    
    UIImageView *productPic = [UIImageView creatImgView:frame(10, 10, 70, 70) inView:productView image:@"icon" radius:4];
    UILabel *productName = [UILabel creatLabel:frame(productPic.right + 8, 16, ksWidth - 120, 14) inView:productView text:@"上门电脑维修" color:appSubColor size:14 alignment:NSTextAlignmentLeft];
    UILabel *typeName = [UILabel creatLabel:frame(productPic.right + 8, 37, 100, 11) inView:productView text:@"上门电脑维修" color:appGrayTextColor size:11 alignment:NSTextAlignmentLeft];
    UILabel *numLab = [UILabel creatLabel:frame(ksWidth - 34 - 30, 37, 30, 11) inView:productView text:@"x1" color:appSubColor size:11 alignment:NSTextAlignmentRight];
    UILabel *priceLab = [UILabel creatLabel:frame(ksWidth - 80 - 100, 58, 100, 16) inView:productView text:@"￥93.00" color:appMainColor size:16 alignment:NSTextAlignmentRight];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:@"￥93.00"];
    [AttributedStr addAttribute:NSFontAttributeName value:BoldFont(10) range:NSMakeRange(0, 1)];
    priceLab.attributedText = AttributedStr;
    UIButton *modifyBtn = [UIButton creatBtn:frame(ksWidth - 34 - 40, 58, 40, 16) inView:productView bgColor:appWhiteColor title:@"修改" action:^{
        
    }];
    modifyBtn.titleLabel.font = Font(10);
    [modifyBtn setTitleColor:appMainColor forState:UIControlStateNormal];
    modifyBtn.layer.borderColor = appMainColor.CGColor;
    modifyBtn.layer.borderWidth = 0.5;
    ViewRadius(modifyBtn, 2);

    
    //订单
    UIView *orderView = [UIView creatView:frame(Margin, productView.bottom + 10, ksWidth - 2*Margin, 180) inView:self.view bgColor:appWhiteColor];
    orderView.layer.borderColor = appBottomLineColor.CGColor;
    orderView.layer.borderWidth = 0.5;
    ViewRadius(orderView, 4);
    


    
    
    //故障描述
}


@end
