//
//  MioSkuCell.m
//  ifixMerchat
//
//  Created by Mimio on 2020/4/14.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import "MioSkuCell.h"
@interface MioSkuCell()

@end

@implementation MioSkuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
//        UIView *bgView = [UIView creatView:frame(0, 0, ksWidth - 50, 48) inView:self.contentView bgColor:appClearColor];
//        bgView.userInteractionEnabled = NO;

        
        UIView *boderView1 = [UIView creatView:frame(18, 0 , ksWidth - 200, 40) inView:self.contentView bgColor:appClearColor];
        boderView1.layer.borderColor = appBottomLineColor.CGColor;
        boderView1.layer.borderWidth = 0.5;
        
        ViewRadius(boderView1, 4);
        

        
        UIView *boderView2 = [UIView creatView:frame(boderView1.right + 9, 0 ,70, 40) inView:self.contentView bgColor:appClearColor];
        boderView2.layer.borderColor = appBottomLineColor.CGColor;
        boderView2.layer.borderWidth = 0.5;
        ViewRadius(boderView2, 4);
        
        UILabel *tip = [UILabel creatLabel:frame(boderView2.left + 5, 13, 10, 14) inView:self.contentView text:@"￥" color:appSubColor size:10 alignment:NSTextAlignmentLeft];

        

        
        
        UIView *boderView3 = [UIView creatView:frame(boderView2.right + 8, 0 ,50, 40) inView:self.contentView bgColor:appClearColor];
        boderView3.layer.borderColor = appBottomLineColor.CGColor;
        boderView3.layer.borderWidth = 0.5;
        ViewRadius(boderView3, 4);
        
        UIButton *bgbtn = [UIButton creatBtn:frame(0, 0, ksWidth - 50, 48) inView:self.contentView bgColor:appClearColor title:@"" action:^{
            
        }];
        
        _skuName = [[UITextField alloc] initWithFrame:CGRectMake(28, 13, ksWidth - 200 - 20, 14)];
        _skuName.textColor = appSubColor;
        _skuName.font = Font(14);
        _skuName.placeholder = @"请输入店铺名称";
        [self.contentView addSubview:_skuName];
        
        _price = [[UITextField alloc] initWithFrame:CGRectMake(boderView2.left + 17, 13, 48, 14)];
        _price.keyboardType = UIKeyboardTypeDecimalPad;
        _price.textColor = appSubColor;
        _price.textAlignment = NSTextAlignmentCenter;
        _price.font = Font(14);
        _price.placeholder = @"价格";
        [self.contentView addSubview:_price];
        
        _stock = [[UITextField alloc] initWithFrame:CGRectMake(boderView3.left + 10, 13, 30, 14)];
        _stock.keyboardType = UIKeyboardTypeNumberPad;
        _stock.textColor = appSubColor;
        _stock.font = Font(14);
        _stock.textAlignment = NSTextAlignmentCenter;
        _stock.placeholder = @"库存";
        [self.contentView addSubview:_stock];
        
        UIImageView *delete = [UIImageView creatImgView:frame(ksWidth - 36, 11, 18, 18) inView:self.contentView image:@"delegate" radius:0];
    }
    return self;
}

-(void)clearData{
    _skuName.text = @"";
    _price.text = @"";
    _stock.text = @"";
}
@end
