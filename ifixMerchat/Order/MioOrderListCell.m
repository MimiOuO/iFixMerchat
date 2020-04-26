//
//  MioOrderListCell.m
//  ifixMerchat
//
//  Created by Mimio on 2020/4/17.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import "MioOrderListCell.h"

@interface MioOrderListCell()
@property (nonatomic, strong) UILabel *orderNo;
@property (nonatomic, strong) UILabel *state;
@property (nonatomic, strong) UIImageView *productImage;
@property (nonatomic, strong) UILabel *typeName;
@property (nonatomic, strong) UILabel *productName;
@property (nonatomic, strong) UILabel *skuName;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *adress;
@property (nonatomic, strong) UILabel *price;

@end

@implementation MioOrderListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *bgimage = [UIImageView creatImgView:frame(0, 0, ksWidth, 185) inView:self.contentView image:@"goods_bg" radius:0];
        UIView *split = [UIView creatView:frame(22, 49, ksWidth - 44, 0.5) inView:self.contentView bgColor:appBottomLineColor];
        _productImage = [UIImageView creatImgView:frame(22, 59, 100, 100) inView:self.contentView image:@"icon" radius:4];
        _orderNo = [UILabel creatLabel:frame(23, 24, 200, 14) inView:self.contentView text:@"" color:appGrayTextColor size:14 alignment:NSTextAlignmentLeft];
        _state = [UILabel creatLabel:frame(ksWidth - 23 - 50, 24, 50, 14) inView:self.contentView text:@"" color:rgba(252, 73, 73, 1) size:14 alignment:NSTextAlignmentRight];
        _typeName = [UILabel creatLabel:frame(0, 0, 60, 16) inView:_productImage text:_model.need_category color:appWhiteColor size:10 alignment:NSTextAlignmentCenter];
        _typeName.backgroundColor = appMainColor;
        _productName = [UILabel creatLabel:frame(130, 64, 200, 14) inView:self.contentView text:@"" color:appSubColor size:14 alignment:NSTextAlignmentLeft];
        _productName.font = BoldFont(14);
        _skuName = [UILabel creatLabel:frame(130, _productName.bottom + 6, 200, 11) inView:self.contentView text:@"" color:appGrayTextColor size:11 alignment:NSTextAlignmentLeft];
        _name = [UILabel creatLabel:frame(130, _skuName.bottom + 8, 200, 13) inView:self.contentView text:@"" color:appSubColor size:13 alignment:NSTextAlignmentLeft];
        _adress = [UILabel creatLabel:frame(130, _name.bottom + 8, 200, 13) inView:self.contentView text:@"" color:appSubColor size:13 alignment:NSTextAlignmentLeft];
        _price = [UILabel creatLabel:frame(ksWidth - 22 - 100, 142, 100, 16) inView:self.contentView text:@"" color:appRedTextColor size:16 alignment:NSTextAlignmentRight];
    }
    return self;
}

- (void)setModel:(MioOrderModel *)model{
    _orderNo.text = Str(@"订单编号：",model.no);
    _state.text = model.zh_status;
    _productName.text = model.product_title;
    _typeName.text = model.need_category;
    _skuName.text = Str(model.sku,@"  x",model.num);
    _name.text = Str(model.address_info.customer_address_username,@"  ",model.serviceTime);
    _adress.text = Str(model.address_info.customer_address_area,model.address_info.customer_address_full);
    
    
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:Str(@"￥",model.total_price)];
    [AttributedStr addAttribute:NSFontAttributeName value:BoldFont(10) range:NSMakeRange(0, 1)];
    _price.attributedText = AttributedStr;
}

@end
