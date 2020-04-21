//
//  MioOrderModel.h
//  ifixMerchat
//
//  Created by Mimio on 2020/4/17.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MioOrderModel : NSObject
@property (nonatomic,copy) NSString * address_id;
@property (nonatomic,copy) NSString * product_id;

@property (nonatomic,copy) NSString * start_at;
@property (nonatomic,copy) NSString * end_at;

@property (nonatomic,copy) NSString * need_category;
@property (nonatomic,copy) NSString * need_description;
@property (nonatomic, strong) NSArray *need_images;
@property (nonatomic, strong) NSDictionary *sku;
@end

NS_ASSUME_NONNULL_END
