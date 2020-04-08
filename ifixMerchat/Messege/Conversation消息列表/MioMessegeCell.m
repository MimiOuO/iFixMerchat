//
//  MioMessegeCell.m
//  DuoDuoPeiwan
//
//  Created by Mimio on 2019/9/5.
//  Copyright © 2019 Brance. All rights reserved.
//

#import "MioMessegeCell.h"

@interface MioMessegeCell()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *detailLab;
@property (nonatomic, strong) UILabel *timeLab;
@end

@implementation MioMessegeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _icon = [UIImageView creatImgView:frame(10, 12, 44, 44) inView:self.contentView image:@"" radius:0];
        _titleLab = [UILabel creatLabel:frame(_icon.right +10, 12, 100, 21) inView:self.contentView text:@"" color:appSubColor size:15];
        _titleLab.font = [UIFont boldSystemFontOfSize:15];
        _detailLab = [UILabel creatLabel:frame(_icon.right + 10, _titleLab.bottom + 3, 200, 20) inView:self.contentView text:@"暂无消息" color:appGrayTextColor size:14];
        _timeLab = [UILabel creatLabel:frame(ksWidth - 100 - 34, 10, 100, 17) inView:self.contentView text:@"" color:appGrayTextColor size:12];
        _timeLab.textAlignment = NSTextAlignmentRight;

    }
    return self;
}

- (void)setTitle:(NSString *)title{
    _titleLab.text = title;
    if ([title isEqualToString:@"互动消息"]) {
        _icon.image = image(@"message_interactive");
    }
    if ([title isEqualToString:@"系统通知"]) {
        _icon.image = image(@"message_os");
    }
}

- (void)setDetail:(NSString *)detail{
    _detailLab.text = detail;
}

- (void)setTime:(NSString *)time{
    _timeLab.text = time;
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x += Margin;
    
    frame.size.width -= 2 * Margin;
    
    [super setFrame:frame];
}
@end
