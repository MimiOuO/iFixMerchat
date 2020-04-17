//
//  MioSkuCell.h
//  ifixMerchat
//
//  Created by Mimio on 2020/4/14.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MioSkuCell : UITableViewCell
-(void)clearData;
@property (nonatomic, strong) UITextField *skuName;
@property (nonatomic, strong) UITextField *price;
@property (nonatomic, strong) UITextField *stock;
@end

NS_ASSUME_NONNULL_END
