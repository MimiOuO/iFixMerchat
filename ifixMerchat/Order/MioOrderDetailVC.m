//
//  MioOrderDetailVC.m
//  ifixMerchat
//
//  Created by Mimio on 2020/4/16.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import "MioOrderDetailVC.h"
#import "MioOrderModel.h"
#import <HXPhotoPicker.h>
@interface MioOrderDetailVC ()
@property (nonatomic, strong) MioOrderModel *model;
@end

@implementation MioOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navView.leftButton setImage:backArrowIcon forState:UIControlStateNormal];
    [self.navView.centerButton setTitle:@"订单详情" forState:UIControlStateNormal];
    [self getOrder];
    
}

-(void)getOrder{
    [MioGetReq(api_getOrder(_orderID), @{@"k":@"v"}) success:^(NSDictionary *result){
        NSDictionary *data = [result objectForKey:@"data"];
        self.model = [MioOrderModel mj_objectWithKeyValues:data];
        [self creatUI];
    } failure:^(NSString *errorInfo) {}];
}

-(void)creatUI{
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NavHeight, ksWidth, ksHeight - NavHeight)];
    scroll.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scroll];
    scroll.contentSize = CGSizeMake(ksWidth, 1000);
    
    //用户
    UIView *userView = [UIView creatView:frame(Margin, Margin, ksWidth - 2*Margin, 50) inView:scroll bgColor:appWhiteColor];
    userView.layer.borderColor = appBottomLineColor.CGColor;
    userView.layer.borderWidth = 0.5;
    ViewRadius(userView, 4);
    
    UIImageView *avatar = [UIImageView creatImgView:frame(10, 10, 30, 30) inView:userView image:@"icon" radius:2];
    [avatar sd_setImageWithURL:Url(_model.customer.customer_face) placeholderImage:image(@"icon")];
    UILabel *nickName = [UILabel creatLabel:frame(48, 18, 200,14) inView:userView text:_model.customer.customer_nickname color:appSubColor size:14 alignment:NSTextAlignmentLeft];
    UIButton *messageBtn = [UIButton creatBtn:frame(ksWidth - 38 - 24, 17, 18.6, 16.6) inView:userView bgImage:@"order_icon_chat" action:^{
        
    }];
    
    //商品
    UIView *productView = [UIView creatView:frame(Margin, userView.bottom + 10, ksWidth - 2*Margin, 90) inView:scroll bgColor:appWhiteColor];
    productView.layer.borderColor = appBottomLineColor.CGColor;
    productView.layer.borderWidth = 0.5;
    ViewRadius(productView, 4);
    
    UIImageView *productPic = [UIImageView creatImgView:frame(10, 10, 70, 70) inView:productView image:@"icon" radius:4];
    [productPic sd_setImageWithURL:Url(_model.product_images[0]) placeholderImage:image(@"icon")];
    UILabel *need_category = [UILabel creatLabel:frame(0, 0, 56, 14) inView:productPic text:_model.need_category color:appWhiteColor size:8 alignment:NSTextAlignmentCenter];
    need_category.backgroundColor = appMainColor;
    UILabel *productName = [UILabel creatLabel:frame(productPic.right + 8, 16, ksWidth - 120, 14) inView:productView text:_model.product_title color:appSubColor size:14 alignment:NSTextAlignmentLeft];
    UILabel *typeName = [UILabel creatLabel:frame(productPic.right + 8, 37, 100, 11) inView:productView text:_model.sku color:appGrayTextColor size:11 alignment:NSTextAlignmentLeft];
    UILabel *numLab = [UILabel creatLabel:frame(ksWidth - 34 - 30, 37, 30, 11) inView:productView text:Str(@"x",_model.num) color:appSubColor size:11 alignment:NSTextAlignmentRight];
    UILabel *priceLab = [UILabel creatLabel:frame(ksWidth - 80 - 100, 58, 100, 16) inView:productView text:@"" color:appMainColor size:16 alignment:NSTextAlignmentRight];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:Str(@"￥",_model.total_price)];
    [AttributedStr addAttribute:NSFontAttributeName value:BoldFont(10) range:NSMakeRange(0, 1)];
    priceLab.attributedText = AttributedStr;
    UIButton *modifyBtn = [UIButton creatBtn:frame(ksWidth - 34 - 40, 58, 40, 16) inView:productView bgColor:appWhiteColor title:@"修改" action:^{
        
    }];
    modifyBtn.titleLabel.font = Font(10);
    [modifyBtn setTitleColor:appMainColor forState:UIControlStateNormal];
    modifyBtn.layer.borderColor = appMainColor.CGColor;
    modifyBtn.layer.borderWidth = 0.5;
    ViewRadius(modifyBtn, 2);

    
    //订单
    UIView *orderView = [UIView creatView:frame(Margin, productView.bottom + 10, ksWidth - 2*Margin, 180) inView:scroll bgColor:appWhiteColor];
    orderView.layer.borderColor = appBottomLineColor.CGColor;
    orderView.layer.borderWidth = 0.5;
    ViewRadius(orderView, 4);
    
    UILabel *stateLab = [UILabel creatLabel:frame(10, 12, 70, 14) inView:orderView text:@"订单状态" color:appSubColor size:14 alignment:NSTextAlignmentLeft];
    UILabel *noLab = [UILabel creatLabel:frame(10, stateLab.bottom + 14, 70, 14) inView:orderView text:@"订单编号" color:appSubColor size:14 alignment:NSTextAlignmentLeft];
    UILabel *orderTimeLab = [UILabel creatLabel:frame(10,  noLab.bottom + 14, 70, 14) inView:orderView text:@"下单时间" color:appSubColor size:14 alignment:NSTextAlignmentLeft];
    UILabel *serviceNameLab = [UILabel creatLabel:frame(10,  orderTimeLab.bottom + 14, 70, 14) inView:orderView text:@"服务对象" color:appSubColor size:14 alignment:NSTextAlignmentLeft];
    UILabel *serviceTimeLab = [UILabel creatLabel:frame(10,  serviceNameLab.bottom + 14, 70, 14) inView:orderView text:@"服务时间" color:appSubColor size:14 alignment:NSTextAlignmentLeft];
    UILabel *serviceAdresssLab = [UILabel creatLabel:frame(10,  serviceTimeLab.bottom + 14, 70, 14) inView:orderView text:@"服务地址" color:appSubColor size:14 alignment:NSTextAlignmentLeft];

    UILabel *state = [UILabel creatLabel:frame( 200 - 34, stateLab.top, ksWidth - 200, 14) inView:orderView text:_model.zh_status color:appMainColor size:13 alignment:NSTextAlignmentRight];

    UILabel *no = [UILabel creatLabel:frame( 200 - 34, noLab.top, ksWidth - 200, 14) inView:orderView text:_model.no color:appGrayTextColor size:13 alignment:NSTextAlignmentRight];
    UILabel *orderTime = [UILabel creatLabel:frame( 200 - 34, orderTimeLab.top, ksWidth - 200, 14) inView:orderView text:_model.created_at color:appGrayTextColor size:13 alignment:NSTextAlignmentRight];
    UILabel *serviceName = [UILabel creatLabel:frame( 200 - 34 - 48, serviceNameLab.top, ksWidth - 200, 14) inView:orderView text:_model.address_info.customer_address_username color:appGrayTextColor size:13 alignment:NSTextAlignmentRight];
    UILabel *serviceTime = [UILabel creatLabel:frame( 200 - 34, serviceTimeLab.top, ksWidth - 200, 14) inView:orderView text:_model.serviceTime color:appGrayTextColor size:13 alignment:NSTextAlignmentRight];
    NSString *adress = Str(_model.address_info.customer_address_area,_model.address_info.customer_address_full);
    UILabel *serviceAdresss = [UILabel creatLabel:frame( 200 - 34 -48, serviceAdresssLab.top, ksWidth - 200, 14) inView:orderView text:adress color:appGrayTextColor size:13 alignment:NSTextAlignmentRight];
    if ([adress widthForFont:Font(13)] > ksWidth - 200) {
        serviceAdresss.height = 32;
        serviceAdresss.numberOfLines = 2;
        orderView.height = 198;
    }
    
    UIButton *callBtn = [UIButton creatBtn:frame(ksWidth - 34 - 40,serviceName.top - 1 , 40, 16) inView:orderView bgColor:appWhiteColor title:@"拨打" action:^{
        
    }];
    callBtn.titleLabel.font = Font(10);
    [callBtn setTitleColor:appMainColor forState:UIControlStateNormal];
    callBtn.layer.borderColor = appMainColor.CGColor;
    callBtn.layer.borderWidth = 0.5;
    ViewRadius(callBtn, 2);
    
    UIButton *gpsBtn = [UIButton creatBtn:frame(ksWidth - 34 - 40,serviceAdresss.top - 1, 40, 16) inView:orderView bgColor:appWhiteColor title:@"导航" action:^{
        
    }];
    gpsBtn.titleLabel.font = Font(10);
    [gpsBtn setTitleColor:appMainColor forState:UIControlStateNormal];
    gpsBtn.layer.borderColor = appMainColor.CGColor;
    gpsBtn.layer.borderWidth = 0.5;
    ViewRadius(gpsBtn, 2);
    
    //故障描述
    UIView *needView = [UIView creatView:frame(Margin, orderView.bottom + 10, ksWidth - 2*Margin, 180) inView:scroll bgColor:appWhiteColor];
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
    
    UIView *btnView = [UIView creatView:frame(0, ksHeight - 68 - SafeBottomH, ksWidth, 68 + SafeBottomH) inView:self.view bgColor:appWhiteColor];
    btnView.hidden = YES;
    
    scroll.contentSize = CGSizeMake(ksWidth, userView.height + productView.height + orderView.height + needView.height + 5 * 14 );
    if ([_model.zh_status isEqualToString:@"已完成"] || [_model.zh_status isEqualToString:@"退款中"]) {
        scroll.contentSize = CGSizeMake(ksWidth, userView.height + productView.height + orderView.height + needView.height + 5 * 14 + 68);
        btnView.hidden = NO;
    }
    
    if ([_model.zh_status isEqualToString:@"待完成"]) {
        scroll.contentSize = CGSizeMake(ksWidth, userView.height + productView.height + orderView.height + needView.height + 5 * 14 + 68);
        btnView.hidden = NO;
        UIButton *completeBtn = [UIButton creatBtn:frame(12, 12, ksWidth - 24, 44) inView:btnView bgImage:@"button" action:^{
            
        }];
        [completeBtn setTitle:@"完成服务" forState:UIControlStateNormal];
        [completeBtn setTitleColor:appWhiteColor forState:UIControlStateNormal];
    }
    
    if ([_model.zh_status isEqualToString:@"退款中"]) {
        scroll.contentSize = CGSizeMake(ksWidth, userView.height + productView.height + orderView.height + needView.height + 5 * 14 + 68);
        btnView.hidden = NO;
        
        UIButton *rejectBtn = [UIButton creatBtn:frame(12, 12, 131, 44) inView:btnView bgColor:appWhiteColor title:@"拒绝" action:^{
            
        }];
        [rejectBtn setTitleColor:appRedTextColor forState:UIControlStateNormal];
        ViewRadius(rejectBtn, 4);
        rejectBtn.layer.borderColor = appRedTextColor.CGColor;
        rejectBtn.layer.borderWidth = 1;
        
        UIButton *completeBtn = [UIButton creatBtn:frame(rejectBtn.right + 12, 12, ksWidth - 36 - 131, 44) inView:btnView bgImage:@"button" action:^{
            
        }];
        [completeBtn setTitle:@"同意退款" forState:UIControlStateNormal];
        [completeBtn setTitleColor:appWhiteColor forState:UIControlStateNormal];
    }
    
}



@end
