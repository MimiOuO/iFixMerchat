//
//  MioRedPacketBubbleView.h
//  DuoDuoPeiwan
//
//  Created by Mimio on 2020/1/16.
//  Copyright © 2020 Brance. All rights reserved.
//

#import "EMMessageBubbleView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MioRedPacketBubbleView : EMMessageBubbleView
@property (nonatomic, strong) NSData *data;

- (instancetype)initWithDirection:(EMMessageDirection)aDirection type:(EMMessageType)aType;
@end

NS_ASSUME_NONNULL_END
