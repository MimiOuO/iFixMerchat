//
//  MioProductCell.h
//  ifixMerchat
//
//  Created by Mimio on 2020/4/15.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MioProductModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol ProductDelegate <NSObject>
//点击删除
- (void)clickDelete:(MioProductModel *)model;
//上下架
- (void)clickUpDown:(MioProductModel *)model;
//修改
- (void)clickModify:(MioProductModel *)model;

@end
@interface MioProductCell : UITableViewCell
@property (nonatomic, strong) MioProductModel *model;
@property (nonatomic, weak) id<ProductDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
