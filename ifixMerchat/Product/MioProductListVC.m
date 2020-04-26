//
//  MioProductListVC.m
//  ifixMerchat
//
//  Created by Mimio on 2020/4/15.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import "MioProductListVC.h"
#import "MioProductCell.h"
#import "MioProductModel.h"
#import "MioAddProductVC.h"
#import "MioModifyProductVC.h"
@interface MioProductListVC ()<UITableViewDelegate,UITableViewDataSource,ProductDelegate>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSMutableArray *listArr;

@end

@implementation MioProductListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navView.leftButton setImage:backArrowIcon forState:UIControlStateNormal];
    [self.navView.centerButton setTitle:@"商品管理" forState:UIControlStateNormal];
    [self.navView.rightButton setTitle:@"添加" forState:UIControlStateNormal];
    [self.navView.rightButton setTitleColor:appMainColor forState:UIControlStateNormal];
    self.navView.rightButtonBlock = ^{
        MioAddProductVC *vc = [[MioAddProductVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    self.navView.split.hidden = YES;
    UISegmentedControl *con =  [[UISegmentedControl alloc] initWithItems:@[@"已上架(65)",@"已下架(15)"]];
    con.frame = frame(70, NavHeight +7, ksWidth - 140, 30);
    con.selectedSegmentIndex = 0;
    [con addTarget:self action:@selector(segCChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:con];
    UIView *split = [UIView creatView:frame(0, NavHeight + 48.5, ksWidth, 0.5) inView:self.view bgColor:appBottomLineColor];
    _listArr = [[NSMutableArray alloc] init];
    _page = 1;
    _status = 1;
    [self getProduct];
    [self creatUI];
}

-(void)getProduct{
    NSLog(@"%ld",(long)_status);
    [MioGetReq(api_getProducts, (@{@"page":[NSString stringWithFormat:@"%ld",(long)_page],@"product_status":[NSString stringWithFormat:@"%ld",(long)_status]})) success:^(NSDictionary *result){
        NSArray *data = [result objectForKey:@"data"];
        [_tableview.mj_footer endRefreshing];
        [_listArr addObjectsFromArray:data];
        if (data.count< 10) {
            [_tableview.mj_footer endRefreshingWithNoMoreData];
        }
        [_tableview reloadData];
    } failure:^(NSString *errorInfo) {}];
}

-(void)segCChanged:(UISegmentedControl *)seg

{
    NSInteger i = seg.selectedSegmentIndex;
    _page = 1;
    _status = 1 + i;
    [_listArr removeAllObjects];
    [self getProduct];
    

//    NSLog(@"切换了状态 %lu",i);


}

-(void)creatUI{
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, NavHeight + 49, ksWidth, ksHeight - NavHeight - 49)];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page = _page + 1;
        [self getProduct];
    }];
    [self.view addSubview:_tableview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 173;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    MioProductCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MioProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.delegate = self;
    MioProductModel *model = [MioProductModel mj_objectWithKeyValues:_listArr[indexPath.row]];
    cell.model = model;
    return cell;
}

- (void)clickModify:(MioProductModel *)model{
    MioModifyProductVC *vc = [[MioModifyProductVC alloc] init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)clickUpDown:(MioProductModel *)model{
    
}
- (void)clickDelete:(MioProductModel *)model{
    
}

@end
