//
//  LineChartCollectionViewCell.m
//  GitProject
//
//  Created by mark on 2019/9/2.
//  Copyright © 2019 mark. All rights reserved.
//

#import "LineChartCollectionViewCell.h"
#import "DateValueFormatter.h"
#import "SymbolsValueFormatter.h"

@interface LineChartCollectionViewCell ()<ChartViewDelegate>

@property (nonatomic,strong)LineChartView * lineView;//折线图
@property(nonatomic, strong)UILabel *markY;
@property(nonatomic, assign)NSInteger type;

@end

@implementation LineChartCollectionViewCell

+ (CGSize)cellSize {
    CGFloat width = kScreenWidth - 20;
    return CGSizeMake(width, width * 0.69f);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setIsHidden:YES];
        self.type = 1;
        [self.titleLab setText:@"折线图"];
        [self.contentView addSubview:self.lineView];
        [self loadDataWithType:self.type];
    }
    return self;
}

- (LineChartView *)lineView {
    if (_lineView == nil) {
        _lineView = [[LineChartView alloc] init];
        _lineView.delegate = self;
        _lineView.backgroundColor = [UIColor clearColor];
        _lineView.noDataText = @"暂无数据";//没有数据时的文字提示
        _lineView.drawMarkers = YES;
        _lineView.scaleYEnabled = NO;//取消Y轴缩放
        _lineView.doubleTapToZoomEnabled = NO;//取消双击缩放
        _lineView.dragEnabled = YES;//启用拖拽图表
        _lineView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
        _lineView.dragDecelerationFrictionCoef = 0.9;
        _lineView.legend.enabled = NO;
        _lineView.rightAxis.enabled = NO;
        
        ViewBorderRadius(_lineView, 1, 3, [UIColor clearColor]);
        
        BalloonMarker *marker = [[BalloonMarker alloc]
                                 initWithColor: [UIColor whiteColor]
                                 font: [UIFont systemFontOfSize:12.0]
                                 textColor:[UIColor blackColor]
                                 insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)];
        marker.chartView = _lineView;
        marker.minimumSize = CGSizeMake(80.f, 40.f);
        _lineView.marker = marker;
     
        [self lineChartX];
        [self lineChartY];
        _lineView.maxVisibleCount = 999;//
        [_lineView animateWithXAxisDuration:1.0f];
    }
    return _lineView;
}

- (UILabel *)markY{
    if (!_markY) {
        _markY = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 35, 25)];
        _markY.font = [UIFont systemFontOfSize:15.0];
        _markY.textAlignment = NSTextAlignmentCenter;
        _markY.text =@"";
        _markY.textColor = [UIColor redColor];
        _markY.backgroundColor = [UIColor grayColor];
    }
    return _markY;
}

#pragma mark- 设置X轴
- (void)lineChartX {
    ChartXAxis *xAxis = self.lineView.xAxis;
    xAxis.axisLineWidth = 0.0f;
    xAxis.granularityEnabled = YES;//设置重复的值不显示
    xAxis.labelPosition= XAxisLabelPositionBottom;//设置x轴数据在底部
    xAxis.drawGridLinesEnabled = NO;
    xAxis.axisLineColor = [UIColor grayColor];
    xAxis.labelTextColor = [UIColor blackColor];//label文字颜色
    xAxis.labelFont = [UIFont systemFontOfSize:8];
    xAxis.yOffset = 16.0f;
}

#pragma mark- 设置Y轴
- (void)lineChartY {
    ChartYAxis *leftAxis = self.lineView.leftAxis;//获取左边Y轴
    leftAxis.axisLineWidth = 1;//Y轴线宽
    leftAxis.inverted = NO;//是否将Y轴进行上下翻转
    leftAxis.axisLineColor = [UIColor clearColor];//Y轴颜色
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;//label位置
    leftAxis.labelTextColor = [UIColor blackColor];//文字颜色
    leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];//文字字体
    leftAxis.gridAntialiasEnabled = NO;//开启抗锯齿
    leftAxis.gridLineDashLengths = @[@3.0f, @3.0f];//设置虚线样式的网格线
    leftAxis.gridColor = [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1];//网格线颜色
    leftAxis.valueFormatter = [[SymbolsValueFormatter alloc]init];
}

- (NSArray <ChartDataEntry *> *)dataWithType:(NSInteger)type {
    NSMutableArray <ChartDataEntry *> *yValues = [[NSMutableArray alloc]init];
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
        ChartDataEntry *yEntry = [[ChartDataEntry alloc] initWithX:i y:y];
        [yValues addObject:yEntry];
    }
    return yValues;
}

#pragma mark- 产生随机立柱数据
- (void)loadDataWithType:(NSInteger)type {
    NSArray <ChartDataEntry *> *dataArr = [self dataWithType:type];
    LineChartDataSet *set1 = [[LineChartDataSet alloc]initWithEntries:dataArr];
    set1.lineWidth = 2.0/[UIScreen mainScreen].scale;
    set1.axisDependency = AxisDependencyLeft;
    [set1 setCircleRadius:3.0f];
    [set1 setCircleHoleColor:[UIColor redColor]];
    //不在面板上直接显示数值
    set1.drawValuesEnabled = NO;
    set1.highlightEnabled = NO;
    [set1 setDrawCirclesEnabled:YES];
    [set1 setCircleColor:[UIColor redColor]];
    [set1 setColor:[UIColor purpleColor]];//折线颜色
    
    //折线的颜色填充样式
    //第一种填充样式:单色填充
    //        set1.drawFilledEnabled = YES;//是否填充颜色
    //        set1.fillColor = [UIColor redColor];//填充颜色
    //        set1.fillAlpha = 0.3;//填充颜色的透明度
    
    //第二种填充样式:渐变填充
    set1.drawFilledEnabled = YES;//是否填充颜色
    NSArray *gradientColors = @[(id)[ChartColorTemplates colorFromString:@"#FFFFFFFF"].CGColor,
                                (id)[ChartColorTemplates colorFromString:@"#FF007FFF"].CGColor];
    CGGradientRef gradientRef = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
    set1.fillAlpha = 0.3f;//透明度
    set1.fill = [ChartFill fillWithLinearGradient:gradientRef angle:90.0f];//赋值填充颜色对象
    CGGradientRelease(gradientRef);//释放gradientRef
    
    //点击选中拐点的交互样式
    set1.highlightEnabled = YES;//选中拐点,是否开启高亮效果(显示十字线)
    set1.highlightColor = [UIColor redColor];//点击选中拐点的十字线的颜色
    set1.highlightLineWidth = 1.0/[UIScreen mainScreen].scale;//十字线宽度
    set1.highlightLineDashLengths = @[@5, @5];//十字线的虚线样式
    
    LineChartData *data = [[LineChartData alloc]initWithDataSet:set1];
    self.lineView.leftAxis.axisMinimum = 0;
    self.lineView.leftAxis.axisMaximum = 200;
    self.lineView.leftAxis.labelCount = 6;
    self.lineView.leftAxis.forceLabelsEnabled = YES;
    self.lineView.xAxis.valueFormatter = [[DateValueFormatter alloc]initWithType:self.type];
    self.lineView.xAxis.labelCount = dataArr.count;
    self.lineView.data = data;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat height = self.contentView.bounds.size.height;
    self.lineView.frame = CGRectMake(10, CGRectGetMaxY(self.titleLab.frame) + 10, self.contentView.bounds.size.width - 20, height - 60);
//    ViewBorderRadius(self.lineView, 1, 3, [UIColor RandomColor]);
}

- (void)chartValueSelected:(ChartViewBase * _Nonnull)chartView entry:(ChartDataEntry * _Nonnull)entry highlight:(ChartHighlight * _Nonnull)highlight {
    NSLog(@"didSelected X:%.2f  Y:%.2f ", entry.x, entry.y);
//    self.markY.text = [NSString stringWithFormat:@"%ld%%",(NSInteger)entry.y];
    //将点击的数据滑动到中间
//    [self.lineView centerViewToAnimatedWithXValue:entry.x yValue:entry.y axis:[_lineView.data getDataSetByIndex:highlight.dataSetIndex].axisDependency duration:1.0];
}

#pragma mark- 获取当月天数
- (NSUInteger)getMonthDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
    NSUInteger numberOfDaysInMonth = range.length;
    return numberOfDaysInMonth;
}


@end
