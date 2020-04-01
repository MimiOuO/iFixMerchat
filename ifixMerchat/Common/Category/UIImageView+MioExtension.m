//
//  UIImageView+MioExtension.m
//  longtengyuan
//
//  Created by Mimio on 2019/6/2.
//  Copyright © 2019 Brance. All rights reserved.
//

#import "UIImageView+MioExtension.h"

@implementation UIImageView (MioExtension)
+(UIImageView *)creatImginView:(UIView *)view image:(NSString *)image radius:(CGFloat)radius{
    UIImageView *imgView = [[UIImageView alloc] init];
    [view addSubview:imgView];
    imgView.image = [UIImage imageNamed:image];
    if (radius) {
        imgView.layer.cornerRadius = radius;
        imgView.layer.masksToBounds = YES;
    }
    
    return imgView;
}

+(UIImageView *)creatImgView:(CGRect)frame inView:(UIView *)view image:(NSString *)image radius:(CGFloat)radius{
	UIImageView *imgView = [[UIImageView alloc] initWithFrame:frame];
	[view addSubview:imgView];
	imgView.image = [UIImage imageNamed:image];
	if (radius) {
		imgView.layer.cornerRadius = radius;
		imgView.layer.masksToBounds = YES;
	}
	
	return imgView;
}
	

	
@end
