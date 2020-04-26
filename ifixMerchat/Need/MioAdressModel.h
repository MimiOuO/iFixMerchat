//
//  MioAdressModel.h
//  ifixMerchat
//
//  Created by Mimio on 2020/4/24.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MioAdressModel : NSObject
@property (nonatomic,copy) NSString * customer_address_phone;
@property (nonatomic,copy) NSString * customer_address_username;
@property (nonatomic,copy) NSString * customer_address_area;
@property (nonatomic,copy) NSString * customer_address_full;
@property (nonatomic,copy) NSString * customer_address_longitude;
@property (nonatomic,copy) NSString * customer_address_latitude;
@end

NS_ASSUME_NONNULL_END
