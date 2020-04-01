//
//  MioRedPacketBubbleView.m
//  DuoDuoPeiwan
//
//  Created by Mimio on 2020/1/16.
//  Copyright © 2020 Brance. All rights reserved.
//

#import "MioRedPacketBubbleView.h"

@implementation MioRedPacketBubbleView

- (instancetype)initWithDirection:(EMMessageDirection)aDirection
                             type:(EMMessageType)aType
{
    self = [super initWithDirection:aDirection type:aType];
    if (self) {
        [self _setupSubviews];
    }
    
    return self;
}

- (void)_setupSubviews
{
    NSLog(@"%@",[self.data mj_JSONString]);
    [self setupBubbleBackgroundImage];
    UIImageView *icon = [UIImageView creatImgView:frame(0, 0, 100, 100) inView:self image:@"icon" radius:0];
    self.backgroundColor = appRedTextColor;
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-15);
    }];
}

- (void)setModel:(EMMessageModel *)model
{
    EMMessageType type = model.type;
    if (type == EMMessageTypeFile) {
        EMFileMessageBody *body = (EMFileMessageBody *)model.emModel.body;
        NSLog(@"%@",body);
    }
}

@end
