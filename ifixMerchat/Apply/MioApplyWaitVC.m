//
//  MioApplyResultVC.m
//  ifixMerchat
//
//  Created by Mimio on 2020/4/8.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import "MioApplyWaitVC.h"
#import <SVGA.h>
@interface MioApplyWaitVC ()
@property (nonatomic,copy) NSString * reviewState;
@end

@implementation MioApplyWaitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _reviewState = @"inState";
    self.view.backgroundColor = appWhiteColor;
    [self.navView.centerButton setTitle:@"审核结果" forState:UIControlStateNormal];
    [self creatUI];
}

-(void)creatUI{
    SVGAPlayer *logoPlayer = [[SVGAPlayer alloc] initWithFrame:CGRectMake(ksWidth/2 - 125, NavHeight + 40, 250,200)];
    [self.view addSubview:logoPlayer];
    SVGAParser *parser = [[SVGAParser alloc] init];
    [parser parseWithNamed:@"inreview" inBundle:nil completionBlock:^(SVGAVideoEntity * _Nonnull videoItem) {
            if (videoItem != nil) {
                NSLog(@"请求完毕");
                logoPlayer.videoItem = videoItem;
                [logoPlayer startAnimation];
        }
    } failureBlock:^(NSError * _Nonnull error) {
         NSLog(@"%@",error);
     }];
    
    UILabel *tip1 = [UILabel creatLabel:frame(0, NavHeight + 270, ksWidth, 16) inView:self.view text:@"资料已提交，等待审核" color:appSubColor size:16 alignment:NSTextAlignmentCenter];
    tip1.font = BoldFont(16);
    
    UILabel *tip2 = [UILabel creatLabel:frame(ksWidth/2 - 115, tip1.bottom + 14, 230, 40) inView:self.view text:@"我们将在1-3工作日内进行审核完毕，如有疑问拨打电话咨询" color:appSubColor size:13 alignment:NSTextAlignmentCenter];
    tip2.numberOfLines = 2;
    UILabel *tip3 = [UILabel creatLabel:frame(ksWidth/2 - 115, ksHeight - 55, 230, 40) inView:self.view text:@"客服电话：400-600-1602" color:appSubColor size:13 alignment:NSTextAlignmentCenter];
    


    
}

@end
