//
//  MioModifyProductVC.h
//  ifixMerchat
//
//  Created by Mimio on 2020/4/15.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import "MioViewController.h"
#import "MioProductModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MioModifyProductVC : MioViewController
@property (nonatomic,copy) NSString * productId;
@property (nonatomic, strong) MioProductModel *model;
@end

NS_ASSUME_NONNULL_END
