//
//  MioOrderListCell.h
//  ifixMerchat
//
//  Created by Mimio on 2020/4/17.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MioOrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MioOrderListCell : UITableViewCell
@property (nonatomic, strong) MioOrderModel *model;
@end

NS_ASSUME_NONNULL_END
