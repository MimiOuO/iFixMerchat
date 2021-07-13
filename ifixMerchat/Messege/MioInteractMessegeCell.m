//
//  MioInteractMessegeCell.m
//  DuoDuoPeiwan
//
//  Created by Mimio on 2020/1/14.
//  Copyright © 2020 Brance. All rights reserved.
//

#import "MioInteractMessegeCell.h"
//#import "MioPostModel.h"
@interface MioInteractMessegeCell()
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) MioAvatarView *avatar;
@property (nonatomic, strong) UILabel *nickName;
@property (nonatomic, strong) UILabel *descLab;
@property (nonatomic, strong) UIImageView *postImage;
@property (nonatomic, strong) UIImageView *videoArrow;
@end

@implementation MioInteractMessegeCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _timeLab = [UILabel creatLabel:frame(0, 12, ksWidth, 17) inView:self.contentView text:@"" color:appGrayTextColor size:12];
        _timeLab.textAlignment = NSTextAlignmentCenter;
        UIView *bgView = [UIView creatView:frame(Margin, 35, ksWidth - 2* Margin, 76) inView:self.contentView bgColor:appWhiteColor];
        ViewRadius(bgView, 8);
        _avatar = [[MioAvatarView alloc] initFrame:frame(Margin, 10, 56, 56) inView:bgView];
        _nickName = [UILabel creatLabel:frame(_avatar.right + 10, 13, 200, 20) inView:bgView text:@"" color:appGrayTextColor size:14 alignment:NSTextAlignmentLeft];
        _descLab = [UILabel creatLabel:frame(_avatar.right + 10, 43, 195, 20) inView:bgView text:@"" color:appSubColor size:14 alignment:NSTextAlignmentLeft];
        _postImage = [UIImageView creatImgView:frame(bgView.width - 56 - Margin, 10, 56, 56) inView:bgView image:@"" radius:6];
        _videoArrow = [UIImageView creatImgView:frame(18, 13, 20, 29) inView:_postImage image:@"playArrow" radius:0];
        _videoArrow.hidden = YES;
    }
    return self;
}

- (void)setData:(NSDictionary *)data{

}
@end
