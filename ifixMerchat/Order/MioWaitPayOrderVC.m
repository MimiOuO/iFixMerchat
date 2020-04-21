//
//  MioWaitPayOrderVC.m
//  ifixMerchat
//
//  Created by Mimio on 2020/4/17.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import "MioWaitPayOrderVC.h"
#import "MioOrderModel.h"
#import "MioOrderListCell.h"
@interface MioWaitPayOrderVC ()
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *listArr;
@end

@implementation MioWaitPayOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 1;
    _listArr = [[NSMutableArray alloc] init];
    [self getOrder];
    [self creatUI];
}

-(void)getOrder{
    [MioGetReq(api_getProducts, (@{@"page":[NSString stringWithFormat:@"%ld",(long)_page]})) success:^(NSDictionary *result){
        NSArray *data = [result objectForKey:@"data"];
        [_tableview.mj_footer endRefreshing];
        [_listArr addObjectsFromArray:data];
        if (data.count< 10) {
            [_tableview.mj_footer endRefreshingWithNoMoreData];
        }
        [_tableview reloadData];
    } failure:^(NSString *errorInfo) {}];
}

-(void)creatUI{
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ksWidth, ksHeight - NavHeight - 30)];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page = _page + 1;
        [self getOrder];
    }];
    [self.view addSubview:_tableview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 169;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    MioOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MioOrderListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    MioOrderModel *model = [MioOrderModel mj_objectWithKeyValues:_listArr[indexPath.row]];
    cell.model = model;
    return cell;
}


@end
