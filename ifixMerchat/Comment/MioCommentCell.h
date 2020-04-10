//
//  MioTableViewCell.h
//  ifixMerchat
//
//  Created by Mimio on 2020/4/8.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MioCommentModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MioCommentCell : UITableViewCell
@property (nonatomic, strong) MioCommentModel *model;
@end

NS_ASSUME_NONNULL_END
