//
//  MioNeedDetailVC.h
//  ifixMerchat
//
//  Created by Mimio on 2020/4/28.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import "MioViewController.h"
#import "MioNeedModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MioNeedDetailVC : MioViewController
@property (nonatomic,copy) NSString * needId;
@property (nonatomic, strong) MioNeedModel *model;
@end

NS_ASSUME_NONNULL_END
