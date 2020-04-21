//
//  MioProductCell.m
//  ifixMerchat
//
//  Created by Mimio on 2020/4/15.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import "MioProductCell.h"

@interface MioProductCell()
@property (nonatomic, strong) UIImageView *showImg;
@property (nonatomic, strong) UILabel *typeLab;
@property (nonatomic, strong) UILabel *productName;
@property (nonatomic, strong) UIImageView *rateStar;
@property (nonatomic, strong) UILabel *cmtLab;
@property (nonatomic, strong) UILabel *stockLab;
@property (nonatomic, strong) UILabel *saleLab;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIButton *upDownBtn;
@property (nonatomic, strong) UIButton *modifyBtn;
@end

@implementation MioProductCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *bgimage = [UIImageView creatImgView:frame(0, 0, ksWidth, 175) inView:self.contentView image:@"goods_bg" radius:0];
        _showImg = [UIImageView creatImgView:frame(Margin, 9, 107, 107) inView:self.contentView image:@"icon" radius:0];
        [_showImg addRoundedCorners:UIRectCornerTopLeft withRadii:CGSizeMake(4, 4)];
        _typeLab = [UILabel creatLabel:frame(0, 0, 74, 16) inView:_showImg text:@"重装系统" color:appWhiteColor size:10 alignment:NSTextAlignmentCenter];
        _typeLab.backgroundColor = appMainColor;
        [_typeLab addRoundedCorners:UIRectCornerBottomRight withRadii:CGSizeMake(2, 2)];
        _productName = [UILabel creatLabel:frame(129, 23, ksWidth - 117 - 34, 14) inView:self.contentView text:@"上门电脑维修" color:appSubColor size:14 alignment:NSTextAlignmentLeft];_productName.font = BoldFont(14);
        _rateStar = [UIImageView creatImgView:frame(129, _productName.bottom + 4, 71.5, 8) inView:self.contentView image:@"star_5" radius:0];
        _cmtLab = [UILabel creatLabel:frame(129, _rateStar.bottom + 8, 80, 12) inView:self.contentView text:@"评论 66" color:appGrayTextColor size:12 alignment:NSTextAlignmentLeft];
        _stockLab = [UILabel creatLabel:frame(129, _cmtLab.bottom + 4, 80, 12) inView:self.contentView text:@"库存 66" color:appGrayTextColor size:12 alignment:NSTextAlignmentLeft];
        _saleLab = [UILabel creatLabel:frame(129, _stockLab.bottom + 4, 80, 12) inView:self.contentView text:@"销量 66" color:appGrayTextColor size:12 alignment:NSTextAlignmentLeft];
        
        _price = [UILabel creatLabel:frame(ksWidth - 120 - 24, 82, 120, 20) inView:self.contentView text:@"￥33.00" color:appMainColor size:20 alignment:NSTextAlignmentRight];
        
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:@"￥33.00"];
        [AttributedStr addAttribute:NSFontAttributeName value:BoldFont(12) range:NSMakeRange(0, 1)];
        
        _price.attributedText = AttributedStr;
        
        UIView *split1 = [UIView creatView:frame(Margin, 116, ksWidth - 2*Margin, 0.5) inView:self.contentView bgColor:rgba(0, 0, 0, 0.1)];
        UIView *split2 = [UIView creatView:frame(Margin + (ksWidth - 2 * Margin)/3, 126, 0.5, 25) inView:self.contentView bgColor:rgb(238, 238, 238)];
        UIView *split3 = [UIView creatView:frame(Margin + (ksWidth - 2 * Margin)/3 * 2, 126, 0.5, 25) inView:self.contentView bgColor:rgb(238, 238, 238)];
        WEAKSELF;

        _deleteBtn = [UIButton creatBtn:frame(Margin, 117, (ksWidth-2*Margin)/3, 43) inView:self.contentView bgColor:appClearColor title:@"删除" action:^{
            if([self.delegate respondsToSelector:@selector(clickDelete:)]) {
                [self.delegate clickDelete:weakSelf.model];
            }
        }];
        [_deleteBtn setTitleColor:rgb(252, 73, 73) forState:UIControlStateNormal];
        _deleteBtn.titleLabel.font = Font(14);
        
        
        _upDownBtn = [UIButton creatBtn:frame(_deleteBtn.right, 117, (ksWidth-2*Margin)/3, 43) inView:self.contentView bgColor:appClearColor title:@"下架" action:^{
            if([self.delegate respondsToSelector:@selector(clickUpDown:)]) {
                [self.delegate clickUpDown:weakSelf.model];
            }
        }];
        [_upDownBtn setTitleColor:appMainColor forState:UIControlStateNormal];
        _upDownBtn.titleLabel.font = Font(14);
        
        
        _modifyBtn = [UIButton creatBtn:frame(_upDownBtn.right, 117, (ksWidth-2*Margin)/3, 43) inView:self.contentView bgColor:appClearColor title:@"修改" action:^{
            if([self.delegate respondsToSelector:@selector(clickModify:)]) {
                [self.delegate clickModify:_model];
            }
        }];
        [_modifyBtn setTitleColor:appMainColor forState:UIControlStateNormal];
        _modifyBtn.titleLabel.font = Font(14);
    }
    return self;
}

- (void)setModel:(MioProductModel *)model{
    [_showImg sd_setImageWithURL:model.product_images[0] placeholderImage:image(@"icon")];
    _productName.text = model.product_title;
    _typeLab.text = model.category_name;
    _rateStar.image = [UIImage imageNamed:Str(@"star_",model.product_score)];
    _cmtLab.text = Str(@"评论",model.product_sales);
    _stockLab.text = Str(@"库存",model.product_sales);
    _saleLab.text = Str(@"销量",model.product_sales);
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:Str(@"￥",model.product_price)];
    [AttributedStr addAttribute:NSFontAttributeName value:BoldFont(12) range:NSMakeRange(0, 1)];
    _price.attributedText = AttributedStr;
    if (model.product_status == 2) {
        [_upDownBtn setTitle:@"上架" forState:UIControlStateNormal];
    }

}


@end
