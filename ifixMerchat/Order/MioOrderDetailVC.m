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
    WEAKSELF;
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
        [weakSelf modifyPrice];
    }];
    modifyBtn.titleLabel.font = Font(10);
    [modifyBtn setTitleColor:appMainColor forState:UIControlStateNormal];
    modifyBtn.layer.borderColor = appMainColor.CGColor;
    modifyBtn.layer.borderWidth = 0.5;
    ViewRadius(modifyBtn, 2);
    
    if (![_model.zh_status isEqualToString:@"待支付"]) {
        priceLab.left = ksWidth - 34 - 100;
        modifyBtn.hidden = YES;
    }
    
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
        [weakSelf clickLine:gpsBtn];
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
    if ([_model.zh_status isEqualToString:@"待完成"] || [_model.zh_status isEqualToString:@"退款中"]) {
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
    

    
    if ([_model.zh_status isEqualToString:@"退款中"] || [_model.zh_status isEqualToString:@"已退款"] || [_model.zh_status isEqualToString:@"拒绝退款"]){
    
        UILabel *reasonLab = [UILabel creatLabel:frame(Margin, needView.bottom + 14, 100, 15) inView:scroll text:@"退款原因" color:appRedTextColor size:15 alignment:NSTextAlignmentLeft];
        reasonLab.font = BoldFont(15);
        
        UIView *refundView = [UIView creatView:frame(Margin, needView.bottom + 35, ksWidth - 2*Margin, 180) inView:scroll bgColor:appWhiteColor];
        refundView.layer.borderColor = appBottomLineColor.CGColor;
        refundView.layer.borderWidth = 0.5;
        ViewRadius(refundView, 4);

        UILabel *reason = [UILabel creatLabel:frame(10, 10, ksWidth - 44, 10) inView:refundView text:_model.refund_reason color:appSubColor size:14 alignment:NSTextAlignmentLeft];
        reason.height = [reason.text heightForFont:Font(14) width:ksWidth - 44];
        
        HXPhotoManager * refundShowManager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        refundShowManager.configuration.photoMaxNum = _model.refund_images_path.count;
    
        NSMutableArray *array = [NSMutableArray arrayWithArray:_model.refund_images_path];
        NSMutableArray *assets = @[].mutableCopy;
        for (NSString *url in array) {
            HXCustomAssetModel *asset = [HXCustomAssetModel assetWithNetworkImageURL:[NSURL URLWithString:url] selected:YES];
            [assets addObject:asset];
        }
        [refundShowManager addCustomAssetModel:assets];
        
        HXPhotoView * showView = [HXPhotoView photoManager:refundShowManager];
        showView.frame = frame(10, reason.bottom+ 8, ksWidth - 44, 80);
        showView.spacing = 9;
        showView.lineCount = 4;
        showView.hideDeleteButton = YES;
        [refundView addSubview:showView];
        
        refundView.height = reason.height + 28 + (_model.refund_images_path.count >4 ? 164 : 80);
        
        scroll.contentSize = CGSizeMake(ksWidth, userView.height + productView.height + orderView.height + needView.height + 5 * 14 + refundView.height + 35);
        
        if ([_model.zh_status isEqualToString:@"退款中"]) {
            scroll.contentSize = CGSizeMake(ksWidth, userView.height + productView.height + orderView.height + needView.height + 5 * 14 + refundView.height + 35 + 68);
            btnView.hidden = NO;
            
            UIButton *rejectBtn = [UIButton creatBtn:frame(12, 12, 131, 44) inView:btnView bgColor:appWhiteColor title:@"拒绝" action:^{
                [weakSelf rejectRefund];
            }];
            [rejectBtn setTitleColor:appRedTextColor forState:UIControlStateNormal];
            ViewRadius(rejectBtn, 4);
            rejectBtn.layer.borderColor = appRedTextColor.CGColor;
            rejectBtn.layer.borderWidth = 1;
            
            UIButton *agreeBtn = [UIButton creatBtn:frame(rejectBtn.right + 12, 12, ksWidth - 36 - 131, 44) inView:btnView bgImage:@"button" action:^{
                [weakSelf agreeRefund];
            }];
            [agreeBtn setTitle:@"同意退款" forState:UIControlStateNormal];
            [agreeBtn setTitleColor:appWhiteColor forState:UIControlStateNormal];
        }
    }
}

-(void)agreeRefund{
    WEAKSELF;
    UIAlertController *alertController = [[UIAlertController alloc] init];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];

    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"确认退款" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [MioPostReq(api_agreeRefund(_orderID), @{@"k":@"v"}) success:^(NSDictionary *result){
            [SVProgressHUD showSuccessWithStatus:@"已经同意退款"];
            
        } failure:^(NSString *errorInfo) {}];
    }];

    [alertController addAction:cancelAction];

    [alertController addAction:deleteAction];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alertController animated:YES completion:nil];
    });
}

-(void)rejectRefund{
 
     //提示框添加文本输入框
     UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"拒绝原因" message:@"*如果您拒绝用户的退款申请，用户可能会发起申诉，申诉过程中该订单的资金将会被冻结！" preferredStyle:UIAlertControllerStyleAlert];
     
     UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
         
         [MioPostReq(api_rejectRefund(_orderID), @{@"reject_reason":alert.textFields[0].text}) success:^(NSDictionary *result){
             [SVProgressHUD showSuccessWithStatus:@"已经同意退款"];
             
         } failure:^(NSString *errorInfo) {}];
         
                                        }];
     UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {}];
     [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
         textField.placeholder = @"拒绝原因，最多300个字";
     }];

     [alert addAction:okAction];
     [alert addAction:cancelAction];
     [self presentViewController:alert animated:YES completion:nil];
}

-(void)modifyPrice{
    //提示框添加文本输入框
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"请输入修改后价格" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        [MioPostReq(api_changePrice(_orderID), @{@"total_price":alert.textFields[0].text}) success:^(NSDictionary *result){
            [SVProgressHUD showSuccessWithStatus:@"修改成功！"];
            [self getOrder];
        } failure:^(NSString *errorInfo) {}];
        
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {}];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//        textField.placeholder = @"拒绝原因，最多300个字";
        textField.keyboardType = UIKeyboardTypeDecimalPad;
    }];

    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 导航


//查看线路
- (void)clickLine:(UIButton *)sender{
    NSMutableArray *mapArr = [NSMutableArray arrayWithCapacity:0];
    
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]){
        [mapArr addObject:@"百度地图"];
    }
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]){
        [mapArr addObject:@"高德地图"];
    }
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]]){
        [mapArr addObject:@"腾讯地图"];
    }
    
    if (mapArr.count == 1) {
        [self JumpToMap:mapArr[0]];
    }else if(mapArr.count > 0){
        UIAlertController *mapAlert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        for (NSString *mapName in mapArr) {
            UIAlertAction *Action = [UIAlertAction actionWithTitle:mapName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self JumpToMap:action.title];
            }];
            [mapAlert addAction:Action];
        }
        
        //取消
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [mapAlert addAction:cancelAction];
        
        [self presentViewController:mapAlert animated:YES completion:^{
            
        }];
    }else{
        //使用自带地图
        [self JumpToMap:@"苹果地图"];
    }
}

//选择地图
- (void)JumpToMap:(NSString *)mapName{
    if ([mapName isEqualToString:@"苹果地图"]) {
//        [self appleMap];
    }else if ([mapName isEqualToString:@"百度地图"]){
//        [self BaiduMap];
    }else if ([mapName isEqualToString:@"高德地图"]){
        [self iosMap];
    }else if ([mapName isEqualToString:@"腾讯地图"]){
//        [self qqMap];
    }
}

////百度地图
//- (void)BaiduMap{
//    float shopLat = 30.1526459161;
//    float shoplng = 106.1631561654;
//
//    NSString *urlString = [NSString stringWithFormat:@"baidumap://map/direction?origin=latlng:%f,%f|name:我的位置&mode=transit&coord_type= bd09ll",self.userLocation.location.coordinate.latitude, self.userLocation.location.coordinate.longitude];
//
//    if (shopLat != 0 && shoplng != 0) {
//        urlString = [NSString stringWithFormat:@"%@&destination=latlng:%f,%f|name:%@", urlString, shopLat, shoplng, @"目标地址,你可以自行替换"];
//    }else{
//        urlString = [NSString stringWithFormat:@"%@&destination=%@|name:%@",urlString, _orderModel.addressStr,_orderModel.addressStr];
//    }
//
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{} completionHandler:^(BOOL success) {
//
//    }];
//}

//高德地图
- (void)iosMap{
    CLLocationCoordinate2D gcj02Coord = CLLocationCoordinate2DMake(30.1526459161,106.1631561654);
    
    float shopLat = gcj02Coord.latitude;
    float shoplng = gcj02Coord.longitude;
    
    NSString *urlString = [NSString stringWithFormat:@"iosamap://path?sourceApplication=jikexiue&backScheme=jkxe&sname=我的位置&dname=我的位置&dlat=%f&dlon=%f&dev=1&t=1",shopLat, shoplng];
    
    if (shopLat != 0 && shoplng != 0) {
        urlString = [NSString stringWithFormat:@"%@&dlat=%f&dlon=%f&dname=%@", urlString, shopLat, shoplng ,@"城市花园"];
    }else{
        urlString = [NSString stringWithFormat:@"%@&dname=%@",urlString, @"城市花园"];
    }
    
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{} completionHandler:^(BOOL success) {
        
    }];
}

//- (void)qqMap{
//
//    CLLocationCoordinate2D gcj02Coord = CLLocationCoordinate2DMake(30.1526459161, 106.1631561654);
//
//    float shopLat = gcj02Coord.latitude;
//    float shoplng = gcj02Coord.longitude;
//
//    NSString *urlString = [NSString stringWithFormat:@"qqmap://map/routeplan?type=bus&fromcoord=%f,%f&from=我的位置&referer=jikexiu",self.userLocation.location.coordinate.latitude, self.userLocation.location.coordinate.longitude];
//
//    urlString = [NSString stringWithFormat:@"%@&tocoord=%f,%f&to=%@",urlString, shopLat, shoplng, _orderModel.addressStr];
//
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{} completionHandler:^(BOOL success) {
//
//    }];
//}
//
////苹果原生地图
//- (void)appleMap{
//    CLLocationCoordinate2D desCoordinate = CLLocationCoordinate2DMake(30.1526459161, 106.1631561654);
//
//    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
//    currentLocation.name = @"我的位置";
//    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:desCoordinate addressDictionary:nil]];
//    toLocation.name = [NSString stringWithFormat:@"%@",_orderModel.addressStr];
//
//    [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
//                   launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeTransit,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
//}


@end
