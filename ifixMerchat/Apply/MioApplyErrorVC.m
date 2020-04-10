//
//  MioApplyErrorVC.m
//  ifixMerchat
//
//  Created by Mimio on 2020/4/8.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import "MioApplyErrorVC.h"
#import <SVGA.h>
#import "MioApplyShopVC.h"
@interface MioApplyErrorVC ()
@property (nonatomic,copy) NSString * errorStr;
@end

@implementation MioApplyErrorVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = appWhiteColor;
    [self.navView.centerButton setTitle:@"审核结果" forState:UIControlStateNormal];
    [self requestInfo];
    
}

-(void)requestInfo{
    [MioGetReq(api_me, @{@"k":@"v"}) success:^(NSDictionary *result){
        NSDictionary *data = [result objectForKey:@"data"];
        self.errorStr = [data[@"shop_examines"][0] objectForKey:@"shop_examine_content"];
        [self creatUI];
    } failure:^(NSString *errorInfo) {}];
}


-(void)creatUI{
    SVGAPlayer *logoPlayer = [[SVGAPlayer alloc] initWithFrame:CGRectMake(ksWidth/2 - 125, NavHeight + 40, 250,200)];
    [self.view addSubview:logoPlayer];
    SVGAParser *parser = [[SVGAParser alloc] init];
    [parser parseWithNamed:@"不通过动画" inBundle:nil completionBlock:^(SVGAVideoEntity * _Nonnull videoItem) {
            if (videoItem != nil) {
                NSLog(@"请求完毕");
                logoPlayer.videoItem = videoItem;
                [logoPlayer startAnimation];
        }
    } failureBlock:^(NSError * _Nonnull error) {
         NSLog(@"%@",error);
     }];
    
    UILabel *tip1 = [UILabel creatLabel:frame(0, NavHeight + 270, ksWidth, 16) inView:self.view text:@"资料审核不通过，请修改后重新提交" color:appSubColor size:16 alignment:NSTextAlignmentCenter];
    tip1.font = BoldFont(16);
    
    UILabel *tip2 = [UILabel creatLabel:frame(ksWidth/2 - 115, tip1.bottom + 14, 230, 40) inView:self.view text:Str(@"原因：",self.errorStr) color:appSubColor size:13 alignment:NSTextAlignmentCenter];
    tip2.numberOfLines = 2;
    UILabel *tip3 = [UILabel creatLabel:frame(ksWidth/2 - 115, ksHeight - 55, 230, 40) inView:self.view text:@"客服电话：400-600-1602" color:appSubColor size:13 alignment:NSTextAlignmentCenter];
    
    UIButton *modifyBtn = [UIButton creatBtn:frame(ksWidth/2 - 90, ksHeight - 105, 180, 40) inView:self.view bgImage:@"button" action:^{
        MioApplyShopVC *vc = [[MioApplyShopVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [modifyBtn setTitle:@"修改资料" forState:UIControlStateNormal];
    
}

@end
