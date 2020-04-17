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
@interface MioProductListVC ()<UITableViewDelegate,UITableViewDataSource,ProductDelegate>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSMutableArray *followArr;
@end

@implementation MioProductListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navView.leftButton setImage:backArrowIcon forState:UIControlStateNormal];
    [self.navView.centerButton setTitle:@"商品管理" forState:UIControlStateNormal];
    [self.navView.rightButton setTitle:@"添加" forState:UIControlStateNormal];
    [self.navView.rightButton setTitleColor:appMainColor forState:UIControlStateNormal];
    self.navView.rightButtonBlock = ^{
      
    };
    self.navView.split.hidden = YES;
    UISegmentedControl *con =  [[UISegmentedControl alloc] initWithItems:@[@"已上架(65)",@"已下架(15)"]];
    con.frame = frame(70, NavHeight +7, ksWidth - 140, 30);
    con.selectedSegmentIndex = 0;
    [con addTarget:self action:@selector(segCChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:con];
    UIView *split = [UIView creatView:frame(0, NavHeight + 48.5, ksWidth, 0.5) inView:self.view bgColor:appBottomLineColor];
    _followArr = [[NSMutableArray alloc] init];
    _page = 1;
    _status = 0;
    [self getProduct];
    [self creatUI];
}

-(void)getProduct{
    [MioGetReq(api_getProduct, (@{@"page":[NSString stringWithFormat:@"%ld",(long)_page],@"product_status":[NSString stringWithFormat:@"%ld",(long)_status]})) success:^(NSDictionary *result){
        NSArray *data = [result objectForKey:@"data"];
        [_tableview.mj_footer endRefreshing];
        [_followArr addObjectsFromArray:data];
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
    return _followArr.count;
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
    MioProductModel *model = [MioProductModel mj_objectWithKeyValues:_followArr[indexPath.row]];
    cell.model = model;
    return cell;
}

- (void)clickModify:(MioProductModel *)model{
    
}
- (void)clickUpDown:(MioProductModel *)model{
    
}
- (void)clickDelete:(MioProductModel *)model{
    
}

@end
