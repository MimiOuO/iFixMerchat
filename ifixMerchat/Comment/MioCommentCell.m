//
//  MioTableViewCell.m
//  ifixMerchat
//
//  Created by Mimio on 2020/4/8.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import "MioCommentCell.h"
@interface MioCommentCell()
@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *nickname;
@property (nonatomic, strong) UIImageView *rate;
@property (nonatomic, strong) UILabel *cmtTime;
@property (nonatomic, strong) UILabel *serviceName;
@property (nonatomic, strong) UILabel *serviewTime;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *cmt;
@property (nonatomic, strong) UILabel *reply;
@end

@implementation MioCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = appMainColor;
        
    }
    return self;
}
@end
