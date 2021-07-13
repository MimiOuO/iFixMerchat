//
//  MioInteractMessegeVC.m
//  DuoDuoPeiwan
//
//  Created by Mimio on 2019/10/18.
//  Copyright © 2019 Brance. All rights reserved.
//

#import "MioInteractMessegeVC.h"
#import "MioInteractMessegeCell.h"


@interface MioInteractMessegeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *listTable;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *messegeArr;
@end

@implementation MioInteractMessegeVC

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.navView.leftButton setImage:backArrowIcon forState:UIControlStateNormal];
    [self.navView.centerButton setTitle:@"互动消息" forState:UIControlStateNormal];
    
    _messegeArr = [[NSMutableArray alloc] init];
    _page = 1;
    [self getFollows];
    
    _listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NavHeight, ksWidth, ksHeight - NavHeight)];
    _listTable.dataSource = self;
    _listTable.delegate = self;
    _listTable.backgroundColor = appbgColor;
    [self.view addSubview:_listTable];
    _listTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    _listTable.mj_header = [MioRefreshHeader headerWithRefreshingBlock:^{
//        _page = 1;
//        [_messegeArr removeAllObjects];
//        [self getFollows];
//    }];
    _listTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page = _page + 1;
        [self getFollows];
    }];
}


#pragma mark - NetWork

-(void)getFollows{

    MioGetRequest *request = [[MioGetRequest alloc] initWithRequestUrl:api_InteractMessege argument:nil];
    
    [request success:^(NSDictionary *result) {
        [_listTable.mj_header endRefreshing];
        [_listTable.mj_footer endRefreshing];
        NSArray *data = [result objectForKey:@"data"];
        [_messegeArr addObjectsFromArray:data];
        [_listTable reloadData];
        if (data.count< 10) {
            [_listTable.mj_footer endRefreshingWithNoMoreData];
        }
        
    } failure:^(NSString *errorInfo) {
        
        
    }];
}



#pragma mark - datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _messegeArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 111;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    MioInteractMessegeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MioInteractMessegeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"11"];
    }
    cell.backgroundColor = appbgColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.data = _messegeArr[indexPath.row];
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    MioOrderDetailVC *vc = [[MioOrderDetailVC alloc] init];
//    vc.order_id = [_messegeArr[indexPath.row] objectForKey:@"game_id"];
//    [self.navigationController pushViewController:vc animated:YES];
//}


@end
