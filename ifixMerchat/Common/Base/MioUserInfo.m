//
//  ZMUserInfo.m
//  ZMBCY
//
//  Created by ZOMAKE on 2018/1/6.
//  Copyright © 2018年 Brance. All rights reserved.
//

#import "MioUserInfo.h"

#define userSessionToken @"userSessionToken"

static MioUserInfo *_userInfo;
@implementation MioUserInfo

/** 用户信息类的单例 */
+ (instancetype)shareUserInfo{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _userInfo = [[MioUserInfo alloc] init];
    });
    return _userInfo;
}

- (BOOL)isLogin{
	return [userdefault objectForKey:@"token"];
}

- (void)saveUserInfoToSandbox{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	NSData* imageData = [NSKeyedArchiver archivedDataWithRootObject:[UIImage imageNamed:@"icon"]];
	[[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"icon"];
	[defaults setObject:@"Orrilan Fitness" forKey:@"userName"];
	[defaults setObject:@"Male" forKey:@"sex"];
	[defaults setObject:@"Keep going,Never stop!" forKey:@"sign"];
    [defaults synchronize];
	
}

- (void)loginOut{
    [userdefault setObject:@"" forKey:@"token"];
	[userdefault synchronize];
}

-(NSString *)auth_video_cover{
    if (self.auth_video_path) {
        return [NSString stringWithFormat:@"%@?vframe/jpg/offset/1",self.auth_video_path];
    }
    return @"";
}

- (float)coin{
    float a = [[self.currency objectForKey:@"coin"] floatValue];
    return a;
}

- (float)coin_in{
    return [[_currency objectForKey:@"coin_in"] floatValue];
}

- (float)positive_coin_in{
    return [[_currency objectForKey:@"positive_coin_in"] floatValue];
}

- (NSString *)level{
    if ([_level isEqualToString:@"0"]) {
        return @"";
    }
    if ([_level isEqualToString:@"1"]) {
        return @"青铜";
    }
    if ([_level isEqualToString:@"2"]) {
        return @"白银";
    }
    if ([_level isEqualToString:@"3"]) {
        return @"黄金";
    }
    if ([_level isEqualToString:@"4"]) {
        return @"白金";
    }
    if ([_level isEqualToString:@"5"]) {
        return @"钻石";
    }
    return @"";
}

- (int)levelNum{
    return [_level intValue];
}
@end
