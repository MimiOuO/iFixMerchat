//
//  UIButton+MioExtension.m
//  longtengyuan
//
//  Created by Mimio on 2019/6/1.
//  Copyright © 2019 Brance. All rights reserved.
//

#import "UIButton+MioExtension.h"
#import "objc/runtime.h"
static const void * extraBy = &extraBy;

static const char btnBlock;



@implementation UIButton (MioExtension)
@dynamic extra;
@dynamic block;
- (void)setExtra:(NSString *)extra{
     objc_setAssociatedObject(self, extraBy, extra, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)extra{
    return objc_getAssociatedObject(self, extraBy);
}

+(UIButton *)creatBtninView:(UIView *)view bgImage:(NSString *)image WithTag:(NSInteger)tag target:(id)vc action:(SEL)action{
    UIButton *btn = [[UIButton alloc] init];
    [view addSubview:btn];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    btn.adjustsImageWhenHighlighted = NO;
    [btn addTarget:vc action:action forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    return btn;
}
+(UIButton *)creatBtninView:(UIView *)view bgColor:(UIColor *)color title:(NSString *)title WithTag:(NSInteger)tag target:(id)vc action:(SEL)action{
    UIButton *btn = [[UIButton alloc] init];
    [view addSubview:btn];
    btn.tag = tag;
    btn.backgroundColor = color;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.adjustsImageWhenHighlighted = NO;
    [btn addTarget:vc action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}



+(UIButton *)creatBtn:(CGRect)frame inView:(UIView *)view bgImage:(NSString *)image WithTag:(NSInteger)tag target:(id)vc action:(SEL)action{
	UIButton *btn = [[UIButton alloc] initWithFrame:frame];
	[view addSubview:btn];
	[btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
	btn.adjustsImageWhenHighlighted = NO;
	[btn addTarget:vc action:action forControlEvents:UIControlEventTouchUpInside];
	btn.tag = tag;
	return btn;
}
+(UIButton *)creatBtn:(CGRect)frame inView:(UIView *)view bgColor:(UIColor *)color title:(NSString *)title WithTag:(NSInteger)tag target:(id)vc action:(SEL)action{
	UIButton *btn = [[UIButton alloc] initWithFrame:frame];
	[view addSubview:btn];
	btn.tag = tag;
	btn.backgroundColor = color;
	[btn setTitle:title forState:UIControlStateNormal];
	btn.adjustsImageWhenHighlighted = NO;
	[btn addTarget:vc action:action forControlEvents:UIControlEventTouchUpInside];
	return btn;
}

+(UIButton *)creatBtn:(CGRect)frame inView:(UIView *)view bgImage:(NSString *)image action:(ButtonSenderBlock)block{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [view addSubview:btn];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    btn.adjustsImageWhenHighlighted = NO;
    btn.block = ^(UIButton *sender) {
        block(sender);
    };

    
    return btn;
}
+(UIButton *)creatBtn:(CGRect)frame inView:(UIView *)view bgColor:(UIColor *)color title:(NSString *)title action:(ButtonSenderBlock)block{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [view addSubview:btn];
    btn.backgroundColor = color;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.adjustsImageWhenHighlighted = NO;
    btn.block = ^(UIButton *sender) {
        block(sender);
    };
    return btn;
}

-(void)setBlock:(ButtonSenderBlock)block
{
    objc_setAssociatedObject(self, &btnBlock, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addTarget:self action:@selector(ButtonSenderOpen) forControlEvents:(UIControlEventTouchUpInside)];
}

-(ButtonSenderBlock)block
{
    return objc_getAssociatedObject(self, &btnBlock);
}


- (void)ButtonSenderOpen
{
    if (self.block)
    {
        self.block(self);
    }
}

@end
