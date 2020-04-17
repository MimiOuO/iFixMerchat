//
//  MioProductModel.m
//  ifixMerchat
//
//  Created by Mimio on 2020/4/14.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import "MioProductModel.h"

@implementation MioProductModel

- (NSArray *)sku{
    return [_product_sku objectForKey:@"sku"];
}

- (NSArray *)attrs{
    return [_product_sku objectForKey:@"attrs"];
}

@end
