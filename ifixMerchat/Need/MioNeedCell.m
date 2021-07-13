//
//  MioNeedCell.m
//  ifixMerchat
//
//  Created by Mimio on 2020/4/26.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import "MioNeedCell.h"
@interface MioNeedCell()
@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *nickName;
@property (nonatomic, strong) UILabel *state;
@property (nonatomic, strong) UILabel *type;
@property (nonatomic, strong) UILabel *serviceTime;
@property (nonatomic, strong) UILabel *adress;
@end

@implementation MioNeedCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *bgimage = [UIImageView creatImgView:frame(0, 0, ksWidth, 165) inView:self.contentView image:@"goods_bg" radius:0];
        UIView *split = [UIView creatView:frame(22, 62, ksWidth - 44, 0.5) inView:self.contentView bgColor:appBottomLineColor];
        _avatar = [UIImageView creatImgView:frame(24, 22, 30, 30) inView:self.contentView image:@"icon" radius:2];
        _nickName = [UILabel creatLabel:frame(62, 29, 200, 14) inView:self.contentView text:@"" color:appSubColor size:14 alignment:NSTextAlignmentLeft];
        _nickName.font = BoldFont(14);
        _state = [UILabel creatLabel:frame(ksWidth - 22 - 100, 29, 100, 14) inView:self.contentView text:@"" color:appRedTextColor size:14 alignment:NSTextAlignmentRight];
        UILabel *typeLab = [UILabel creatLabel:frame(22, 72, 60, 14) inView:self.contentView text:@"故障类型" color:appSubColor size:14 alignment:NSTextAlignmentLeft];
        UILabel *timeLab = [UILabel creatLabel:frame(22, typeLab.bottom + 10, 60, 14) inView:self.contentView text:@"服务时间" color:appSubColor size:14 alignment:NSTextAlignmentLeft];
        UILabel *adressLab = [UILabel creatLabel:frame(22, timeLab.bottom + 10, 60, 14) inView:self.contentView text:@"服务地址" color:appSubColor size:14 alignment:NSTextAlignmentLeft];
        _type = [UILabel creatLabel:frame(110 - 22 , typeLab.top, ksWidth - 110, 14) inView:self.contentView text:@"" color:appGrayTextColor size:13 alignment:NSTextAlignmentRight];
        _serviceTime = [UILabel creatLabel:frame(110 - 22 , timeLab.top, ksWidth - 110, 14) inView:self.contentView text:@"" color:appGrayTextColor size:13 alignment:NSTextAlignmentRight];
        _adress = [UILabel creatLabel:frame(110 - 22 , adressLab.top, ksWidth - 110, 14) inView:self.contentView text:@"" color:appGrayTextColor size:13 alignment:NSTextAlignmentRight];
    }
    return self;
}

- (void)setModel:(MioNeedModel *)model{
    [_avatar sd_setImageWithURL:Url(model.customer.customer_face) placeholderImage:image(@"icon")];
    _nickName.text = model.customer.customer_nickname;
    _state.text = model.zh_status;
    _type.text = model.need_category;
    _serviceTime.text = model.serviceTime;
    _adress.text = Str(model.address_info.customer_address_area,model.address_info.customer_address_full);
}

@end
