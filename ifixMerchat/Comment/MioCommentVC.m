//
//  MioCommentVC.m
//  ifixMerchat
//
//  Created by Mimio on 2020/4/8.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import "MioCommentVC.h"
#import "MioCommentCell.h"
#import "MioCommentModel.h"
@interface MioCommentVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *cmtTable;
@property (nonatomic, assign) int page;
@property (nonatomic, strong) NSMutableArray *cmtArr;
@end

@implementation MioCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navView.leftButton setImage:backArrowIcon forState:UIControlStateNormal];
    [self.navView.centerButton setTitle:@"全部评论" forState:UIControlStateNormal];
    
    _cmtTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NavHeight, ksWidth, ksHeight)];
    _cmtTable.delegate = self;
    _cmtTable.dataSource = self;
    _cmtTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_cmtTable];
    _cmtTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page = _page + 1;
        [self requestComment];
    }];
    _page = 1;
    _cmtArr = [[NSMutableArray alloc] init];
    [self requestComment];
}

-(void)requestComment{
    [MioGetReq(api_getComment, (@{@"page":[NSString stringWithFormat:@"%ld",(long)_page]})) success:^(NSDictionary *result){
            NSArray *data = [result objectForKey:@"data"];
            [_cmtTable.mj_footer endRefreshing];
            [_cmtArr addObjectsFromArray:data];
            if (data.count< 10) {
                [_cmtTable.mj_footer endRefreshingWithNoMoreData];
            }
            [_cmtTable reloadData];
    } failure:^(NSString *errorInfo) {}];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cmtArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MioCommentModel *model = [MioCommentModel mj_objectWithKeyValues:_cmtArr[indexPath.row]];
    
    CGFloat cmtHeight = [model.comment heightForFont:Font(14) width:ksWidth - 36];
    CGFloat showHeight = 0;
    if (model.comment_images_path) {
        showHeight = 88;
    }
    CGFloat replyHeight = 0;
    if (model.shop_reply) {
        replyHeight = [Str(@"店家回复：",model.shop_reply) heightForFont:Font(12) width:ksWidth - 56] + 20;
    }
    
    return 103 + cmtHeight + showHeight + replyHeight + 26;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    MioCommentCell *cell = [[MioCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    
    cell.model = [MioCommentModel mj_objectWithKeyValues:_cmtArr[indexPath.row]];
    return cell;
}

@end
