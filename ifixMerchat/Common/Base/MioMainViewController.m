//
//  ZMMainViewController.m
//  ZMBCY
//
//  Created by Mimio on 2019/7/23.
//  Copyright © 2019年 Mimio. All rights reserved.
//

#import "MioMainViewController.h"
#import "MioBaseNavigationController.h"
#import "TestViewController.h"
#import "EMConversationsViewController.h"
@interface MioMainViewController ()

@property (nonatomic, strong) UIControl *shadowView;
@property (nonatomic, strong) UIView *tipView;
@property (nonatomic, strong) UIButton *agreeBtn;
@property (nonatomic, strong) UIButton *rejectBtn;
@property (nonatomic, strong) UILabel *gameNameLab;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *userName;
@property (nonatomic, strong) UILabel *timeAndNum;
@property (nonatomic, strong) UILabel *remark;

@end

@implementation MioMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UITabBar appearance] setBarTintColor:appWhiteColor];
    [UITabBar appearance].translucent = NO;
    
    // 设置一个自定义 View,大小等于 tabBar 的大小
    UIView *bgView = [[UIView alloc] initWithFrame:frame(0, 0, ksWidth, 49 + SafeBottomH)];
    // 给自定义 View 设置颜色
    bgView.backgroundColor = appWhiteColor;
    // 将自定义 View 添加到 tabBar 上
    [self.tabBar insertSubview:bgView atIndex:0];
    
    UIImageView *upShaow = [UIImageView creatImgView:frame(0, -13, ksWidth, 13) inView:self.tabBar image:@"Home_upshadow" radius:0];
    self.tabBar.backgroundImage = [[UIImage alloc]init];
    self.tabBar.shadowImage = [[UIImage alloc]init];
    if (@available(iOS 13.0, *)) {
        UITabBarAppearance *tabBarAppearance = [self.tabBar.standardAppearance copy];
        [tabBarAppearance setBackgroundImage:[UIImage new]];
        [tabBarAppearance setShadowColor:[UIColor clearColor]];
        [self.tabBar setStandardAppearance:tabBarAppearance];
    }else{
        [self.tabBar setBackgroundImage:[UIImage new]];
        [self.tabBar setShadowImage:[UIImage new]];
    }

    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showCouponView:) name:@"getNewCouponSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login) name:@"login" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showTip:) name:@"showTip" object:nil];
    
    //首页
    [self addChildVc:[TestViewController new] title:@"首页" image:@"tab_home_ordinary" selectedImage:@"tab_home_selected"];
    //发现
    [self addChildVc:[TestViewController new] title:@"发现" image:@"tab_found_ordinary" selectedImage:@"tab_found_selected"];
    //消息
    [self addChildVc:[EMConversationsViewController new] title:@"消息" image:@"tab_message_ordinary" selectedImage:@"tab_message_selected"];
    //我的
    [self addChildVc:[TestViewController new] title:@"我的" image:@"tab_my_ordinary" selectedImage:@"tab_my_selected"];
	
}



#pragma mark - 添加子控制器
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    // 设置子控制器的文字(可以设置tabBar和navigationBar的文字)
    childVc.title = title;
    
    // 设置子控制器的tabBarItem图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    // 禁用图片渲染
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    MioBaseNavigationController *nav = [[MioBaseNavigationController alloc] initWithRootViewController:childVc];

    //设置item按钮
    nav.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:[[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //未选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:rgb(136, 134, 135),NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateNormal];
    
    //选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:appMainColor,NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateSelected];
    
    [nav.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -2)];
    
    // 添加子控制器
    [self addChildViewController:nav];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"内存爆了");
}



- (void)animationWithIndex:(NSInteger) index {
    
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.08;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.9];
    pulse.toValue= [NSNumber numberWithFloat:1.1];
    [[((UIButton *)tabbarbuttonArray[index]) layer] addAnimation:pulse forKey:nil];
}



@end
