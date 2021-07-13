//
//  MioBillVC.m
//  DuoDuoPeiwan
//
//  Created by Mimio on 2019/9/17.
//  Copyright © 2019 Brance. All rights reserved.
//

#import "MioBillVC.h"
#import "MioBillCell.h"
@interface MioBillVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *billTable;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *billArr;
@end

@implementation MioBillVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navView.leftButton setImage:backArrowIcon forState:UIControlStateNormal];
    [self.navView.centerButton setTitle:@"账单" forState:UIControlStateNormal];
    
    _page = 1;
    _billArr = [[NSMutableArray alloc] init];
    
    _billTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NavHeight, ksWidth, ksHeight - NavHeight)];
    _billTable.delegate = self;
    _billTable.dataSource = self;
    _billTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _billTable.backgroundColor = appbgColor;
    _billTable.tableHeaderView = [[UIView alloc] initWithFrame:frame(0, 0, ksWidth, 10)];
    _billTable.ly_emptyView = [MioEmpty noDataEmpty];
    _billTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page = _page + 1;
        [self getBillData];
    }];
    [self.view addSubview:_billTable];
    
    [self getBillData];
}

-(void)getBillData{

    NSDictionary *dic = @{
                          @"page":[NSString stringWithFormat:@"%ld",(long)_page],
                          };
    
    MioGetRequest *request = [[MioGetRequest alloc] initWithRequestUrl:api_BillLog argument:dic];
    
    [request success:^(NSDictionary *result) {
        [_billTable.mj_footer endRefreshing];
        NSArray *data = [result objectForKey:@"data"];
        if (data.count < 10) {
            [_billTable.mj_footer endRefreshingWithNoMoreData];
        }
        [_billArr addObjectsFromArray:data];
        [_billTable reloadData];
    } failure:^(NSString *errorInfo) {
        
        
    }];
}

#pragma mark - delegate&datasoure
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _billArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    MioBillCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MioBillCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.data = _billArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
