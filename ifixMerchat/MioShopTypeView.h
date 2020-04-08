//
//  MioShopTypeView.h
//  ifixMerchat
//
//  Created by Mimio on 2020/4/3.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ShopTypeDelegate <NSObject>

@end


@interface MioShopTypeView : UIView
@property(nonatomic, weak)id <ShopTypeDelegate>delegate;
-(void)show;
@end

NS_ASSUME_NONNULL_END
