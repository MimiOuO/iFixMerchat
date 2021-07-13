//
//  MioNeedVC.m
//  ifixMerchat
//
//  Created by Mimio on 2020/4/28.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import "MioNeedVC.h"
#import <WMPageController.h>
#import "MioNeedListVC.h"
#import "MioWaitPayOrderVC.h"
@interface MioNeedVC ()<WMPageControllerDelegate,WMPageControllerDataSource>
@property (nonatomic, strong) WMPageController *pageController;

@end

@implementation MioNeedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navView.leftButton setImage:backArrowIcon forState:UIControlStateNormal];
    [self.navView.centerButton setTitle:@"需求列表" forState:UIControlStateNormal];
    self.navView.split.hidden = YES;
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
//    _pageController.itemMargin         = 25;
    _pageController.menuHeight         = 30;
    _pageController.progressWidth      = 150;
//    _pageController.titlselect      = @"PingFangSC-Medium";
    _pageController.titleSizeNormal    = 14;
    _pageController.titleSizeSelected  = 14;
    _pageController.menuBGColor        = appWhiteColor;
    _pageController.titleColorNormal   = rgb(93, 93, 93);
    _pageController.titleColorSelected = appMainColor;
    _pageController.selectIndex = 0;
    _pageController.progressHeight     = 2;
    _pageController.progressViewCornerRadius = 1.5;
    _pageController.viewFrame = CGRectMake(0, 0, ksWidth, ksHeight-NavHeight );
    [contentView addSubview:self.pageController.view];

    UIView *split = [UIView creatView:frame(0, 30, ksWidth, 0.5) inView:contentView bgColor:appBottomLineColor];
}


#pragma mark - WMPageDelegate
- (void)pageController:(WMPageController *)pageController willEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info{

//    _scrollView.scrollEnabled = NO;
}

- (void)pageController:(WMPageController *)pageController didEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info{
//    _scrollView.scrollEnabled = YES;
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
//    NSLog(@"%@",_trailPageArr);
    return 2;
}

- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    
    if (index == 0) {
        
        return [[MioNeedListVC alloc] init];
    }
    if (index == 1) {
        return [[MioNeedListVC alloc] init];
    }
    return [[UIViewController alloc] init];
    
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index{
    
    if (index == 0) {
        return @"派单中";
    }
    else if (index == 1) {
        return @"已接单";
    }

    return @"";
}

@end

