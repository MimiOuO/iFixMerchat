//
//  MioShopModel.h
//  ifixMerchat
//
//  Created by Mimio on 2020/4/8.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MioShopModel : NSObject
@property (nonatomic,copy) NSString * shop_id;
@property (nonatomic,copy) NSString * shop_title;
@property (nonatomic,copy) NSString * shop_cover;
@property (nonatomic,copy) NSString * shop_contact_phone;
@property (nonatomic,copy) NSString * shop_province;
@property (nonatomic,copy) NSString * shop_city;
@property (nonatomic,copy) NSString * shop_district;
@property (nonatomic,copy) NSString * shop_area;
@property (nonatomic,copy) NSString * shop_address_full;
@property (nonatomic,copy) NSString * shop_longitude;
@property (nonatomic,copy) NSString * shop_latitude;
@property (nonatomic, assign) int shop_service_scope;
@property (nonatomic,copy) NSString * shop_introduce;

@property (nonatomic, strong) NSArray *shop_images;
@property (nonatomic,copy) NSString * shop_master_name;
@property (nonatomic,copy) NSString * shop_id_card;
@property (nonatomic,copy) NSString * shop_id_card_positive;
@property (nonatomic,copy) NSString * shop_id_card_back;

@property (nonatomic, assign) int shop_status;
@property (nonatomic, assign) float shop_score;
@property (nonatomic,copy) NSString * shop_star;
@end

NS_ASSUME_NONNULL_END
