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
@property (nonatomic,copy) NSString * shop_doorplate;
@property (nonatomic,copy) NSString * shop_service_scope;
@property (nonatomic,copy) NSString * shop_introduce;

@property (nonatomic, assign) int shop_status;

@end

NS_ASSUME_NONNULL_END
