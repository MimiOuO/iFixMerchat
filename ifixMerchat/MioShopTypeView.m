//
//  MioShopTypeView.m
//  ifixMerchat
//
//  Created by Mimio on 2020/4/3.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import "MioShopTypeView.h"

@interface MioShopTypeView()
@property (nonatomic, strong) UIView *bgView;

@end

@implementation MioShopTypeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = rgba(0, 0, 0, 0.5);
        self.frame = frame(0, ksHeight, ksWidth, ksHeight);
        UIView *closeView = [UIView creatView:frame(0, 0, ksWidth, ksHeight) inView:self bgColor:appClearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenView)];
        [closeView addGestureRecognizer:tap];
        
        _bgView = [UIView creatView:frame(0, ksHeight - 386 - SafeBottomH, ksWidth, 386 + SafeBottomH) inView:self bgColor:appWhiteColor];
        [_bgView addRoundedCorners:UIRectCornerTopRight|UIRectCornerTopLeft withRadii:CGSizeMake(16, 16)];
        
        UILabel *titleLab = [UILabel creatLabel:frame(0, 0, ksWidth, 50) inView:_bgView text:@"店铺类型" color:appSubColor size:16];
        titleLab.textAlignment = NSTextAlignmentCenter;
        UIView *splitView = [UIView creatView:frame(0, 50, ksWidth, 0.5) inView:_bgView bgColor:appBottomLineColor];


    }
    return self;
}

- (void)show{

   
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
     [window addSubview:self];
     
     self.frame = CGRectMake(0, 0, ksWidth, ksHeight);
     _bgView.top = ksHeight;
     [UIView animateWithDuration:0.3 animations:^{
         self.bgView.top  = ksHeight - 386 - SafeBottomH;
     }];
}

- (void)hiddenView {
    
        [UIView animateWithDuration:0.3 animations:^{
            self.bgView.top = ksHeight;
        } completion:^(BOOL finished) {
            self.frame = CGRectMake(0, ksHeight, ksWidth, ksHeight);
    //        [self removeFromSuperview];
        }];
}

@end
