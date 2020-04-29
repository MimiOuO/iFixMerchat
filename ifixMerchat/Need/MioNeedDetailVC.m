//
//  MioNeedDetailVC.m
//  ifixMerchat
//
//  Created by Mimio on 2020/4/28.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import "MioNeedDetailVC.h"
#import "MioNeedModel.h"
#import <HXPhotoPicker.h>
#import <LEEAlert.h>
@interface MioNeedDetailVC ()
@property (nonatomic, strong) UIScrollView *scroll;
@end

@implementation MioNeedDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navView.leftButton setImage:backArrowIcon forState:UIControlStateNormal];
    [self.navView.centerButton setTitle:@"需求详情" forState:UIControlStateNormal];
    [self getOrder];
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NavHeight, ksWidth, ksHeight - NavHeight)];
    _scroll.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scroll];
    _scroll.contentSize = CGSizeMake(ksWidth, ksHeight - NavHeight);
}

-(void)getOrder{
    [MioGetReq(api_getNeed(_needId), @{@"k":@"v"}) success:^(NSDictionary *result){
        NSDictionary *data = [result objectForKey:@"data"];
        self.model = [MioNeedModel mj_objectWithKeyValues:data];
        [self creatUI];
    } failure:^(NSString *errorInfo) {}];
}

-(void)creatUI{
    WEAKSELF;

    
    //用户
    UIView *userView = [UIView creatView:frame(Margin, Margin, ksWidth - 2*Margin, 50) inView:_scroll bgColor:appWhiteColor];
    userView.layer.borderColor = appBottomLineColor.CGColor;
    userView.layer.borderWidth = 0.5;
    ViewRadius(userView, 4);
    
    UIImageView *avatar = [UIImageView creatImgView:frame(10, 10, 30, 30) inView:userView image:@"icon" radius:2];
    [avatar sd_setImageWithURL:Url(_model.customer.customer_face) placeholderImage:image(@"icon")];
    UILabel *nickName = [UILabel creatLabel:frame(48, 18, 200,14) inView:userView text:_model.customer.customer_nickname color:appSubColor size:14 alignment:NSTextAlignmentLeft];
    nickName.width = [nickName.text widthForFont:Font(14)];
    UIButton *messageBtn = [UIButton creatBtn:frame(nickName.right + 6, 17, 18.6, 16.6) inView:userView bgImage:@"order_icon_chat" action:^{
        
    }];
    UILabel *state = [UILabel creatLabel:frame( 200 - 34, nickName.top, ksWidth - 200, 14) inView:userView text:_model.zh_status color:appRedTextColor size:13 alignment:NSTextAlignmentRight];
    
    //订单
    UIView *orderView = [UIView creatView:frame(Margin, userView.bottom + 10, ksWidth - 2*Margin, 94) inView:_scroll bgColor:appWhiteColor];
    orderView.layer.borderColor = appBottomLineColor.CGColor;
    orderView.layer.borderWidth = 0.5;
    ViewRadius(orderView, 4);
    

    UILabel *serviceNameLab = [UILabel creatLabel:frame(10, 12, 70, 14) inView:orderView text:@"服务对象" color:appSubColor size:14 alignment:NSTextAlignmentLeft];
    UILabel *serviceTimeLab = [UILabel creatLabel:frame(10,  serviceNameLab.bottom + 14, 70, 14) inView:orderView text:@"服务时间" color:appSubColor size:14 alignment:NSTextAlignmentLeft];
    UILabel *serviceAdresssLab = [UILabel creatLabel:frame(10,  serviceTimeLab.bottom + 14, 70, 14) inView:orderView text:@"服务地址" color:appSubColor size:14 alignment:NSTextAlignmentLeft];


    UILabel *serviceName = [UILabel creatLabel:frame( 200 - 34 - 48, serviceNameLab.top, ksWidth - 200, 14) inView:orderView text:_model.address_info.customer_address_username color:appGrayTextColor size:13 alignment:NSTextAlignmentRight];
    UILabel *serviceTime = [UILabel creatLabel:frame( 200 - 34, serviceTimeLab.top, ksWidth - 200, 14) inView:orderView text:_model.serviceTime color:appGrayTextColor size:13 alignment:NSTextAlignmentRight];
    NSString *adress = Str(_model.address_info.customer_address_area,_model.address_info.customer_address_full);
    UILabel *serviceAdresss = [UILabel creatLabel:frame( 200 - 34 -48, serviceAdresssLab.top, ksWidth - 200, 14) inView:orderView text:adress color:appGrayTextColor size:13 alignment:NSTextAlignmentRight];
    if ([adress widthForFont:Font(13)] > ksWidth - 200) {
        serviceAdresss.height = 32;
        serviceAdresss.numberOfLines = 2;
        orderView.height = 112;
    }
    
    UIButton *callBtn = [UIButton creatBtn:frame(ksWidth - 34 - 40,serviceName.top - 1 , 40, 16) inView:orderView bgColor:appWhiteColor title:@"拨打" action:^{
        
    }];
    callBtn.titleLabel.font = Font(10);
    [callBtn setTitleColor:appMainColor forState:UIControlStateNormal];
    callBtn.layer.borderColor = appMainColor.CGColor;
    callBtn.layer.borderWidth = 0.5;
    ViewRadius(callBtn, 2);
    
    UIButton *gpsBtn = [UIButton creatBtn:frame(ksWidth - 34 - 40,serviceAdresss.top - 1, 40, 16) inView:orderView bgColor:appWhiteColor title:@"导航" action:^{
//        [weakSelf clickLine:gpsBtn];
    }];
    gpsBtn.titleLabel.font = Font(10);
    [gpsBtn setTitleColor:appMainColor forState:UIControlStateNormal];
    gpsBtn.layer.borderColor = appMainColor.CGColor;
    gpsBtn.layer.borderWidth = 0.5;
    ViewRadius(gpsBtn, 2);
    
    //故障描述
     UIView *needView = [UIView creatView:frame(Margin, orderView.bottom + 10, ksWidth - 2*Margin, 180) inView:_scroll bgColor:appWhiteColor];
     needView.layer.borderColor = appBottomLineColor.CGColor;
     needView.layer.borderWidth = 0.5;
     ViewRadius(needView, 4);
     
     
     UILabel *needTypeLab = [UILabel creatLabel:frame(10, 12, 70, 14) inView:needView text:@"故障类型" color:appSubColor size:14 alignment:NSTextAlignmentLeft];
     UILabel *needDetailLab = [UILabel creatLabel:frame(10, needTypeLab.bottom + 14, 70, 14) inView:needView text:@"故障描述" color:appSubColor size:14 alignment:NSTextAlignmentLeft];
     UILabel *type = [UILabel creatLabel:frame( 200 - 34, needTypeLab.top, ksWidth - 200, 14) inView:needView text:_model.need_category color:appGrayTextColor size:13 alignment:NSTextAlignmentRight];
     UILabel *needDescripe = [UILabel creatLabel:frame( 152 - 34, needDetailLab.top, ksWidth - 152, 14) inView:needView text:_model.need_description color:appGrayTextColor size:13 alignment:NSTextAlignmentRight];
     
     needView.height = 70;
     if ([_model.need_description widthForFont:Font(13)] > ksWidth - 152) {
         needDescripe.height = [needDescripe.text heightForFont:Font(13) width:(ksWidth - 152)] +5;
         needDescripe.numberOfLines = 0;
         
         needView.height = 56 + needDescripe.height;
     }
     
     if (_model.need_images_path) {
         UILabel *needPicLab = [UILabel creatLabel:frame(10, needDescripe.bottom + 14, 70, 14) inView:needView text:@"故障图片" color:appSubColor size:14 alignment:NSTextAlignmentLeft];
         
         HXPhotoManager * showManager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
         showManager.configuration.photoMaxNum = _model.need_images_path.count;
     
         NSMutableArray *array = [NSMutableArray arrayWithArray:_model.need_images_path];
         NSMutableArray *assets = @[].mutableCopy;
         for (NSString *url in array) {
             HXCustomAssetModel *asset = [HXCustomAssetModel assetWithNetworkImageURL:[NSURL URLWithString:url] selected:YES];
             [assets addObject:asset];
         }
         [showManager addCustomAssetModel:assets];
         
         HXPhotoView * showView = [HXPhotoView photoManager:showManager];
         showView.frame = frame(10, needPicLab.bottom+ 8, ksWidth - 44, 80);
         showView.spacing = 9;
         showView.lineCount = 4;
         showView.hideDeleteButton = YES;
         showView.delegate = self;
         [needView addSubview:showView];
         
         needView.height = 170 + needDescripe.height;
     }
    if ([_model.zh_status isEqualToString:@"派单中"]) {
        UIView *btnView = [UIView creatView:frame(0, ksHeight - 68 - SafeBottomH, ksWidth, 68 + SafeBottomH) inView:self.view bgColor:appWhiteColor];
        UIButton *completeBtn = [UIButton creatBtn:frame(12, 12, ksWidth - 24, 44) inView:btnView bgImage:@"button" action:^{
            [weakSelf grabOrder];
        }];
        [completeBtn setTitle:@"立即抢单" forState:UIControlStateNormal];
        [completeBtn setTitleColor:appWhiteColor forState:UIControlStateNormal];
    }
    

}

-(void)grabOrder{
    __block UITextField *tf = nil;
    __block NSString *needId = _needId;
    [LEEAlert alert].config
    .LeeTitle(@"请输入订单价格")         // 添加一个标题 (默认样式)
//    .LeeContent(@"内容")        // 添加一个标题 (默认样式)
    .LeeAddTextField(^(UITextField *textField) {    // 添加一个输入框 (自定义设置)
        // textfield设置Block
        textField.keyboardType = UIKeyboardTypeDecimalPad;
        [textField becomeFirstResponder];
        tf = textField; //赋值
    })
//    .LeeCustomView(view)    // 添加自定义的视图

    .LeeDestructiveAction(@"立即抢单", ^{    // 添加一个销毁类型的Action (默认样式 字体颜色为红色)
        // 点击事件Block
        NSLog(@"%@",tf.text);
        [MioPostReq(api_grabNeed(needId), @{@"total_price":tf.text}) success:^(NSDictionary *result){
            NSDictionary *data = [result objectForKey:@"data"];
            [SVProgressHUD showSuccessWithStatus:@"抢单成功"];
            [_scroll removeAllSubviews];
            [self getOrder];
        } failure:^(NSString *errorInfo) {}];
        
    })
    .leeShouldActionClickClose(^(NSInteger index){
        // 是否可以关闭回调, 当即将关闭时会被调用 根据返回值决定是否执行关闭处理
        // 这里演示了与输入框非空校验结合的例子
        BOOL result = ![tf.text isEqualToString:@""];
        result = index == 0 ? result : YES;
        return result;
    })
    .LeeCancelAction(@"取消", ^{    // 添加一个取消类型的Action (默认样式 alert中为粗体 actionsheet中为最下方独立)
        // 点击事件Block
    })
    .LeeShow(); // 最后调用Show开始显示
}
@end
