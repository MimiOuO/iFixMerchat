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
@end

@implementation ChartTestVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navView.leftButton setImage:backArrowIcon forState:UIControlStateNormal];
    [self.navView.centerButton setTitle:@"图表" forState:UIControlStateNormal];
    [self creatChart];
    [self setupChartModel];
}

-(void)creatChart{
    UISegmentedControl *con =  [[UISegmentedControl alloc] initWithItems:@[@"订单",@"访客",@"收藏",@"收入"]];//[[UISegmentedControl alloc] initWithFrame:frame(100, NavHeight +10, ksWidth - 200, 30)];
    con.frame = frame(50, NavHeight +10, ksWidth - 100, 40);
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
    .categoriesSet(@[@"1",@"2",@"3",@"4", @"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14", @"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24", @"25",@"26",@"27",@"28",@"29",@"30"])//图表横轴的内容
    .yAxisTitleSet(@"")//设置图表 y 轴的单位
    .yAxisAllowDecimalsSet(NO)
    .legendEnabledSet(NO)
    .seriesSet(@[
            AAObject(AASeriesElement)
//            .nameSet(@"")
            .dataSet(@[@0, @0,@0,@0,@0,@0,@0,@0,@0,@0, @0, @0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0]),

    ]);
//    AAOptions *aaOptions = [AAOptionsConstructor configureChartOptionsWithAAChartModel:aaChartModel];
//    aaOptions.yAxis.minSet(@0)
//    .maxSet(@38);
    [_aaChartView aa_drawChartWithChartModel:aaChartModel];
}

@end
