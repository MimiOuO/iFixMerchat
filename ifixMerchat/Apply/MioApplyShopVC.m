//
//  MioApplyShopVC.m
//  ifixMerchat
//
//  Created by Mimio on 2020/4/1.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import "MioApplyShopVC.h"
#import <HXPhotoPicker.h>
#import <QiniuSDK.h>
#import <FSTextView.h>
#import "MyUploadManager.h"
#import "MamapVC.h"
#import "MioShopTypeView.h"
#import "MioAFPutRequest.h"
@interface MioApplyShopVC ()<HXPhotoViewControllerDelegate,HXPhotoViewDelegate,AMapDelegate>

@property (nonatomic, strong) UITextField *shopName;
@property (nonatomic, strong) UITextField *shopType;
@property (nonatomic, strong) UITextField *phone;
@property (nonatomic, strong) UITextField *adress;
@property (nonatomic, strong) UITextField *detailAdress;
@property (nonatomic, strong) UILabel *distance;
@property (nonatomic, strong) NSMutableArray *locationArr;
@property (nonatomic, strong) FSTextView *intro;
@property (nonatomic, strong) NSArray *shopDisplayArr;
@property (nonatomic, strong) UITextField *realName;
@property (nonatomic, strong) UITextField *idcardNumber;
@property (nonatomic, strong) NSString *idFrontKey;
@property (nonatomic, strong) NSString *idBackKey;

//上传图片
@property (nonatomic, strong) UIImageView *avatar;
@property (strong, nonatomic) HXPhotoManager *oneManager;
@property (nonatomic, strong) NSString *key;//店铺照片文件名

@property (weak, nonatomic) HXPhotoView *photoView;
@property (strong, nonatomic) HXPhotoManager *twoManager;
@property (nonatomic, strong) NSMutableArray *shopShowsImgArr;
@property (nonatomic, strong) NSMutableArray *shopShowsKeyArr;

@property (nonatomic, strong) NSArray *allPhotoKeysArr;

@property (nonatomic, strong) UIImageView *frontPhoto;
@property (strong, nonatomic) HXPhotoManager *threeManager;
@property (nonatomic, strong) UIImageView *backPhoto;
@property (strong, nonatomic) HXPhotoManager *fourManager;

@property (nonatomic, strong) NSString *qiniuToken;
@end

@implementation MioApplyShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    WEAKSELF;
    [self.navView.leftButton setImage:backArrowIcon forState:UIControlStateNormal];
    
    [self.navView.centerButton setTitle:@"店铺资料" forState:UIControlStateNormal];
    [self.navView.centerButton setTitleColor:appWhiteColor forState:UIControlStateNormal];
    [self.navView.rightButton setTitle:@"提交" forState:UIControlStateNormal];
    [self.navView.rightButton setTitleColor:appWhiteColor forState:UIControlStateNormal];
    self.navView.split.hidden = YES;
    self.navView.mainView.backgroundColor = appMainColor;
    self.navView.rightButtonBlock = ^{
        [weakSelf uploadAllPhoto];
    };
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    
    self.view.backgroundColor = appMainColor;
    
    _shopShowsImgArr = [[NSMutableArray alloc] init];
    _shopShowsKeyArr = [[NSMutableArray alloc] init];
    _locationArr = [[NSMutableArray alloc] init];
    [self getQiniuToken];
    [self creatUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleLightContent;
}

//禁用滑动返回
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    id traget = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:traget action:nil];
    [self.view addGestureRecognizer:pan];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    if (@available(iOS 13.0, *)) {
        [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDarkContent;
    } else {
        // Fallback on earlier versions
        [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    }
}


-(void)creatUI{
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NavHeight, ksWidth, ksHeight - NavHeight)];
    scroll.contentSize = CGSizeMake(ksWidth, 823);
    [self.view addSubview:scroll];
    
    UIView *bgview = [UIView creatView:frame(0, -0, ksWidth, 823) inView:scroll bgColor:appClearColor];
    UIImageView *bgimage = [UIImageView creatImgView:frame(0, 0, ksWidth, 960) inView:bgview image:@"apply_bg" radius:0];
    bgimage.contentMode = UIViewContentModeScaleToFill;
    UIImageView *logobg = [UIImageView creatImgView:frame(ksWidth/2 - 53, 11, 106, 106) inView:bgview image:@"logo_bg" radius:0];
    
    
    _avatar = [UIImageView creatImgView:frame(ksWidth/2 - 32, 22, 64, 64) inView:bgview image:@"logo_default" radius:4];
    
    [_avatar whenTapped:^{
        [self selectAvatar];
    }];
    _shopName = [[UITextField alloc] initWithFrame:CGRectMake(50, _avatar.bottom + 13, ksWidth - 100, 15)];
    _shopName.textAlignment = NSTextAlignmentCenter;
    _shopName.textColor = appSubColor;
    _shopName.font = Font(15);
    _shopName.placeholder = @"请输入店铺名称";
    [bgview addSubview:_shopName];
    
//    UILabel *shopTypeLab = [UILabel creatLabel:frame(36, 144, 60, 14) inView:bgview text:@"店铺类型" color:appSubColor size:14 alignment:NSTextAlignmentLeft];
    UILabel *phoneLab = [UILabel creatLabel:frame(36, 144, 60, 14) inView:bgview text:@"联系方式" color:appSubColor size:14 alignment:NSTextAlignmentLeft];
    UILabel *adressLab = [UILabel creatLabel:frame(36, phoneLab.bottom + 24, 60, 14) inView:bgview text:@"所在位置" color:appSubColor size:14 alignment:NSTextAlignmentLeft];
    UILabel *detailAdressLab = [UILabel creatLabel:frame(36, adressLab.bottom + 24, 60, 14) inView:bgview text:@"详细地址" color:appSubColor size:14 alignment:NSTextAlignmentLeft];
    UILabel *distanceLab = [UILabel creatLabel:frame(36, detailAdressLab.bottom + 24, 60, 14) inView:bgview text:@"服务范围" color:appSubColor size:14 alignment:NSTextAlignmentLeft];
    UILabel *shopInfoLab = [UILabel creatLabel:frame(36, distanceLab.bottom + 24, 60, 14) inView:bgview text:@"店铺介绍" color:appSubColor size:14 alignment:NSTextAlignmentLeft];
    UILabel *shopShowLab = [UILabel creatLabel:frame(36, shopInfoLab.bottom + 75, 110, 14) inView:bgview text:@"店铺展示图上传" color:appSubColor size:14 alignment:NSTextAlignmentLeft];
    UILabel *shopShowLab2 = [UILabel creatLabel:frame(shopShowLab.right, shopShowLab.top + 1, 110, 14) inView:bgview text:@"(最多4张)" color:appGrayTextColor size:12 alignment:NSTextAlignmentLeft];
    UILabel *realNameLab = [UILabel creatLabel:frame(0, shopShowLab2.bottom + 114, ksWidth, 17) inView:bgview text:@"实名认证" color:appMainColor size:17 alignment:NSTextAlignmentCenter];
    realNameLab.font = BoldFont(17);
    UILabel *nameLab = [UILabel creatLabel:frame(36, shopShowLab.bottom + 162, 60, 14) inView:bgview text:@"姓名" color:appSubColor size:14 alignment:NSTextAlignmentLeft];
    UILabel *idCardLab = [UILabel creatLabel:frame(36, nameLab.bottom + 24, 60, 14) inView:bgview text:@"身份证号" color:appSubColor size:14 alignment:NSTextAlignmentLeft];
    UILabel *idPhotoLab = [UILabel creatLabel:frame(36, idCardLab.bottom + 24, 110, 14) inView:bgview text:@"身份证照片上传" color:appSubColor size:14 alignment:NSTextAlignmentLeft];


    
//    _shopType = [[UITextField alloc] initWithFrame:frame(114, shopTypeLab.top, ksWidth - 160, 14)];
//    _shopType.textColor = appSubColor;
//    _shopType.font = Font(14);
//    _shopType.placeholder = @"请选择服务类型";
//    [bgview addSubview:_shopType];
//    MioShopTypeView *shoptype = [[MioShopTypeView alloc] init];
//    [_shopType whenTapped:^{
//        [shoptype show];
//    }];
    
    _phone = [[UITextField alloc] initWithFrame:frame(114, phoneLab.top, ksWidth - 160, 14)];
    _phone.textColor = appSubColor;
    _phone.font = Font(14);
    _phone.placeholder = @"请输入手机号码或座机号";
    [bgview addSubview:_phone];
    
    _adress = [[UITextField alloc] initWithFrame:frame(114, adressLab.top, ksWidth - 160, 14)];
    _adress.textColor = appSubColor;
    _adress.font = Font(14);
    _adress.placeholder = @"请选择地址";
    [bgview addSubview:_adress];
    [_adress whenTapped:^{
        MamapVC *vc = [[MamapVC alloc] init];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    _detailAdress = [[UITextField alloc] initWithFrame:frame(114, detailAdressLab.top, ksWidth - 160, 14)];
    _detailAdress.textColor = appSubColor;
    _detailAdress.font = Font(14);
    _detailAdress.placeholder = @"请输入详细地址(选填)";
    [bgview addSubview:_detailAdress];
    
    _distance = [UILabel creatLabel:frame(114, distanceLab.top, 40, 14) inView:bgview text:@"5km" color:appSubColor size:14 alignment:NSTextAlignmentLeft];
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(_distance.right + 8, _distance.top+ 3, ksWidth - 195, 8)];
    slider.minimumValue = 1.0;
    slider.maximumValue = 30.0;
    slider.thumbTintColor = appMainColor;
    slider.minimumTrackTintColor = appMainColor;
    slider.maximumTrackTintColor = [[UIColor lightGrayColor] colorWithAlphaComponent:.5];
    [bgview addSubview:slider];
    [slider setValue:5 animated:YES];
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    _intro = [FSTextView textView] ;
    _intro.frame = frame(110, shopInfoLab.top - 10, ksWidth - 156, 70);
    _intro.font = Font(14);
    _intro.placeholder = @"请填写您的详细的店铺介绍与服务内容等信息，可以吸引更多客户下单。";
    _intro.placeholderFont = Font(14);
    [bgview addSubview:_intro];
    
    _realName = [[UITextField alloc] initWithFrame:frame(114, nameLab.top, ksWidth - 160, 14)];
    _realName.textColor = appSubColor;
    _realName.font = Font(14);
    _realName.placeholder = @"请输入真实姓名";
    [bgview addSubview:_realName];
    
    _idcardNumber = [[UITextField alloc] initWithFrame:frame(114, idCardLab.top, ksWidth - 160, 14)];
    _idcardNumber.textColor = appSubColor;
    _idcardNumber.font = Font(14);
    _idcardNumber.placeholder = @"请输入身份证号码";
    [bgview addSubview:_idcardNumber];

    _photoView = [HXPhotoView photoManager:self.twoManager];
    _photoView.frame = frame(36, shopShowLab.bottom+ 15, ksWidth - 72, 70);
//    ViewRadius(_photoView, 0);
    _photoView.lineCount = 4;
    _photoView.addImageName = @"icon_add";
    _photoView.delegate = self;
    [bgview addSubview:_photoView];
    
    _frontPhoto = [UIImageView creatImgView:frame(36, idPhotoLab.bottom + 14, ksWidth/2 -36 -5, 93) inView:bgview image:@"id_icon_positive" radius:0];
    [_frontPhoto whenTapped:^{
        [self selectFront];
    }];
    _backPhoto = [UIImageView creatImgView:frame(ksWidth/2 + 5, idPhotoLab.bottom + 14, ksWidth/2 -36 -5, 93) inView:bgview image:@"id_icon_reverse" radius:0];
    [_backPhoto whenTapped:^{
        [self selectBack];
    }];
    UILabel *frontLab = [UILabel creatLabel:frame(_frontPhoto.left, _frontPhoto.bottom + 10, _frontPhoto.width, 14) inView:bgview text:@"正面" color:rgb(204, 204, 204) size:14 alignment:NSTextAlignmentCenter];
    UILabel *backLab = [UILabel creatLabel:frame(_backPhoto.left, _backPhoto.bottom + 10, _backPhoto.width, 14) inView:bgview text:@"反面" color:rgb(204, 204, 204) size:14 alignment:NSTextAlignmentCenter];

}

- (void)sliderValueChanged:(UISlider *)sender {
    
    _distance.text = [NSString stringWithFormat:@"%.0fkm", sender.value];

}

#pragma mark - 选择照片
-(void)selectAvatar{
    WEAKSELF;
    [self hx_presentSelectPhotoControllerWithManager:self.oneManager didDone:^(NSArray<HXPhotoModel *> *allList, NSArray<HXPhotoModel *> *photoList, NSArray<HXPhotoModel *> *videoList, BOOL isOriginal, UIViewController *viewController, HXPhotoManager *manager) {
        HXPhotoModel *model = photoList.firstObject;
        self.avatar.image = model.previewPhoto;
    } cancel:^(UIViewController *viewController, HXPhotoManager *manager) {
        NSSLog(@"block - 取消了");
    }];
}

-(void)selectFront{
    WEAKSELF;
    [self hx_presentSelectPhotoControllerWithManager:self.threeManager didDone:^(NSArray<HXPhotoModel *> *allList, NSArray<HXPhotoModel *> *photoList, NSArray<HXPhotoModel *> *videoList, BOOL isOriginal, UIViewController *viewController, HXPhotoManager *manager) {
        HXPhotoModel *model = photoList.firstObject;
        self.frontPhoto.image = model.previewPhoto;
    } cancel:^(UIViewController *viewController, HXPhotoManager *manager) {
        NSSLog(@"block - 取消了");
    }];
}

-(void)selectBack{
    WEAKSELF;
    [self hx_presentSelectPhotoControllerWithManager:self.fourManager didDone:^(NSArray<HXPhotoModel *> *allList, NSArray<HXPhotoModel *> *photoList, NSArray<HXPhotoModel *> *videoList, BOOL isOriginal, UIViewController *viewController, HXPhotoManager *manager) {
        HXPhotoModel *model = photoList.firstObject;
        self.backPhoto.image = model.previewPhoto;
    } cancel:^(UIViewController *viewController, HXPhotoManager *manager) {
        NSSLog(@"block - 取消了");
    }];
}

- (HXPhotoManager *)oneManager {
    if (!_oneManager) {
        _oneManager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _oneManager.configuration.singleSelected = YES;
        _oneManager.configuration.singleJumpEdit = YES;
        _oneManager.configuration.photoEditCustomRatios = @[@{@"正方形" : @"{1, 1}"},];
        _oneManager.configuration.movableCropBoxCustomRatio = CGPointMake(1, 1);
        _oneManager.configuration.movableCropBox = YES;
        _oneManager.configuration.movableCropBoxEditSize = YES;

    }
    return _oneManager;
}

- (HXPhotoManager *)twoManager {
    if (!_twoManager) {
        _twoManager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _twoManager.configuration.photoMaxNum = 4;
    }
    return _twoManager;
}

- (HXPhotoManager *)threeManager {
    if (!_threeManager) {
        _threeManager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _threeManager.configuration.singleSelected = YES;
    }
    return _threeManager;
}

- (HXPhotoManager *)fourManager {
    if (!_fourManager) {
        _fourManager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _fourManager.configuration.singleSelected = YES;
    }
    return _fourManager;
}

- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal{
    [self.shopShowsImgArr removeAllObjects];
    for (HXPhotoModel *model in photos) {
//        [_shopShowsImgArr addObject:photo.previewPhoto];
        [[PHImageManager defaultManager] requestImageDataForAsset:model.asset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            
            [self.shopShowsImgArr addObject:[UIImage imageWithData:imageData]];
        }];

    }
    
}

#pragma mark - 高德
- (void)pickAdressWithAdress:(NSString *)adress Province:(NSString *)province City:(NSString *)city District:(NSString *)district lat:(CGFloat)lat lon:(CGFloat)lon{
    [_locationArr addObject:adress];
    [_locationArr addObject:province];
    [_locationArr addObject:city];
    [_locationArr addObject:district];
    [_locationArr addObject:[NSString stringWithFormat:@"%f",lat]];
    [_locationArr addObject:[NSString stringWithFormat:@"%f",lon]];
    _adress.text = adress;
}


#pragma mark - 七牛
-(void)getQiniuToken{
    
    MioPostRequest *request = [[MioPostRequest alloc] initWithRequestUrl:api_QNToken argument:nil];
    
    [request success:^(NSDictionary *result) {
        NSDictionary *data = [result objectForKey:@"data"];
        NSString *QNToken = [data objectForKey:@"upload_token"];
        
        _qiniuToken = QNToken;
        
    } failure:^(NSString *errorInfo) {
        //错误
        NSLog(@"%@",errorInfo);
        
    }];
}

-(void)uploadImagesToQiNiuWithImages:(NSArray *)images{
    
    [SVProgressHUD show];

    [[MyUploadManager shareInsance] uploadImageArray:images withToken:_qiniuToken success:^(NSMutableArray *imageNameArray) {
        [SVProgressHUD showSuccessWithStatus:@"上传图片成功"];
        self.allPhotoKeysArr = imageNameArray;
        [self upToSever];
    } failure:^(NSMutableArray *errorArr) {
        if (errorArr.count) {
            [SVProgressHUD showErrorWithStatus:@"上传图片失败"];

        }
    }];
    
}

-(void)uploadAllPhoto{
    
    //店铺名为空
    if (_shopName.text.length < 3 | _shopName.text.length > 12) {
        [SVProgressHUD showErrorWithStatus:@"请输入3-12个字符的店铺名"];return;
    }
 
    //店铺图片为空
    if (_avatar.image == [UIImage imageNamed:@"logo_default"]) {
        [SVProgressHUD showErrorWithStatus:@"请选择店铺照片"];return;
    }
    //联系方式少于八位
    if (_phone.text.length < 8 | _phone.text.length > 15) {
        [SVProgressHUD showErrorWithStatus:@"联系方式不能少于八位"];return;
    }
    //所在位置没有选择
    if (!_adress.text.length) {
        [SVProgressHUD showErrorWithStatus:@"没有选择所在位置"];return;
    }
    
    //店铺介绍为空
    if (!_intro.text.length) {
        [SVProgressHUD showErrorWithStatus:@"没有填写店铺介绍"];return;
    }

    //姓名为空
    if (!_realName.text.length) {
        [SVProgressHUD showErrorWithStatus:@"真实姓名为空"];return;
    }
    //身份证位数不对
    if (_idcardNumber.text.length != 18) {
        [SVProgressHUD showErrorWithStatus:@"身份证位数不对"];return;
    }
    //身份证正面为空
    if (_frontPhoto.image == [UIImage imageNamed:@"id_icon_positive"]) {
        [SVProgressHUD showErrorWithStatus:@"请选择身份证照片"];return;
    }
    //身份证反面为空
    if (_backPhoto.image == [UIImage imageNamed:@"id_icon_reverse"]) {
        [SVProgressHUD showErrorWithStatus:@"请选择身份证照片"];return;
    }
    //展示图至少一个
    if (_shopShowsImgArr.count < 1) {
        [SVProgressHUD showErrorWithStatus:@"至少上传一张展示图"];return;
    }
    
    
    NSMutableArray *allImgArr = [[NSMutableArray alloc] init];
    [allImgArr addObject:_avatar.image];
    [allImgArr addObject:_frontPhoto.image];
    [allImgArr addObject:_backPhoto.image];
    [allImgArr addObjectsFromArray:self.shopShowsImgArr];
    [self uploadImagesToQiNiuWithImages:allImgArr];
}

-(void)upToSever{

//    MioAFPutRequest *manger = [MioAFPutRequest shareManager];
//    [MioAFPutRequest requestWithUrl:api_me params:@{@"shop_contact_phone":@"123"} successBlock:^(NSDictionary * _Nonnull object) {
//        [SVProgressHUD showSuccessWithStatus:@"111"];
//    } failureBlock:^(NSError * _Nonnull error) {
//        [SVProgressHUD showSuccessWithStatus:error.userInfo[@"Content-Type"] ];
//    }];
    
    NSMutableArray *showArr = [NSMutableArray arrayWithArray:_allPhotoKeysArr];
    [showArr removeObjectsInRange:NSMakeRange(0, 3)];
    
    NSDictionary *params = @{
                          @"shop_title":_shopName.text,
                          @"shop_cover":_allPhotoKeysArr[0],
                          @"shop_contact_phone":_phone.text,
                          @"shop_doorplate":_locationArr[0],
                          @"shop_province":_locationArr[1],
                          @"shop_city":_locationArr[2],
                          @"shop_district":_locationArr[3],
                          @"shop_latitude":_locationArr[4],
                          @"shop_longitude":_locationArr[5],
                          @"shop_service_scope":[_distance.text substringToIndex:([_distance.text length]-2)],
                          @"shop_introduce":_intro.text,
                          @"shop_master_name":_realName.text,
                          @"shop_id_card":_idcardNumber.text,
                          @"shop_id_card_positive":_allPhotoKeysArr[1],
                          @"shop_id_card_back":_allPhotoKeysArr[2],
                          @"shop_images":showArr,

                          };
//
    [MioPutReq(api_me, params) success:^(NSDictionary *result){
        NSDictionary *data = [result objectForKey:@"data"];

    } failure:^(NSString *errorInfo) {
        [SVProgressHUD showErrorWithStatus:@"提交失败"];
    }];
    

}

- (NSString *)getNowTimeTimestamp3{
    
    NSDate *datenow = [NSDate date];
    //    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)([datenow timeIntervalSince1970]*1000)];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYYMMddHHmmssSSS"];
    // 时间戳转时间的方法
    
    NSString *confromTimespStr = [formatter stringFromDate:datenow];
    NSLog(@"confromTimespStr =  %@",confromTimespStr);
    
    
    return confromTimespStr;
    
}



- (void)dealloc
{
    NSLog(@"北京小伙");
}

@end
