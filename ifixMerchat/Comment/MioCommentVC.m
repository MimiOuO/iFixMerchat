//
//  MioCommentVC.m
//  ifixMerchat
//
//  Created by Mimio on 2020/4/8.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import "MioCommentVC.h"
#import "MioCommentCell.h"
@interface MioCommentVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *commentTable;
@property (nonatomic, assign) int page;
@end

@implementation MioCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navView.leftButton setImage:backArrowIcon forState:UIControlStateNormal];
    [self.navView.centerButton setTitle:@"全部评论" forState:UIControlStateNormal];
    
    _commentTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NavHeight, ksWidth, ksHeight)];
    _commentTable.delegate = self;
    _commentTable.dataSource = self;
    _commentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_commentTable];
    _commentTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page = _page + 1;
        [self requestComment];
    }];
    _page = 1;
    
    [self requestComment];
}

-(void)requestComment{
    [MioGetReq(api_base, @{@"k":@"v"}) success:^(NSDictionary *result){
        NSDictionary *data = [result objectForKey:@"data"];
        
    } failure:^(NSString *errorInfo) {}];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    MioCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MioCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

@end
