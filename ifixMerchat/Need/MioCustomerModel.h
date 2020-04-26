//
//  MioCustomerModel.h
//  ifixMerchat
//
//  Created by Mimio on 2020/4/23.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MioCustomerModel : NSObject
@property (nonatomic,copy) NSString * customer_id;
@property (nonatomic,copy) NSString * customer_nickname;
@property (nonatomic,copy) NSString * customer_face;
@end

NS_ASSUME_NONNULL_END
