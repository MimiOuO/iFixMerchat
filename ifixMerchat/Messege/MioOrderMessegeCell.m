//
//  MioOrderMessegeCell.m
//  DuoDuoPeiwan
//
//  Created by Mimio on 2019/9/9.
//  Copyright © 2019 Brance. All rights reserved.
//

#import "MioOrderMessegeCell.h"

@interface MioOrderMessegeCell()
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIImageView *gameIcon;
@property (nonatomic, strong) UILabel *gameNameLab;
@property (nonatomic, strong) UILabel *priceLab;
@property (nonatomic, strong) UILabel *orderidLab;
@property (nonatomic, strong) UILabel *serviceTimeLab;
@end

@implementation MioOrderMessegeCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _timeLab = [UILabel creatLabel:frame(0, 12, ksWidth, 17) inView:self.contentView text:@"" color:appGrayTextColor size:12];
        _timeLab.textAlignment = NSTextAlignmentCenter;
        UIView *bgView = [UIView creatView:frame(Margin, 35, ksWidth - 2* Margin, 129) inView:self.contentView bgColor:appWhiteColor];
        ViewRadius(bgView, 8);
        UIView *split = [UIView creatView:frame(0, 38, ksWidth - 2* Margin, 0.5) inView:bgView bgColor:appBottomLineColor];
        _titleLab = [UILabel creatLabel:frame(Margin, 8, ksWidth - 4* Margin, 22) inView:bgView text:@"" color:appMainColor size:16];
        _gameIcon = [UIImageView creatImgView:frame(Margin, 55, 44, 44) inView:bgView image:@"" radius:22];
        _gameNameLab = [UILabel creatLabel:frame(_gameIcon.right + 10, 55, 150, 20) inView:bgView text:@"" color:appSubColor size:14];
        _priceLab = [UILabel creatLabel:frame(_gameIcon.right + 10, 79, 150, 20) inView:bgView text:@"" color:appGrayTextColor size:14];
        _orderidLab = [UILabel creatLabel:frame(ksWidth - 3*Margin - 100, 55, 100, 20) inView:bgView text:@"" color:appSubColor size:14];
        _orderidLab.textAlignment = NSTextAlignmentRight;
        _serviceTimeLab = [UILabel creatLabel:frame(ksWidth - 3*Margin - 200, 79, 200, 20) inView:bgView text:@"" color:appSubColor size:14];
        _serviceTimeLab.textAlignment = NSTextAlignmentRight;
    }
    return self;
}

- (void)setOrder:(MioOrderModel *)order{
    _timeLab.text = order.created_at;
//    _titleLab.text = order.describe;
//    [_gameIcon sd_setImageWithURL:Url([order.game objectForKey:@"icon"])];
//    _gameNameLab.text = order.game_name;
//    _priceLab.text = [NSString stringWithFormat:@"%@币/%@ x%@",order.unit_price,order.unit,order.num];
//    _orderidLab.text = [NSString stringWithFormat:@"%08ld",(long)[order.order_id integerValue]];
//    _serviceTimeLab.text = order.formatDate;
}

@end
