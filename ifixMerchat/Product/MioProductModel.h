//
//  MioProductModel.h
//  ifixMerchat
//
//  Created by Mimio on 2020/4/14.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MioProductModel : NSObject

@property (nonatomic,copy) NSString * category_id;
@property (nonatomic,copy) NSString * category_name;
@property (nonatomic,copy) NSString * product_title;
@property (nonatomic, strong) NSArray *product_images;
@property (nonatomic,copy) NSString * product_detail;
@property (nonatomic, strong) NSArray *product_detail_images;
@property (nonatomic,copy) NSString * product_price;
@property (nonatomic, strong) NSDictionary *product_sku;
@property (nonatomic, strong) NSArray *sku;
@property (nonatomic, strong) NSArray *attrs;
@property (nonatomic,copy) NSString * product_score;
@property (nonatomic,copy) NSString * product_sales;
@property (nonatomic, assign) int product_status;
@end

NS_ASSUME_NONNULL_END
