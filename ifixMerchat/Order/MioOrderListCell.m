//
//  MioOrderListCell.m
//  ifixMerchat
//
//  Created by Mimio on 2020/4/17.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import "MioOrderListCell.h"

@interface MioOrderListCell()
@property (nonatomic, strong) UILabel *orderNumber;
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
    }
    return self;
}

- (void)setModel:(MioOrderModel *)model{
    
}

@end
