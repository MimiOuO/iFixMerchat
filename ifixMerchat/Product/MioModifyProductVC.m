//
//  MioModifyProductVC.m
//  ifixMerchat
//
//  Created by Mimio on 2020/4/15.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import "MioModifyProductVC.h"
#import <HXPhotoPicker.h>
#import <FSTextView.h>
#import "MyUploadManager.h"
#import "MioSkuCell.h"
//#import "STPickerDouble.h"
#import "STPickerArea.h"
@interface MioModifyProductVC ()<HXPhotoViewControllerDelegate,HXPhotoViewDelegate,UITableViewDelegate,UITableViewDataSource,STPickerAreaDelegate>
@property (nonatomic, strong) NSArray *typeArr;
@property (nonatomic, strong) UIScrollView *scroll;
@property (nonatomic, strong) UITextField *productName;
@property (nonatomic, strong) UITextField *typeName;
@property (nonatomic,copy) NSString * typeId;
@property (nonatomic, strong) FSTextView *detail;


@property (nonatomic, strong) NSString *qiniuToken;

@property (weak, nonatomic) HXPhotoView *showView;
@property (strong, nonatomic) HXPhotoManager *showManager;
@property (nonatomic, strong) NSMutableArray *showsImgArr;
@property (nonatomic, strong) NSArray *showsKeyArr;

@property (weak, nonatomic) HXPhotoView *detailShowView;
@property (strong, nonatomic) HXPhotoManager *detailShowManager;
@property (nonatomic, strong) NSMutableArray *detailShowsImgArr;
@property (nonatomic, strong) NSArray *detailShowsKeyArr;

@property (nonatomic, strong) UIView *skuView;
@property (nonatomic, strong) UITableView *skuTableView;
@property (nonatomic, assign) int skuNum;
@property (nonatomic, strong) UIButton *addSkuBtn;
@end

@implementation MioModifyProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navView.leftButton setImage:backArrowIcon forState:UIControlStateNormal];
    [self.navView.centerButton setTitle:@"修改商品信息" forState:UIControlStateNormal];
    [self.navView.rightButton setTitle:@"提交" forState:UIControlStateNormal];
    WEAKSELF;
    self.navView.rightButtonBlock = ^{
        [weakSelf uploadAllPicture];
    };
    _skuNum = 1;
    _showsImgArr = [[NSMutableArray alloc] init];
    _showsKeyArr = [[NSArray alloc] init];
    _detailShowsImgArr = [[NSMutableArray alloc] init];
    _detailShowsKeyArr = [[NSArray alloc] init];
    [self getQiniuToken];
    [self getType];
    [self getProduct];
}

-(void)getType{
    [MioGetReq(api_type, @{@"k":@"v"}) success:^(NSDictionary *result){
        _typeArr = [result objectForKey:@"data"];
        [self creatUI];
    } failure:^(NSString *errorInfo) {}];
}

-(void)getProduct{
    [MioGetReq(api_getProduct(_productId), @{@"k":@"v"}) success:^(NSDictionary *result){
        _typeArr = [result objectForKey:@"data"];
       
    } failure:^(NSString *errorInfo) {}];
}

-(void)creatUI{
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NavHeight, ksWidth, ksHeight - NavHeight)];
    _scroll.contentSize = CGSizeMake(ksWidth, 1000);
    [self.view addSubview:_scroll];
    
    UILabel *nameLab = [UILabel creatLabel:frame(18, 31, 64, 15) inView:_scroll text:@"添加商品" color:appSubColor size:15 alignment:NSTextAlignmentLeft];nameLab.font = BoldFont(15);
    UILabel *typeLab = [UILabel creatLabel:frame(18, nameLab.bottom + 37, 64, 15) inView:_scroll text:@"商品分类" color:appSubColor size:15 alignment:NSTextAlignmentLeft];typeLab.font = BoldFont(15);
    UILabel *showLab = [UILabel creatLabel:frame(18, typeLab.bottom + 37, 78, 15) inView:_scroll text:@"商品展示图" color:appSubColor size:15 alignment:NSTextAlignmentLeft];showLab.font = BoldFont(15);
    UILabel *deatilLab = [UILabel creatLabel:frame(18, showLab.bottom + 111, 94, 15) inView:_scroll text:@"商品详细介绍" color:appSubColor size:14 alignment:NSTextAlignmentLeft];deatilLab.font = BoldFont(15);
    UILabel *detailPicLab = [UILabel creatLabel:frame(18, deatilLab.bottom + 108, 78, 15) inView:_scroll text:@"商品详情图" color:appSubColor size:14 alignment:NSTextAlignmentLeft];detailPicLab.font = BoldFont(15);
    UILabel *showTip = [UILabel creatLabel:frame(showLab.right , showLab.top + 2, 100, 12) inView:_scroll text:@"（最多4张）" color:appGrayTextColor size:12 alignment:NSTextAlignmentLeft];nameLab.font = BoldFont(15);
    UILabel *detailTip = [UILabel creatLabel:frame(deatilLab.right , deatilLab.top + 2, 100, 12) inView:_scroll text:@"（选填）" color:appGrayTextColor size:12 alignment:NSTextAlignmentLeft];
    UILabel *showPicTip = [UILabel creatLabel:frame(detailPicLab.right , detailPicLab.top + 2, 100, 12) inView:_scroll text:@"（最多8张）" color:appGrayTextColor size:12 alignment:NSTextAlignmentLeft];
    
    UIView *boderView1 = [UIView creatView:frame(90, 18, ksWidth - 90 - 18, 40) inView:_scroll bgColor:appClearColor];
    boderView1.layer.borderColor = appBottomLineColor.CGColor;
    boderView1.layer.borderWidth = 0.5;
    ViewRadius(boderView1, 4);
    

    
    UIImageView *arrow = [UIImageView creatImgView:frame(ksWidth - 29 - 7.5, 84, 7.5, 12) inView:_scroll image:@"rightArrow" radius:0];
    
    _productName = [[UITextField alloc] initWithFrame:frame(102, nameLab.top, ksWidth - 160, 14)];
    _productName.textColor = appSubColor;
    _productName.font = Font(14);
    _productName.placeholder = @"请输入商品名称";
    [_scroll addSubview:_productName];
    
    _typeName = [[UITextField alloc] initWithFrame:frame(102, typeLab.top, ksWidth - 160, 14)];
    _typeName.textColor = appSubColor;
    _typeName.font = Font(14);
    _typeName.placeholder = @"请选择商品分类";
    [_scroll addSubview:_typeName];
    
    UIView *boderView2 = [UIView creatView:frame(90, 70 , ksWidth - 90 - 18, 40) inView:_scroll bgColor:appClearColor];
    boderView2.layer.borderColor = appBottomLineColor.CGColor;
    boderView2.layer.borderWidth = 0.5;
    ViewRadius(boderView2, 4);
    WEAKSELF;
    [boderView2 whenTapped:^{

        STPickerArea *pickerArea = [[STPickerArea alloc]init];
        [pickerArea setDelegate:self];
        [pickerArea setSaveHistory:YES];
        [pickerArea setContentMode:STPickerContentModeCenter];
//        NSString *path = [[NSBundle bundleForClass:[STPickerView class]] pathForResource:@"area" ofType:@"plist"];
        pickerArea.arrayRoot = weakSelf.typeArr;
        [pickerArea show];
        
//        STPickerDouble *pickerSingle = [[STPickerDouble alloc]init];
//        [pickerSingle setArrayData:weakSelf.typeArr];
//        [pickerSingle setTitle:@"请选择商品分类"];
//        //        [pickerSingle setTitleUnit:@"人民币"];
//        [pickerSingle setContentMode:STPickerContentModeCenter];
//        [pickerSingle setDelegate:self];
//        [pickerSingle show];
    }];

    _showView = [HXPhotoView photoManager:self.showManager];
    _showView.frame = frame(18, showLab.bottom+ 15, ksWidth - 36, 78);
    _showView.spacing = 9;
    _showView.lineCount = 4;
    _showView.addImageName = @"icon_add";
    _showView.delegate = self;
    [_scroll addSubview:_showView];
    
    UIView *boderView3 = [UIView creatView:frame(18, deatilLab.bottom + 10, ksWidth - 36, 80) inView:_scroll bgColor:appClearColor];
    boderView3.layer.borderColor = appBottomLineColor.CGColor;
    boderView3.layer.borderWidth = 0.5;
    ViewRadius(boderView3, 4);
    
    _detail = [FSTextView textView] ;
    _detail.frame = frame(24, deatilLab.bottom + 14, ksWidth - 48, 72);
    _detail.font = Font(14);
    _detail.placeholder = @"请输入商品详细介绍";
    _detail.placeholderFont = Font(14);
    [_scroll addSubview:_detail];
    
    _detailShowView = [HXPhotoView photoManager:self.detailShowManager];
    _detailShowView.frame = frame(18, detailPicLab.bottom+ 15, ksWidth - 36, 180);
    _detailShowView.spacing = 9;
    _detailShowView.lineCount = 4;
    _detailShowView.addImageName = @"icon_add";
    _detailShowView.delegate = self;
    [_scroll addSubview:_detailShowView];
    
    
    _skuView = [UIView creatView:frame(0, detailPicLab.bottom + 111, ksWidth , 300) inView:_scroll bgColor:appWhiteColor];
    UILabel *skuLab = [UILabel creatLabel:frame(18, 0, 78, 15) inView:_skuView text:@"规格与价格" color:appSubColor size:14 alignment:NSTextAlignmentLeft];skuLab.font = BoldFont(15);
    UILabel *skuTip = [UILabel creatLabel:frame(skuLab.right ,  2, 260, 12) inView:_skuView text:@"（非实体类商品不需要填写库存）" color:appGrayTextColor size:12 alignment:NSTextAlignmentLeft];
    
    _skuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 25, ksWidth, 48)];
    _skuTableView.delegate = self;
    _skuTableView.dataSource = self;
    _skuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _skuTableView.scrollEnabled = NO;
    [_skuView addSubview:_skuTableView];

    _addSkuBtn = [UIButton creatBtn:frame(100, _skuTableView.bottom + 8, ksWidth - 200, 28) inView:_skuView bgColor:appClearColor title:@"添加规格与价格" action:^{
        weakSelf.skuNum += 1;
        [weakSelf.skuTableView reloadData];
    }];
    [_addSkuBtn setTitleColor:appMainColor forState:UIControlStateNormal];
    _addSkuBtn.titleLabel.font = Font(12);
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
//        self.allPhotoKeysArr = imageNameArray;
        self.showsKeyArr = [imageNameArray subarrayWithRange:NSMakeRange(0, self.showsImgArr.count)];
        self.detailShowsKeyArr = [imageNameArray subarrayWithRange:NSMakeRange(self.showsImgArr.count , self.detailShowsImgArr.count)];
        [self upToSever];
    } failure:^(NSMutableArray *errorArr) {
        if (errorArr.count) {
            [SVProgressHUD showErrorWithStatus:@"上传图片失败"];

        }
    }];
    
}

#pragma mark - upload

-(void)uploadAllPicture{
    //商品名称
    if (_productName.text.length < 3 || _productName.text.length > 20) {
        [SVProgressHUD showErrorWithStatus:@"请输入3-20个字符的商品名称"];return;
    }
    //选择分类
    if (!_typeName.text.length) {
        [SVProgressHUD showErrorWithStatus:@"请选择分类"];return;
    }
    //展示图至少一个
    if (_showsImgArr.count < 1) {
        [SVProgressHUD showErrorWithStatus:@"至少上传一张展示图"];return;
    }
    
    if (_skuTableView.visibleCells.count < 1) {
        [SVProgressHUD showErrorWithStatus:@"至少添加一种规格"];return;
    }
    
    for (MioSkuCell *cell in _skuTableView.visibleCells) {
        if (cell.skuName.text.length == 0 || cell.price.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"规格或价格不能为空"];
            return;
        }
    }

    NSMutableArray *allImageArr = [[NSMutableArray alloc] initWithArray:_showsImgArr];
    [allImageArr addObjectsFromArray:_detailShowsImgArr];
    [self uploadImagesToQiNiuWithImages:allImageArr];
    
}

-(void)upToSever{
    
    NSMutableArray *sku = [[NSMutableArray alloc] init];
    
    for (MioSkuCell *cell in _skuTableView.visibleCells) {
        [sku addObject: @{
            @"规格": cell.skuName.text,
            @"price": cell.price.text,
            @"stock": (cell.stock.text.length ? cell.stock.text : @"-1"),
        }];
    }
    NSMutableArray *skuNameArr = [[NSMutableArray alloc] init];
    NSString *lowestPrice = @"999999999";
    for (MioSkuCell * cell in _skuTableView.visibleCells) {
        [skuNameArr addObject:cell.skuName.text];
        if ([cell.price.text floatValue] < [lowestPrice floatValue]) {
            lowestPrice = cell.price.text;
        }
    }
    NSArray *attrs = @[
        @{
            @"attrs_name": @"规格",
            @"child": skuNameArr
        }
    ];
    NSDictionary *productSku = @{@"sku":sku,@"attrs":attrs };
    
    
    NSDictionary *params = @{
              @"product_title":_productName.text,
              @"category_id":[NSNumber numberWithFloat:[_typeId floatValue]],
              @"product_detail":_detail.text,
              @"product_images":_showsKeyArr,
              @"product_detail_images":_detailShowsKeyArr,
              @"product_price":[NSNumber numberWithFloat:[lowestPrice floatValue]],
              @"product_sku":productSku,

        };
    //
   
//    [MioPostReq(api_addProduct, params) success:^(NSDictionary *result){
//        NSDictionary *data = [result objectForKey:@"data"];
//
//    } failure:^(NSString *errorInfo) {
//        [SVProgressHUD showErrorWithStatus:@"提交失败"];
//    }];
    
    //这里配置请求类型为Json
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[userdefault objectForKey:@"token"]] forHTTPHeaderField:@"Authorization"];
    [manager POST:api_addProduct parameters: params progress:^(NSProgress * _Nonnull uploadProgress) {
           
           
       } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           
           
           
           [SVProgressHUD showSuccessWithStatus:@"添加商品成功！"];
           
           
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           
           [SVProgressHUD showErrorWithStatus:@"提交失败"];
           
       }];
    
}

#pragma mark - 选择照片
- (HXPhotoManager *)showManager {
    if (!_showManager) {
        _showManager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _showManager.configuration.photoMaxNum = 4;

    }
    return _showManager;
}

- (HXPhotoManager *)detailShowManager {
    if (!_detailShowManager) {
        _detailShowManager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _detailShowManager.configuration.photoMaxNum = 8;
    }
    return _detailShowManager;
}

- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal{
    
    if (photoView == _showView) {
        [self.showsImgArr removeAllObjects];
        for (HXPhotoModel *model in photos) {
            [[PHImageManager defaultManager] requestImageDataForAsset:model.asset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                
                [self.showsImgArr addObject:[UIImage imageWithData:imageData]];
            }];

        }
    }else{
        
        if (photos.count < 4) {
            _skuView.top = 510;
            _scroll.contentSize = CGSizeMake(ksWidth, _skuNum * 48 + 71 + 510 + SafeBottomH);
        }else{
            _skuView.top = 600;
            _scroll.contentSize = CGSizeMake(ksWidth, _skuNum * 48 + 71 + 600 + SafeBottomH);
        }
        [self.detailShowsImgArr removeAllObjects];
        for (HXPhotoModel *model in photos) {
            [[PHImageManager defaultManager] requestImageDataForAsset:model.asset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                
                [self.detailShowsImgArr addObject:[UIImage imageWithData:imageData]];
            }];

        }
    }
}

#pragma mark - SKU

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    _skuTableView.height = _skuNum * 48;
    _addSkuBtn.top = _skuTableView.bottom + 8;
    _skuView.height = 25 + _skuTableView.height + 46;
    if (_detailShowsImgArr.count < 4) {
        _scroll.contentSize = CGSizeMake(ksWidth, 510 + _skuView.height + SafeBottomH);
    }else{
        _scroll.contentSize = CGSizeMake(ksWidth, 600 + _skuView.height + SafeBottomH);
    }
    return _skuNum;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    MioSkuCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MioSkuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//        cell.backgroundColor = appMainColor;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MioSkuCell *cell = [self.skuTableView cellForRowAtIndexPath:indexPath];
    [cell clearData];
    _skuNum -= 1;
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    [tableView reloadData];
    
}

- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area
{
    NSLog(@"%@%@",province,city);
    _typeName.text = city;
    
    for (NSDictionary *dic in _typeArr) {
        if ([province isEqualToString:dic[@"category_name"]]) {
            NSArray *items = dic[@"items"];
            for (NSDictionary *item  in items) {
                if ([city isEqualToString:item[@"category_name"]]){
                    _typeId = [NSString stringWithFormat:@"%@",item[@"category_id"]];
                }
            }
        }
    }
}
@end
