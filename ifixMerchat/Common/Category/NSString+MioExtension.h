//
//  NSString+MioExtension.h
//  DuoDuoPeiwan
//
//  Created by Mimio on 2019/12/23.
//  Copyright © 2019 Brance. All rights reserved.

#import <Foundation/Foundation.h>

#define Str(firstStr,...) [NSString JoinedWithSubStrings:firstStr,__VA_ARGS__,nil]

@interface NSString (MioExtension)

+ (NSString *)JoinedWithSubStrings:(id)firstStr,...NS_REQUIRES_NIL_TERMINATION;

- (CGFloat)widthForFont:(UIFont *)font;

- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width;
@end
