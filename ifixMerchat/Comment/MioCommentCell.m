//
//  MioTableViewCell.m
//  ifixMerchat
//
//  Created by Mimio on 2020/4/8.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import "MioCommentCell.h"
#import <HXPhotoPicker.h>
#import <LEEAlert.h>
@interface MioCommentCell()
@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *nickname;
@property (nonatomic, strong) UIImageView *rate;
@property (nonatomic, strong) UILabel *cmtTime;
@property (nonatomic, strong) UILabel *serviceName;
@property (nonatomic, strong) UILabel *serviewTime;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *cmt;
@property (nonatomic, strong) HXPhotoView *showView;
@property (nonatomic, strong) HXPhotoManager *showManger;
@property (nonatomic, strong) UIView *replyView;
@property (nonatomic, strong) UILabel *reply;
@property (nonatomic, strong) UIView *split;
@property (nonatomic, strong) UIButton *replyBtn;

@end

@implementation MioCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        WEAKSELF;
        self.contentView.backgroundColor = appWhiteColor;
        _avatar = [UIImageView creatImgView:frame(18, 17, 30, 30) inView:self.contentView image:@"" radius:4];
        _nickname = [UILabel creatLabel:frame(56, 18, 100, 14) inView:self.contentView text:@"" color:appSubColor size:14 alignment:NSTextAlignmentLeft];
        _nickname.font = BoldFont(14);
        _rate = [UIImageView creatImgView:frame(_nickname.right + 10, 19, 90, 10) inView:self.contentView image:@"" radius:0];
        _cmtTime = [UILabel creatLabel:frame(56, 34, 200, 12) inView:self.contentView text:@"" color:appGrayTextColor size:12 alignment:NSTextAlignmentLeft];
        UIView *productView = [UIView creatView:frame(18, 55, ksWidth - 36 , 40) inView:self.contentView bgColor:rgba(255, 250, 246, 1)];
        productView.layer.borderColor = appMainColor.CGColor;
        productView.layer.borderWidth = 0.5;
        ViewRadius(productView, 4);
        _serviceName = [UILabel creatLabel:frame(24, 61, ksWidth - 48, 12) inView:self.contentView text:@"" color:appMainColor size:12  alignment:NSTextAlignmentLeft];
        _serviewTime = [UILabel creatLabel:frame(24, 77, ksWidth - 48, 12) inView:self.contentView text:@"" color:appMainColor size:12  alignment:NSTextAlignmentLeft];
        _price = [UILabel creatLabel:frame(ksWidth - 100 - 24, 73, 100, 16) inView:self.contentView text:@"" color:appMainColor size:16 alignment:NSTextAlignmentRight];
        _cmt = [UILabel creatLabel:frame(18, 103, ksWidth - 36, 14) inView:self.contentView text:@"" color:appSubColor size:14 alignment:NSTextAlignmentLeft];
        _cmt.numberOfLines = 0;
        
        
        _showManger = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];

//
        _showView = [[HXPhotoView alloc]init];
        _showView.frame = frame(18, _cmt.bottom+ 8, ksWidth - 36, 82);
        _showView.spacing = 9;
        _showView.lineCount = 4;
        _showView.hideDeleteButton = YES;
        [self.contentView addSubview:_showView];
        
        _replyView = [UIView creatView:frame(18, _showView.bottom + 8, ksWidth - 36, 80) inView:self.contentView bgColor:rgba(242, 242, 242, 1)];
        _reply = [UILabel creatLabel:frame(10, 10, ksWidth - 56, 60) inView:_replyView text:@"" color:rgba(102, 102, 102, 1) size:12 alignment:NSTextAlignmentLeft];
        _reply.numberOfLines = 0;
        _split = [UIView creatView:frame(0, _reply.bottom + 18, ksWidth, 8) inView:self.contentView bgColor:rgba(246, 246, 246, 1)];
        
        _replyBtn = [UIButton creatBtn:frame(ksWidth - 18 - 41 , 22, 41, 20) inView:self.contentView bgColor:appMainColor title:@"回复" action:^{
            [weakSelf replyCmt];
        }];
        ViewRadius(_replyBtn, 2);
        _replyBtn.titleLabel.font = Font(10);
    }
    return self;
}

- (void)setModel:(MioCommentModel *)model{
    _model = model;
    [_avatar sd_setImageWithURL:Url(model.customer.customer_face) placeholderImage:image(@"icon")];
    _nickname.text = model.customer.customer_nickname;
    _nickname.width = [_nickname.text widthForFont:BoldFont(14)];
    _rate.left = _nickname.right + 10;
    _cmtTime.text = model.created_at;
    _rate.image = [UIImage imageNamed:[NSString stringWithFormat:@"star_%d",model.comment_rate]];
    _serviceName.text = Str(@"商品名称：",model.product.product_title);
    _serviewTime.text = Str(@"服务时间：",model.order.serviceTime);
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:Str(@"￥",model.order.total_price)];
    [AttributedStr addAttribute:NSFontAttributeName value:BoldFont(10) range:NSMakeRange(0, 1)];
    _price.attributedText = AttributedStr;
    
    _cmt.text = model.comment;
    _cmt.height = [_cmt.text heightForFont:Font(14) width:ksWidth - 36];
    _split.top = _cmt.bottom + 18;
    
    
    if (model.comment_images_path.count) {
        _showView.hidden = NO;
        _showView.top = _cmt.bottom + 8;
        
        _showManger.configuration.photoMaxNum = model.comment_images_path.count;
//        dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_CONCURRENT);
//        dispatch_async(queue, ^{
            NSMutableArray *array = [NSMutableArray arrayWithArray:model.comment_images_path];
            NSMutableArray *assets = @[].mutableCopy;
            for (NSString *url in array) {
                HXCustomAssetModel *asset = [HXCustomAssetModel assetWithNetworkImageURL:[NSURL URLWithString:url] selected:YES];
                [assets addObject:asset];
            }
            [_showManger addCustomAssetModel:assets];

            _showView.manager = _showManger;
            [_showView reloadInputViews];
//        });
        

        _split.top = _showView.bottom + 18;
        

    }else{
        _showView.hidden = YES;
        _showView.manager = nil;
    }
    
    if (model.shop_reply) {
        if (model.comment_images_path.count) {
            _replyView.top = _showView.bottom + 8;
        }else{
            _replyView.top = _cmt.bottom + 8;
        }
        _replyView.hidden = NO;
        _reply.text = Str(@"店家回复：",model.shop_reply);
        _reply.height = [_reply.text heightForFont:Font(14) width:ksWidth - 56];
        _replyView.height = _reply.height + 20;
        _split.top = _replyView.bottom + 18;
        _replyBtn.hidden = YES;
    }else{
        _replyView.hidden = YES;
        _replyBtn.hidden = NO;
    }
    
}

-(void)replyCmt{
    __block UITextView *tf = nil;
    [LEEAlert alert].config
    .LeeTitle(@"请输入回复内容")         // 添加一个标题 (默认样式)
//    .LeeContent(@"内容")        // 添加一个标题 (默认样式)
//    .LeeAddTextField(^(UITextField *textField) {    // 添加一个输入框 (自定义设置)
//        // textfield设置Block
//        textField.keyboardType = UIKeyboardTypeDecimalPad;
//        [textField becomeFirstResponder];
//        tf = textField; //赋值
//    })
    .LeeAddCustomView(^(LEECustomView *custom) {
        
        UIView *view = [[UIView alloc] initWithFrame:frame(0, 0, 240, 100)];
        view.layer.borderColor = appBottomLineColor.CGColor;
        view.layer.borderWidth = 0.5;
        ViewRadius(view, 4);
//        textView
        // 设置视图对象
        custom.view = view;
        custom.isAutoWidth = YES;
        UITextView *textView = [[UITextView alloc] initWithFrame:frame(10, 10, custom.view.width - 20, custom.view.height - 20)];
        [view addSubview:textView];
        textView.backgroundColor  = appMainColor;
        [textView becomeFirstResponder];
        tf = textView;
        // 设置是否自动适应宽度 (自适应宽度后 位置类型为居中)
        
    })
//    .LeeCustomView(view)    // 添加自定义的视图


    .LeeCancelAction(@"取消", ^{    // 添加一个取消类型的Action (默认样式 alert中为粗体 actionsheet中为最下方独立)
        // 点击事件Block
    })
    .LeeDestructiveAction(@"回复", ^{    // 添加一个销毁类型的Action (默认样式 字体颜色为红色)
            // 点击事件Block
        if ([tf.text isEqualToString:@""]) {
            [SVProgressHUD showErrorWithStatus:@"请输入回复内容"];return;
        }
        
        NSLog(@"%@",tf.text);
        NSLog(@"%@",self.model.order_comment_id);
        [MioPutReq(api_replyComment(self.model.order_comment_id), @{@"reply":tf.text}) success:^(NSDictionary *result){
            NSDictionary *data = [result objectForKey:@"data"];
            [SVProgressHUD showSuccessWithStatus:@"回复成功，刷新列表后可见！"];

        } failure:^(NSString *errorInfo) {
            NSLog(@"%@",errorInfo);
        }];
            
    })
    .leeShouldActionClickClose(^(NSInteger index){
        // 是否可以关闭回调, 当即将关闭时会被调用 根据返回值决定是否执行关闭处理
        // 这里演示了与输入框非空校验结合的例子
        BOOL result = ![tf.text isEqualToString:@""];
        result = index == 0 ? result : YES;
        return result;
    })

    .LeeShow(); // 最后调用Show开始显示
}

@end
