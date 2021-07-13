//
//  MioOrderListVC.m
//  ifixMerchat
//
//  Created by Mimio on 2020/4/17.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import "MioOrderListVC.h"
#import <WMPageController.h>
#import "MioWaitPayOrderVC.h"
@interface MioOrderListVC ()<WMPageControllerDelegate,WMPageControllerDataSource>
@property (nonatomic, strong) WMPageController *pageController;
@end

@implementation MioOrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navView.centerButton setTitle:@"订单管理" forState:UIControlStateNormal];
    self.navView.split.hidden = YES;
    if ([self.navigationController viewControllers].count > 1) {
        [self.navView.leftButton setImage:backArrowIcon forState:UIControlStateNormal]; 
    }

    [self creatPage];
}

#pragma mark - UI
-(void)creatPage{
    
    UIView * contentView = [[UIView alloc] initWithFrame:frame(0, NavHeight, ksWidth, ksHeight - NavHeight)];
    contentView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:contentView];
    

    
    _pageController = [[WMPageController alloc] init];
    [self addChildViewController:_pageController];
    _pageController.delegate           = self;
    _pageController.dataSource         = self;
    _pageController.menuViewStyle      = WMMenuViewStyleLine;
    _pageController.automaticallyCalculatesItemWidths = YES;
    _pageController.progressViewIsNaughty = YES;
    _pageController.itemMargin         = 25;
    _pageController.menuHeight         = 30;
    _pageController.progressWidth      = 88;
//    _pageController.titlselect      = @"PingFangSC-Medium";
    _pageController.titleSizeNormal    = 14;
    _pageController.titleSizeSelected  = 14;
    _pageController.menuBGColor        = appWhiteColor;
    _pageController.titleColorNormal   = rgb(93, 93, 93);
    _pageController.titleColorSelected = appMainColor;
    _pageController.selectIndex = 1;
    _pageController.progressHeight     = 2;
    _pageController.progressViewCornerRadius = 1.5;
    _pageController.viewFrame = CGRectMake(0, 0, ksWidth, ksHeight-NavHeight );
    [contentView addSubview:self.pageController.view];

    UIView *split = [UIView creatView:frame(0, 30, ksWidth, 0.5) inView:contentView bgColor:appBottomLineColor];
}


#pragma mark - WMPageDelegate
//- (void)pageController:(WMPageController *)pageController willEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info{
//
//    _scrollView.scrollEnabled = NO;
//}
//
//- (void)pageController:(WMPageController *)pageController didEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info{
//    _scrollView.scrollEnabled = YES;
//}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
//    NSLog(@"%@",_trailPageArr);
    return 4;
}

- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    
    if (index == 0) {
        
        return [[MioWaitPayOrderVC alloc] init];
    }
    if (index == 1) {
        return [[MioWaitPayOrderVC alloc] init];
    }
    if (index == 2) {
        return [[MioWaitPayOrderVC alloc] init];
    }
    if (index== 3) {
        return [[MioWaitPayOrderVC alloc] init];
    }
    return [[UIViewController alloc] init];
    
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index{
    
    if (index == 0) {
        return @"待支付";
    }
    else if (index == 1) {
        return @"待完成";
    }
    else if (index == 2) {
        return @"已完成";
    }else if (index == 3){
        return @"退款";
    }
    return @"";
}

@end
