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
    CGFloat chartViewWidth  = self.view.frame.size.width;
    CGFloat chartViewHeight = self.view.frame.size.height-250;
    _aaChartView = [[AAChartView alloc]init];
    _aaChartView.frame = CGRectMake(0, 60, chartViewWidth, chartViewHeight);
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
    .categoriesSet(@[@"1",@"2",@"3",@"4", @"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14", @"15",@"16",@"17",@"18",@"19",@"20"@"21",@"22",@"23",@"24", @"25",@"26",@"27",@"28",@"29",@"30"])//图表横轴的内容
    .yAxisTitleSet(@"")//设置图表 y 轴的单位
    .seriesSet(@[
            AAObject(AASeriesElement)
            .nameSet(@"订单数量")
            .dataSet(@[@0, @6.9, @9.5, @14.5, @18.2, @11.5, @25.2, @26.5, @23.3, @18.3, @13.9, @9.6,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0]),
//            AAObject(AASeriesElement)
//            .nameSet(@"2018")
//            .dataSet(@[@0.2, @0.8, @5.7, @11.3, @17.0, @22.0, @24.8, @24.1, @20.1, @14.1, @8.6, @2.5]),
//            AAObject(AASeriesElement)
//            .nameSet(@"2019")
//            .dataSet(@[@0.9, @0.6, @3.5, @8.4, @13.5, @17.0, @18.6, @17.9, @14.3, @9.0, @3.9, @1.0]),
//            AAObject(AASeriesElement)
//            .nameSet(@"2020")
//            .dataSet(@[@3.9, @4.2, @5.7, @8.5, @11.9, @15.2, @17.0, @16.6, @14.2, @10.3, @6.6, @4.8]),
    ]);
    [_aaChartView aa_drawChartWithChartModel:aaChartModel];
}

@end
