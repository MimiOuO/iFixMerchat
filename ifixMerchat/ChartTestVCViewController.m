//
//  ChartTestVCViewController.m
//  ifixMerchat
//
//  Created by Mimio on 2020/4/7.
//  Copyright © 2020 Mimio. All rights reserved.
//

#import "ChartTestVCViewController.h"
#import <AAChartKit.h>
@interface ChartTestVCViewController ()
@property (nonatomic, strong) AAChartView *aaChartView;
@property (nonatomic, strong) NSMutableArray *dateArr;
@property (nonatomic, strong) NSMutableArray *numberArr;
@end

@implementation ChartTestVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navView.leftButton setImage:backArrowIcon forState:UIControlStateNormal];
    [self.navView.centerButton setTitle:@"图表" forState:UIControlStateNormal];
    _dateArr = [[NSMutableArray alloc] init];
    _numberArr = [[NSMutableArray alloc] init];
    [self creatChart];
    
    [self getData];
}

-(void)getData{
    [MioGetReq(api_orderData, @{@"k":@"v"}) success:^(NSDictionary *result){
        NSArray *data = [result objectForKey:@"data"];
        for (NSDictionary *dic in data) {
            [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                NSLog(@"%@",key);
                [_dateArr addObject:key];
                [_numberArr addObject:obj];
                [self setupChartModel];
            }];
        
        }
        
    } failure:^(NSString *errorInfo) {}];
}

-(void)creatChart{
    UISegmentedControl *con =  [[UISegmentedControl alloc] initWithItems:@[@"订单",@"访客",@"收入"]];//[[UISegmentedControl alloc] initWithFrame:frame(100, NavHeight +10, ksWidth - 200, 30)];
    con.frame = frame(50, NavHeight +10, ksWidth - 100, 30);
    con.selectedSegmentIndex = 1;
    [self.view addSubview:con];
    
    CGFloat chartViewWidth  = self.view.frame.size.width;
    CGFloat chartViewHeight = self.view.frame.size.height-250;
    _aaChartView = [[AAChartView alloc]init];
    _aaChartView.frame = CGRectMake(0, NavHeight + 100, chartViewWidth, chartViewHeight);
    ////禁用 AAChartView 滚动效果(默认不禁用)
    //self.aaChartView.scrollEnabled = NO;
    ////设置图表视图的内容高度(默认 contentHeight 和 AAChartView 的高度相同)
    //_aaChartView.contentHeight = chartViewHeight;
    [self.view addSubview:_aaChartView];
}

-(void)setupChartModel{
    AAChartModel *aaChartModel= AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeColumn)//设置图表的类型(这里以设置的为折线面积图为例)
    .titleSet(@"")//设置图表标题
    .subtitleSet(@"")//设置图表副标题
    .categoriesSet(_dateArr)//图表横轴的内容
    .yAxisTitleSet(@"")//设置图表 y 轴的单位
    .yAxisAllowDecimalsSet(NO)
    .legendEnabledSet(NO)
    .seriesSet(@[
            AAObject(AASeriesElement)
//            .nameSet(@"")
            .dataSet(_numberArr),

    ]);
//    AAOptions *aaOptions = [AAOptionsConstructor configureChartOptionsWithAAChartModel:aaChartModel];
//    aaOptions.yAxis.minSet(@0)
//    .maxSet(@38);
    [_aaChartView aa_drawChartWithChartModel:aaChartModel];
}

@end
