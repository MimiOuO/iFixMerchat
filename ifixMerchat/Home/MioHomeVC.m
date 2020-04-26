//
//  MioHomeVC.m
//  ifixMerchat
//
//  Created by Mimio on 2020/4/10.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import "MioHomeVC.h"
#import "MioApplyShopVC.h"
#import "MioApplyWaitVC.h"
#import "MioApplyErrorVC.h"
#import "MioSettingVC.h"
#import "MioAddProductVC.h"
#import "MioProductListVC.h"
#import "MioOrderDetailVC.h"
#import "MioOrderListVC.h"
@interface MioHomeVC ()
@property (nonatomic, strong) UILabel *followCountLab;
@property (nonatomic, strong) UILabel *fansCountLab;
@property (nonatomic, strong) UILabel *recentCountLab;
@property (nonatomic, strong) UILabel *footCountLab;

@property (nonatomic, strong) UILabel *waitPayCount;
@property (nonatomic, strong) UILabel *waitFinishCount;
@property (nonatomic, strong) UILabel *alreadyFinishCount;
@property (nonatomic, strong) UILabel *waitRefundCount;
@end

@implementation MioHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = appWhiteColor;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleLightContent;
    [self requestShop];

}

-(void)requestShop{
    goLogin
    [MioGetReq(api_me, @{@"k":@"v"}) success:^(NSDictionary *result){
        NSDictionary *data = [result objectForKey:@"data"];
        NSString *state = [NSString stringWithFormat:@"%@",[data  objectForKey:@"shop_status"]];
        if ([state isEqualToString:@"1"]) {
            MioBaseNavigationController *nav = [[MioBaseNavigationController alloc] initWithRootViewController:[MioApplyShopVC new]];
            nav.modalPresentationStyle = 0;
            [self presentViewController:nav animated:NO completion:nil];
        }
        
        else if ([state isEqualToString:@"3"]) {
            MioBaseNavigationController *nav = [[MioBaseNavigationController alloc] initWithRootViewController:[MioApplyErrorVC new]];
            nav.modalPresentationStyle = 0;
            [self presentViewController:nav animated:NO completion:nil];
        }
        else if ([state isEqualToString:@"4"]) {
            MioBaseNavigationController *nav = [[MioBaseNavigationController alloc] initWithRootViewController:[MioApplyWaitVC new]];
            nav.modalPresentationStyle = 0;
            [self presentViewController:nav animated:NO completion:nil];
        }
        else{
            [self creatUI];
        }
    } failure:^(NSString *errorInfo) {
        NSLog(@"%@",errorInfo);
    }];
}

-(void)creatUI{
    UIImageView *bgImg = [UIImageView creatImgView:frame(0, IPHONE_X ? 0 : -20, ksWidth, 333) inView:self.view image:@"store_bg" radius:0];
    UIImageView *logoImg = [UIImageView creatImgView:frame(18, StatusHeight + 22, 106, 106) inView:self.view image:@"logo_bg" radius:0];
    UILabel *shopName = [UILabel creatLabel:frame(120, StatusHeight + 44, ksWidth - 190, 17) inView:self.view text:@"京东方电脑维修" color:appWhiteColor size:17 alignment:NSTextAlignmentLeft];
    shopName.font = BoldFont(17);
    
    UIView *countView = [UIView creatView:frame(Margin, shopName.bottom + 56, ksWidth - 2* Margin, 80) inView:self.view bgColor:appClearColor];
    ViewRadius(countView, 8);
    _followCountLab = [UILabel creatLabel:frame(0, 24, countView.width/4, 17) inView:countView text:@"123" color:appWhiteColor size:14];
    _fansCountLab = [UILabel creatLabel:frame(countView.width/4, 24, countView.width/4, 17) inView:countView text:@"456" color:appWhiteColor size:14];
    _recentCountLab = [UILabel creatLabel:frame(countView.width/2, 24, countView.width/4, 17) inView:countView text:@"789" color:appWhiteColor size:14];
    _footCountLab = [UILabel creatLabel:frame(countView.width*3/4, 24, countView.width/4, 17) inView:countView text:@"123.00" color:appWhiteColor size:14];
    _followCountLab.font = [UIFont fontWithName:@"Futura" size:17];
    _fansCountLab.font = [UIFont fontWithName:@"Futura" size:17];
    _recentCountLab.font = [UIFont fontWithName:@"Futura" size:17];
    _footCountLab.font = [UIFont fontWithName:@"Futura" size:17];
    _followCountLab.textAlignment = NSTextAlignmentCenter;
    _fansCountLab.textAlignment = NSTextAlignmentCenter;
    _recentCountLab.textAlignment = NSTextAlignmentCenter;
    _footCountLab.textAlignment = NSTextAlignmentCenter;
    
    UILabel *followLab = [UILabel creatLabel:frame(0, 49, countView.width/4, 20) inView:countView text:@"今日订单" color:appWhiteColor size:12 alignment:NSTextAlignmentCenter];
    UILabel *fansLab = [UILabel creatLabel:frame(countView.width/4, 49, countView.width/4, 20) inView:countView text:@"今日访客" color:appWhiteColor size:12 alignment:NSTextAlignmentCenter];
    UILabel *rencentLab = [UILabel creatLabel:frame(countView.width/2, 49, countView.width/4, 20) inView:countView text:@"今日收藏" color:appWhiteColor size:12 alignment:NSTextAlignmentCenter];
    UILabel *footLab = [UILabel creatLabel:frame(countView.width*3/4, 49, countView.width/4, 20) inView:countView text:@"今日收入" color:appWhiteColor size:12 alignment:NSTextAlignmentCenter];
    
    UIButton *followBtn = [UIButton creatBtn:frame(0, 0, countView.width/4, 80) inView:countView bgColor:appClearColor title:@"" WithTag:0 target:self action:@selector(followCountClick)];
    UIButton *fansBtn = [UIButton creatBtn:frame(countView.width/4, 0, countView.width/4, 80) inView:countView bgColor:appClearColor title:@"" WithTag:0 target:self action:@selector(fansCountClick)];
    UIButton *recentBtn = [UIButton creatBtn:frame(countView.width/2, 0, countView.width/4, 80) inView:countView bgColor:appClearColor title:@"" WithTag:0 target:self action:@selector(recentClick)];
    UIButton *footBtn = [UIButton creatBtn:frame(countView.width*3/4, 0, countView.width/4, 80) inView:countView bgColor:appClearColor title:@"" WithTag:0 target:self action:@selector(footClick)];

    
    //待支付
    UIButton *waitPayBtn = [UIButton creatBtn:frame(18, StatusHeight + 209, ksWidth/2 - 24, 100) inView:self.view bgImage:@"store_card_bg" action:^{
        MioOrderListVC *vc = [[MioOrderListVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    UIImageView *waitPayImg = [UIImageView creatImgView:frame(waitPayBtn.left - 45, waitPayBtn.top - 41, waitPayBtn.width *1.55 , 190) inView:self.view image:@"store_card_shadow" radius:0];
//    waitPayImg.alpha = 0.5;
    [self.view sendSubviewToBack:waitPayImg];
    UIImageView *waitPayIcon = [UIImageView creatImgView:frame(12, 13, 31, 22) inView:waitPayBtn image:@"store_icon_pay" radius:0];
    UIImageView *waitPayArrow = [UIImageView creatImgView:frame(waitPayBtn.width - 28, 14, 14, 14) inView:waitPayBtn image:@"store_icon_arrow" radius:0];
    UILabel *waitPayLab = [UILabel creatLabel:frame(12, 50, 100, 14) inView:waitPayBtn text:@"待支付" color:appSubColor size:14 alignment:NSTextAlignmentLeft];waitPayLab.font = BoldFont(14);
    _waitPayCount = [UILabel creatLabel:frame(12, 70, 100, 19) inView:waitPayBtn text:@"68" color:rgb(252, 73, 73) size:19  alignment:NSTextAlignmentLeft];_waitPayCount.font = [UIFont fontWithName:@"Futura" size:19];

    
    //待完成
    UIButton *waitFinishBtn = [UIButton creatBtn:frame(ksWidth/2 + 6, StatusHeight + 209, ksWidth/2 - 24, 100) inView:self.view bgImage:@"store_card_bg" action:^{
        
    }];
    UIImageView *waitFinishImg = [UIImageView creatImgView:frame(waitFinishBtn.left - 45, waitFinishBtn.top - 41, waitFinishBtn.width *1.55 , 190) inView:self.view image:@"store_card_shadow" radius:0];
//    waitFinishImg.alpha = 0.5;
    [self.view sendSubviewToBack:waitFinishImg];
    UIImageView *waitFinishIcon = [UIImageView creatImgView:frame(12, 13, 31, 22) inView:waitFinishBtn image:@"store_icon_unfinished" radius:0];
    UIImageView *waitFinishArrow = [UIImageView creatImgView:frame(waitPayBtn.width - 28, 14, 14, 14) inView:waitFinishBtn image:@"store_icon_arrow" radius:0];
    UILabel *waitFinishLab = [UILabel creatLabel:frame(12, 50, 100, 14) inView:waitFinishBtn text:@"待支付" color:appSubColor size:14 alignment:NSTextAlignmentLeft];waitFinishLab.font = BoldFont(14);
    _waitFinishCount = [UILabel creatLabel:frame(12, 70, 100, 19) inView:waitFinishBtn text:@"68" color:rgb(252, 73, 73) size:19  alignment:NSTextAlignmentLeft];_waitFinishCount.font = [UIFont fontWithName:@"Futura" size:19];
    
    //已完成
    UIButton *alreadyFinishBtn = [UIButton creatBtn:frame(18, StatusHeight + 323, ksWidth/2 - 24, 100) inView:self.view bgImage:@"store_card_bg" action:^{
        
    }];
    UIImageView *alreadyFinishImg = [UIImageView creatImgView:frame(alreadyFinishBtn.left - 45, alreadyFinishBtn.top - 41, alreadyFinishBtn.width *1.55 , 190) inView:self.view image:@"store_card_shadow" radius:0];
//    alreadyFinishImg.alpha = 0.5;
    [self.view sendSubviewToBack:alreadyFinishImg];
    UIImageView *alreadyFinishIcon = [UIImageView creatImgView:frame(12, 13, 31, 22) inView:alreadyFinishBtn image:@"store_icon_complete" radius:0];
    UIImageView *alreadyFinishArrow = [UIImageView creatImgView:frame(waitPayBtn.width - 28, 14, 14, 14) inView:alreadyFinishBtn image:@"store_icon_arrow" radius:0];
    UILabel *alreadyFinishLab = [UILabel creatLabel:frame(12, 50, 100, 14) inView:alreadyFinishBtn text:@"待支付" color:appSubColor size:14 alignment:NSTextAlignmentLeft];alreadyFinishLab.font = BoldFont(14);
    _alreadyFinishCount = [UILabel creatLabel:frame(12, 70, 100, 19) inView:alreadyFinishBtn text:@"68" color:rgb(252, 73, 73) size:19  alignment:NSTextAlignmentLeft];_alreadyFinishCount.font = [UIFont fontWithName:@"Futura" size:19];
    
    
    //待退款
    UIButton *waitRefundBtn = [UIButton creatBtn:frame(ksWidth/2 + 6, StatusHeight +323, ksWidth/2 - 24, 100) inView:self.view bgImage:@"store_card_bg" action:^{
        
    }];
    UIImageView *waitRefundImg = [UIImageView creatImgView:frame(waitRefundBtn.left - 45, waitRefundBtn.top - 41, waitRefundBtn.width *1.55 , 190) inView:self.view image:@"store_card_shadow" radius:0];
//    waitRefundImg.alpha = 0.5;
    [self.view sendSubviewToBack:waitRefundImg];
    UIImageView *waitRefundIcon = [UIImageView creatImgView:frame(12, 13, 31, 22) inView:waitRefundBtn image:@"store_icon_refund" radius:0];
    UIImageView *waitRefundArrow = [UIImageView creatImgView:frame(waitPayBtn.width - 28, 14, 14, 14) inView:waitRefundBtn image:@"store_icon_arrow" radius:0];
    UILabel *waitRefundLab = [UILabel creatLabel:frame(12, 50, 100, 14) inView:waitRefundBtn text:@"待支付" color:appSubColor size:14 alignment:NSTextAlignmentLeft];waitRefundLab.font = BoldFont(14);
    _waitRefundCount = [UILabel creatLabel:frame(12, 70, 100, 19) inView:waitRefundBtn text:@"68" color:rgb(252, 73, 73) size:19  alignment:NSTextAlignmentLeft];_waitRefundCount.font = [UIFont fontWithName:@"Futura" size:19];
    self.waitRefundCount = [[UILabel alloc] init];
    [self.view sendSubviewToBack:bgImg];
    
    //评论
    UIButton *cmtBtn = [UIButton creatBtn:frame(0, 443 + StatusHeight, ksWidth, 46) inView:self.view bgColor:appClearColor title:@"" action:^{
        MioProductListVC *vc = [[MioProductListVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    UIImageView *cmtImg = [UIImageView creatImgView:frame(30, 11, 24, 24) inView:cmtBtn image:@"store_icon_comments" radius:0];
    UILabel *cmtLab = [UILabel creatLabel:frame(64, 0, 100, 46) inView:cmtBtn text:@"评论管理" color:appSubColor size:15 alignment:NSTextAlignmentLeft];
    UIImageView *arrow1 = [UIImageView creatImgView:frame(ksWidth - 30 - 7.5, 17, 7.5, 12) inView:cmtBtn image:@"rightArrow" radius:0];
    
    //商品
    UIButton *goodsBtn = [UIButton creatBtn:frame(0, cmtBtn.bottom , ksWidth, 46) inView:self.view bgColor:appClearColor title:@"" action:^{
        MioAddProductVC *vc = [[MioAddProductVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    UIImageView *goodsImg = [UIImageView creatImgView:frame(30, 11, 24, 24) inView:goodsBtn image:@"store_icon_goods" radius:0];
    UILabel *goodsLab = [UILabel creatLabel:frame(64, 0, 100, 46) inView:goodsBtn text:@"商品管理" color:appSubColor size:15 alignment:NSTextAlignmentLeft];
    UIImageView *arrow2 = [UIImageView creatImgView:frame(ksWidth - 30 - 7.5, 17, 7.5, 12) inView:goodsBtn image:@"rightArrow" radius:0];
    
    //设置
    UIButton *settingBtn = [UIButton creatBtn:frame(0, goodsBtn.bottom, ksWidth, 46) inView:self.view bgColor:appClearColor title:@"" action:^{
        MioSettingVC *vc = [[MioSettingVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    UIImageView *settingImg = [UIImageView creatImgView:frame(30, 11, 24, 24) inView:settingBtn image:@"store_icon_set" radius:0];
    UILabel *settingLab = [UILabel creatLabel:frame(64, 0, 100, 46) inView:settingBtn text:@"设置" color:appSubColor size:15 alignment:NSTextAlignmentLeft];
    UIImageView *arrow3 = [UIImageView creatImgView:frame(ksWidth - 30 - 7.5, 17, 7.5, 12) inView:settingBtn image:@"rightArrow" radius:0];

    
    UIButton *grabBtn = [UIButton creatBtn:frame(ksWidth - 62 -11, ksHeight - 130 - SafeBottomH, 62, 62) inView:self.view bgImage:@"store_button_order" action:^{
        MioOrderDetailVC *vc = [[MioOrderDetailVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

@end
