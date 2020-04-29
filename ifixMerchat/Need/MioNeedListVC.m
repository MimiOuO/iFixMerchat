//
//  MioNeedListVC.m
//  ifixMerchat
//
//  Created by Mimio on 2020/4/26.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import "MioNeedListVC.h"
#import "MioNeedCell.h"
#import "MioNeedModel.h"
#import "MioNeedDetailVC.h"
@interface MioNeedListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *cmtTable;
@property (nonatomic, assign) int page;
@property (nonatomic, strong) NSMutableArray *cmtArr;
@end

@implementation MioNeedListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cmtTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ksWidth, ksHeight - NavHeight - 30)];
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
    [MioGetReq(api_getNeeds, (@{@"page":[NSString stringWithFormat:@"%ld",(long)_page]})) success:^(NSDictionary *result){
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
    
    return 152;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    MioNeedCell *cell = [[MioNeedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = [MioNeedModel mj_objectWithKeyValues:_cmtArr[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MioNeedDetailVC *vc = [[MioNeedDetailVC alloc] init];
    MioNeedModel *model = [MioNeedModel mj_objectWithKeyValues:_cmtArr[indexPath.row]];
    vc.needId = model.need_id;
//    vc.model =
    [self.navigationController pushViewController:vc animated:YES];
}

@end
