//
//  MioCommentModel.h
//  ifixMerchat
//
//  Created by Mimio on 2020/4/8.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MioCustomerModel.h"
#import "MioOrderModel.h"
#import "MioProductModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MioCommentModel : NSObject
@property (nonatomic,copy) NSString * order_comment_id;
@property (nonatomic, strong) MioOrderModel *order;
@property (nonatomic, strong) MioCustomerModel *customer;
@property (nonatomic,copy) NSString * comment;
@property (nonatomic, strong) NSArray *comment_images_path;
@property (nonatomic,copy) NSString * created_at;
@property (nonatomic,copy) NSString * shop_reply;
@property (nonatomic,copy) NSString * comment_score;
@property (nonatomic, assign) int comment_rate;
@property (nonatomic,copy) MioProductModel * product;


@end

NS_ASSUME_NONNULL_END
