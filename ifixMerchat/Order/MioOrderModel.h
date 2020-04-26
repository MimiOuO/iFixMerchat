//
//  MioOrderModel.h
//  ifixMerchat
//
//  Created by Mimio on 2020/4/17.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MioCustomerModel.h"
#import "MioAdressModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MioOrderModel : NSObject
@property (nonatomic,copy) NSString * order_id;
//顾客
@property (nonatomic, strong) MioCustomerModel *customer;
//商品
@property (nonatomic,copy) NSString * product_id;
@property (nonatomic,copy) NSString * product_title;
@property (nonatomic, strong) NSArray *product_images;
@property (nonatomic, strong) NSDictionary *format_sku;
@property (nonatomic,copy) NSString * sku;
@property (nonatomic,copy) NSString * num;
@property (nonatomic,copy) NSString * total_price;


//服务信息
@property (nonatomic,copy) NSDictionary * status;
@property (nonatomic,copy) NSString * no;
@property (nonatomic,copy) NSString * zh_status;
@property (nonatomic,copy) NSString * start_at;
@property (nonatomic,copy) NSString * end_at;
@property (nonatomic,copy) NSString * serviceTime;
@property (nonatomic,strong) MioAdressModel * address_info;
@property (nonatomic,copy) NSString * created_at;



//故障

@property (nonatomic,copy) NSString * need_category;
@property (nonatomic,copy) NSString * need_description;
@property (nonatomic, strong) NSArray *need_images_path;
@end

NS_ASSUME_NONNULL_END
