//
//  MioBillCell.m
//  DuoDuoPeiwan
//
//  Created by Mimio on 2019/9/17.
//  Copyright © 2019 Brance. All rights reserved.
//

#import "MioBillCell.h"
@interface MioBillCell()
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *priceLab;
@end

@implementation MioBillCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = appWhiteColor;
        _titleLab = [UILabel creatLabel:frame(Margin, 10, 200, 22) inView:self.contentView text:@"" color:appSubColor size:16];
        _timeLab = [UILabel creatLabel:frame(Margin, 38, 200, 17) inView:self.contentView text:@"" color:appGrayTextColor size:12];
        _priceLab = [UILabel creatLabel:frame(ksWidth - 100 - Margin, 0, 100, 65) inView:self.contentView text:@"" color:appMainColor size:18];
        _priceLab.textAlignment = NSTextAlignmentRight;
        UIView *split = [UIView creatView:frame(Margin, 65, ksWidth - Margin, 0.5) inView:self.contentView bgColor:appBottomLineColor];
    }
    return self;
}

- (void)setData:(NSDictionary *)data{
    _timeLab.text = [data objectForKey:@"created_at"];
    _titleLab.text = [data objectForKey:@"action_zh"];
    _priceLab.textColor = appMainColor;
    _priceLab.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"num"]];
    
    if ([[data objectForKey:@"event"] isEqualToString:@"order_pay"]) {
        _titleLab.text = @"订单支出";
        _priceLab.textColor = appRedTextColor;
        _priceLab.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"num"]];
    }
    if ([[data objectForKey:@"event"] isEqualToString:@"order_in"]) {
        _titleLab.text = @"订单收入";
        _priceLab.textColor = appMainColor;
        _priceLab.text = [NSString stringWithFormat:@"+%@",[data objectForKey:@"num"]];
    }
    if ([[data objectForKey:@"event"] isEqualToString:@"order_refund"]) {
        _titleLab.text = @"退款";
        _priceLab.textColor = appMainColor;
        _priceLab.text = [NSString stringWithFormat:@"+%@",[data objectForKey:@"num"]];
    }
    if ([[data objectForKey:@"event"] isEqualToString:@"recharge"]) {
        _titleLab.text = @"充值";
        _priceLab.textColor = appMainColor;
        _priceLab.text = [NSString stringWithFormat:@"+%@",[data objectForKey:@"num"]];
    }
    if ([[data objectForKey:@"event"] isEqualToString:@"send_gift"]) {
        _titleLab.text = @"送礼物";
        _priceLab.textColor = appRedTextColor;
        _priceLab.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"num"]];
    }
    if ([[data objectForKey:@"event"] isEqualToString:@"get_gift"]) {
        _titleLab.text = @"收到礼物";
        _priceLab.textColor = appMainColor;
        _priceLab.text = [NSString stringWithFormat:@"+%@",[data objectForKey:@"num"]];
    }
}

@end
