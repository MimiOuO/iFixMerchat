//
//  MioOrderModel.m
//  ifixMerchat
//
//  Created by Mimio on 2020/4/17.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import "MioOrderModel.h"

@implementation MioOrderModel

- (NSString *)zh_status{
    return [self.status objectForKey:@"zh_status"];
}

- (NSString *)sku{
    return [self.format_sku objectForKey:@"spec"];
}

- (NSString *)serviceTime{
    NSString *date = [_start_at substringToIndex:11];
    NSString *str1 = [_start_at substringWithRange:NSMakeRange(11,5)];
    NSString *str2 = [_end_at substringWithRange:NSMakeRange(11,5)];
    return Str(date,str1,@"-",str2);
}

-(NSString *)need_description{
    if (_need_description.length) {
        return _need_description;
    }else{
        return @"暂无";
    }
}

- (NSString *)refund_reason{
    if (_refund_show) {
        return [_refund_show objectForKey:@"refund_reason"];
    }
    return @"";
}
- (NSArray *)refund_images_path{
    if (_refund_show) {
        return [_refund_show objectForKey:@"refund_images_path"];
    }
    return @[];
}

@end
