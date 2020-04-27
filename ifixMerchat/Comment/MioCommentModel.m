//
//  MioCommentModel.m
//  ifixMerchat
//
//  Created by Mimio on 2020/4/8.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import "MioCommentModel.h"

@implementation MioCommentModel
- (int)comment_rate{
    float scroe = [_comment_score floatValue];
    if (scroe <= .5) {
        return 0.5;
    }
    if (scroe <= 1) {
        return 1;
    }
    if (scroe <= 1.5) {
        return 1.5;
    }
    if (scroe <= 2) {
        return 2;
    }
    if (scroe <= 2.5) {
        return 2.5;
    }
    if (scroe <= 3) {
        return 3;
    }
    if (scroe <= 3.5) {
        return 3.5;
    }
    if (scroe <= 4) {
        return 4;
    }
    if (scroe <= 4.5) {
        return 4.5;
    }
    if (scroe <= 5) {
        return 5;
    }
    return 5;
}
@end
