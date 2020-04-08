//
//  EMConversationCell.m
//  ChatDemo-UI3.0
//
//  Created by XieYajie on 2019/1/8.
//  Copyright © 2019 XieYajie. All rights reserved.
//

#import "EMConversationCell.h"

#import "EMDateHelper.h"
#import "EMConversationHelper.h"

static NSString *kConversation_IsRead = @"kHaveAtMessage";
static int kConversation_AtYou = 1;
static int kConversation_AtAll = 2;

@interface EMConversationCell()

@end

@implementation EMConversationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _setupSubview];
    }
    
    return self;
}

#pragma mark - private layout subviews

- (void)_setupSubview
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _avatarView = [[MioAvatarView alloc] initFrame:frame(0, 0, 44, 44) inView:self.contentView];
    [_avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(12);
        make.left.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-12);
        make.width.equalTo(self.avatarView.mas_height).multipliedBy(1);
    }];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textColor = appGrayTextColor;
    _timeLabel.backgroundColor = [UIColor clearColor];
    [_timeLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarView);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.backgroundColor = [UIColor clearColor];
    _nameLabel.textColor = appSubColor;
    _nameLabel.font = [UIFont boldSystemFontOfSize:15];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.avatarView.mas_right).offset(10);
        make.right.equalTo(self.timeLabel.mas_left);
    }];
    
    _badgeLabel = [[EMBadgeLabel alloc] init];
    _badgeLabel.clipsToBounds = YES;
    _badgeLabel.layer.cornerRadius = 10;
    [self.contentView addSubview:_badgeLabel];
    [_badgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_centerY).offset(3);
        make.right.equalTo(self.contentView).offset(-15);
        make.height.equalTo(@20);
        make.width.greaterThanOrEqualTo(@20);
    }];
    
    _detailLabel = [[UILabel alloc] init];
    _detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _detailLabel.backgroundColor = [UIColor clearColor];
    _detailLabel.font = [UIFont systemFontOfSize:14];
    _detailLabel.textColor = appGrayTextColor;
    [self.contentView addSubview:_detailLabel];
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_centerY).offset(3);
        make.left.equalTo(self.nameLabel);
        make.right.equalTo(self.badgeLabel.mas_left).offset(-5);
        make.bottom.equalTo(self.contentView).offset(-8);
    }];
}

#pragma mark - setter

- (NSAttributedString *)_getDetailWithModel:(EMConversation *)aConversation
{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:@""];
    
    EMMessage *lastMessage = [aConversation latestMessage];
    if (!lastMessage) {
        return attributedStr;
    }
    
    NSString *latestMessageTitle = @"";
    EMMessageBody *messageBody = lastMessage.body;
    switch (messageBody.type) {
        case EMMessageBodyTypeText:
        {
            NSString *str = [EMEmojiHelper convertEmoji:((EMTextMessageBody *)messageBody).text];
            latestMessageTitle = str;
        }
            break;
        case EMMessageBodyTypeImage:
            latestMessageTitle = @"[图片]";
            break;
        case EMMessageBodyTypeVoice:
            latestMessageTitle = @"[音频]";
            break;
        case EMMessageBodyTypeLocation:
            latestMessageTitle = @"[位置]";
            break;
        case EMMessageBodyTypeVideo:
            latestMessageTitle = @"[视频]";
            break;
        case EMMessageBodyTypeFile:
            latestMessageTitle = @"[自定义消息]";
            break;
        default:
            break;
    }
    
//    if (lastMessage.direction == EMMessageDirectionReceive) {
//        NSString *from = lastMessage.from;
//        latestMessageTitle = [NSString stringWithFormat:@"%@: %@", from, latestMessageTitle];
//    }
    
    NSDictionary *ext = aConversation.ext;
    if (ext && [ext[kConversation_IsRead] intValue] == kConversation_AtAll) {
        NSString *allMsg = @"[有全体消息]";
        latestMessageTitle = [NSString stringWithFormat:@"%@ %@", allMsg, latestMessageTitle];
        attributedStr = [[NSMutableAttributedString alloc] initWithString:latestMessageTitle];
        [attributedStr setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:1.0 green:.0 blue:.0 alpha:0.5]} range:NSMakeRange(0, allMsg.length)];
        
    } else if (ext && [ext[kConversation_IsRead] intValue] == kConversation_AtYou) {
        NSString *atStr = @"[有人@我]";
        latestMessageTitle = [NSString stringWithFormat:@"%@ %@", atStr, latestMessageTitle];
        attributedStr = [[NSMutableAttributedString alloc] initWithString:latestMessageTitle];
        [attributedStr setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:1.0 green:.0 blue:.0 alpha:0.5]} range:NSMakeRange(0, atStr.length)];
    } else {
        attributedStr = [[NSMutableAttributedString alloc] initWithString:latestMessageTitle];
    }
    
    return attributedStr;
}

- (NSString *)_getTimeWithModel:(EMConversation *)aConversation
{
    NSString *latestMessageTime = @"";
    EMMessage *lastMessage = [aConversation latestMessage];;
    if (lastMessage) {
        double timeInterval = lastMessage.timestamp ;
        if(timeInterval > 140000000000) {
            timeInterval = timeInterval / 1000;
        }
        NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        latestMessageTime = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
    }
    return latestMessageTime;
}

- (void)setModel:(EMConversationModel *)model
{
    _model = model;
    
    EMConversation *conversation = model.emModel;
//    if (conversation.type == EMConversationTypeChat) {
//        self.avatarView.image = [UIImage imageNamed:@"user_avatar_blue"];
//        [self.avatarView sd_setImageWithURL:Url(@"http://file.giggsgame.com/image/20190902180013637")];
//    } else {
//        self.avatarView.image = [UIImage imageNamed:@"group_avatar"];
//    }
    [self getUserInfoWithID:model.name];
//    [self.avatarView sd_setImageWithURL:Url([[DuoduoDB getObjectById:model.name fromTable:userTable] objectForKey:@"avatar"])];
    //头像
//    [self.avatarView setAvatar:[[DuoduoDB getObjectById:model.name fromTable:userTable] objectForKey:@"avatar"] level:@""];
//    self.nameLabel.text = [[DuoduoDB getObjectById:model.name fromTable:userTable] objectForKey:@"nickname"];
//    self.nameLabel.text = model.name;
    self.detailLabel.attributedText = [self _getDetailWithModel:conversation];
    self.timeLabel.text = [self _getTimeWithModel:conversation];
    
    if (conversation.unreadMessagesCount == 0) {
        self.badgeLabel.value = @"";
        self.badgeLabel.hidden = YES;
    } else {
        self.badgeLabel.value = [NSString stringWithFormat:@" %@ ", @(conversation.unreadMessagesCount)];
        self.badgeLabel.hidden = NO;
    }
}

-(void)getUserInfoWithID:(NSString *)user_id{

    MioGetRequest *request = [[MioGetRequest alloc] initWithRequestUrl:api_otherUserinfo(user_id) argument:nil];
    
    [request success:^(NSDictionary *result) {
        NSDictionary *data = [result objectForKey:@"data"];
        MioUserInfo *user = [MioUserInfo mj_objectWithKeyValues:data];
        self.nameLabel.text = user.nickname;
        self.nameLabel.textColor = appNickColor(user.levelNum);
        [self.avatarView setAvatar:user.avatar level:user.level];
        
        NSDictionary *userInfo = @{@"nickname": user.nickname, @"avatar": user.avatar};
        //头像
//        [DuoduoDB putObject:userInfo withId:user_id intoTable:userTable];
        
    } failure:^(NSString *errorInfo) {
        
        
    }];
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x += Margin;

    frame.size.width -= 2 * Margin;

    [super setFrame:frame];
}

@end
