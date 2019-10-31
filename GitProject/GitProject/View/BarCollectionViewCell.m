//
//  BarCollectionViewCell.m
//  GitProject
//
//  Created by mark on 2019/7/30.
//  Copyright © 2019 mark. All rights reserved.
//

#import "BarCollectionViewCell.h"
#import "DateValueFormatter.h"


@interface BarCollectionViewCell ()

@property(nonatomic, strong)BarChartView *barChartView;
@property(nonatomic, assign)NSInteger type;

@end



@implementation BarCollectionViewCell

+ (CGSize)cellSize {
    CGFloat width = kScreenWidth - 20;
    return CGSizeMake(width, width * 0.69f);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        ViewBorderRadius(self, 6, 1, [UIColor whiteColor]);
        self.backgroundColor = [UIColor whiteColor];
        self.type = 1;
        [self.titleLab setText:@"交易时间分布"];
        [self.contentView addSubview:self.barChartView];
        [self setBarChartX];
        [self setBarChartY];
        [self loadDataWithType:self.type];
    }
    return self;
}

#pragma mark- 柱状图
- (BarChartView *)barChartView {
    if (_barChartView == nil) {
        _barChartView= [[BarChartView alloc] init];
        _barChartView.backgroundColor = [UIColor clearColor];
        _barChartView.noDataText = @"暂无数据";//没有数据时的文字提示
        _barChartView.drawValueAboveBarEnabled = YES;//数值显示在柱形的上面还是下面
        _barChartView.drawBarShadowEnabled = NO;//是否绘制柱形的阴影背景
        _barChartView.scaleYEnabled = NO;//取消Y轴缩放
        _barChartView.doubleTapToZoomEnabled = NO;//取消双击缩放
        _barChartView.dragEnabled = NO;//启用拖拽图表
        _barChartView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
        _barChartView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
//        _barChartView.xAxis.valueFormatter = self;
        _barChartView.legend.enabled = NO;//不显示图例说明
        _barChartView.rightAxis.enabled = NO;
        
        ViewBorderRadius(_barChartView, 1, 3, [UIColor clearColor]);
//        [_barChartView tab_startAnimation];

        /*
         ChartLimitLine *limitLine = [[ChartLimitLine alloc] initWithLimit:80 label:@"限制线"];
         limitLine.lineWidth = 2;
         limitLine.lineColor = [UIColor greenColor];
         limitLine.lineDashLengths = @[@5.0f, @5.0f];//虚线样式
         limitLine.labelPosition = ChartLimitLabelPositionTopRight;//位置
         [leftAxis addLimitLine:limitLine];//添加到Y轴上
         leftAxis.drawLimitLinesBehindDataEnabled = YES;//设置限制线绘制在柱形图的后面*/
        
    }
    return  _barChartView;
}

#pragma mark- 设置X轴
- (void)setBarChartX {
    ChartXAxis *xAxis = self.barChartView.xAxis;
    xAxis.axisLineWidth = 0.0f;//设置X轴线宽
    xAxis.labelPosition = XAxisLabelPositionBottom;//X轴的显示位置，默认是显示在上面的
    xAxis.drawGridLinesEnabled = NO;//不绘制网格线
    xAxis.forceLabelsEnabled = YES;
    xAxis.centerAxisLabelsEnabled = NO;
    xAxis.labelTextColor = [UIColor blackColor];//label文字颜色
    xAxis.labelFont = [UIFont systemFontOfSize:8];
    xAxis.yOffset = 16.0f;
}

- (void)setBarChartY {
    ChartYAxis *leftAxis = self.barChartView.leftAxis;//获取左边Y轴
    leftAxis.inverted = NO;//是否将Y轴进行上下翻转
    leftAxis.axisLineWidth = 1;//Y轴线宽
    leftAxis.forceLabelsEnabled = YES;
    leftAxis.axisLineColor = [UIColor clearColor];//Y轴颜色
    leftAxis.axisMinimum = 0;
    leftAxis.gridLineDashLengths = @[@3.0f, @3.0f];//设置虚线样式的网格线
    leftAxis.gridColor = [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1];//网格线颜色
    leftAxis.gridAntialiasEnabled = YES;//开启抗锯齿
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat height = self.contentView.bounds.size.height;
    self.barChartView.frame = CGRectMake(10, CGRectGetMaxY(self.titleLab.frame) + 10, self.contentView.bounds.size.width - 20, height - 60);
}

#pragma mark- 随机数据
- (NSArray <BarChartDataEntry *> *)dataWithType:(NSInteger)type {
    NSMutableArray <BarChartDataEntry *> *yValues = [[NSMutableArray alloc]init];
    NSInteger xCount = 25;
    if (type == 0) {
        xCount = 25;
    }
    else if (type == 1) {
        xCount = 7;
    }
    else {
        xCount = [self getMonthDay];
    }
    for (int i = 0; i < xCount; i ++) {
        double y = (arc4random_uniform(100));
        BarChartDataEntry *yEntry = [[BarChartDataEntry alloc] initWithX:i y:y];
        [yValues addObject:yEntry];
    }
    return yValues;
}

#pragma mark- 加载数据
- (void)loadDataWithType:(NSInteger)type {
    NSArray <BarChartDataEntry *> *yValues = [self dataWithType:type];
    BarChartDataSet *set1 = [[BarChartDataSet alloc]initWithEntries:yValues label:@"data set"];
    set1.axisDependency = AxisDependencyLeft;
    //不在面板上直接显示数值
    set1.drawValuesEnabled = NO;
    set1.highlightEnabled = NO;
    [set1 setColor:RGB(41, 155, 255)];
    
    
    // 赋值数据
    BarChartData *data = [[BarChartData alloc] initWithDataSet:set1];
    self.barChartView.xAxis.valueFormatter = [[DateValueFormatter alloc]initWithType:self.type];
    self.barChartView.data = data;
    self.barChartView.xAxis.labelCount = yValues.count;
    self.barChartView.leftAxis.labelCount = 6;
}

#pragma mark- 获取当月天数
- (NSUInteger)getMonthDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
    NSUInteger numberOfDaysInMonth = range.length;
    return numberOfDaysInMonth;
}


@end
