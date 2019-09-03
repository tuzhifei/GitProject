//
//  LineChartCollectionViewCell.m
//  GitProject
//
//  Created by mark on 2019/9/2.
//  Copyright © 2019 mark. All rights reserved.
//

#import "LineChartCollectionViewCell.h"
#import "GitProject-Bridging-Header.h"
#import "GitProject-Swift.h"

@interface LineChartCollectionViewCell ()<IChartAxisValueFormatter, ChartViewDelegate>

@property (nonatomic,strong) LineChartView * lineView;//折线图
@property (nonatomic,strong) UILabel * markY;
@property (nonatomic, strong) LineChartDataSet *set1;//折线
@property (nonatomic, strong) LineChartDataSet *set2;
@property(nonatomic, strong)NSMutableArray *xValue;
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
        [self setBarChartX];
        [self setBarChartY];
        self.lineView.data = [self setData];
    }
    return self;
}

- (LineChartView *)lineView {
    if (_lineView == nil) {
        _lineView= [[LineChartView alloc] init];
        _lineView.backgroundColor = [UIColor clearColor];
        _lineView.noDataText = @"暂无数据";//没有数据时的文字提示
        _lineView.scaleYEnabled = NO;//取消Y轴缩放
        _lineView.doubleTapToZoomEnabled = NO;//取消双击缩放
        _lineView.dragEnabled = NO;//启用拖拽图表
        _lineView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
        _lineView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
        _lineView.xAxis.valueFormatter = self;
        _lineView.legend.enabled = NO;//不显示图例说明
        _lineView.rightAxis.enabled = NO;
        
        ViewBorderRadius(_lineView, 1, 3, [UIColor clearColor]);
        
        //设置滑动时候标签
//        ChartMarkerView *markerY = [[ChartMarkerView alloc]
//                                    init];
//        markerY.offset = CGPointMake(-999, -8);
//        markerY.chartView = _lineView;
//        _lineView.marker = markerY;
//        [markerY addSubview:self.markY];
     
//        BalloonMarker *marker = [[BalloonMarker alloc]
//                                 initWithColor: [UIColor colorWithWhite:180/255. alpha:1.0]
//                                 font: [UIFont systemFontOfSize:12.0]
//                                 textColor: UIColor.whiteColor
//                                 insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)];
//        marker.chartView = _lineView;
//        marker.minimumSize = CGSizeMake(80.f, 40.f);
//        _lineView.marker = marker;
        //        _lineView.legend.form = ChartLegendFormLine;
        
        [self.lineView animateWithXAxisDuration:1.0f];
        
    }
    return _lineView;
}

#pragma mark- 设置X轴
- (void)setBarChartX {
    ChartXAxis *xAxis = self.lineView.xAxis;
    xAxis.axisLineWidth = 0.0f;//设置X轴线宽
    xAxis.labelPosition = XAxisLabelPositionBottom;//X轴的显示位置，默认是显示在上面的
    xAxis.drawGridLinesEnabled = NO;//不绘制网格线
    xAxis.labelTextColor = [UIColor blackColor];
    xAxis.labelFont = [UIFont systemFontOfSize:7];
    xAxis.yOffset = 16.0f;
}

- (void)setBarChartY {
    ChartYAxis *leftAxis = self.lineView.leftAxis;//获取左边Y轴
    leftAxis.inverted = NO;//是否将Y轴进行上下翻转
    leftAxis.axisLineWidth = 1;//Y轴线宽
    leftAxis.forceLabelsEnabled = YES;
    leftAxis.axisLineColor = [UIColor clearColor];//Y轴颜色
    leftAxis.axisMinimum = 0;
    leftAxis.gridLineDashLengths = @[@3.0f, @3.0f];//设置虚线样式的网格线
    leftAxis.gridColor = [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1];//网格线颜色
    leftAxis.gridAntialiasEnabled = YES;//开启抗锯齿
}


- (LineChartData *)setData{
    
//    double maxYVal = 100;//Y轴的最大值
    [self.xValue removeAllObjects];
    
    switch (self.type) {
        case 0:
        {
            for (int i = 0; i < 25; i ++) {
                NSString *dayStr = [NSString stringWithFormat:@"%02d:00", i];
                [self.xValue addObject:dayStr];
            }
            
        }
            break;
            
        case 1:
        {
            [self.xValue addObjectsFromArray:@[@"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日"]];
        }
            break;
            
        case 2:
        {
            NSUInteger day = [self getMonthDay];
            for (int i = 0; i < day; i ++) {
                NSString *dataStr = [NSString stringWithFormat:@"%d", i+1];
                [self.xValue addObject:dataStr];
            }
        }
            break;
            
        default:
            break;
    }
    NSInteger xCount = self.xValue.count;
    //对应Y轴上面需要显示的数据
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < xCount; i++) {
//        double mult = maxYVal + 1;
        double val = (double)(arc4random_uniform(200));
        ChartDataEntry *yEntry = [[ChartDataEntry alloc] initWithX:i y:val];
        [yVals addObject:yEntry];
    }
    
    LineChartDataSet *set1 = [[LineChartDataSet alloc]initWithEntries:yVals];
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
    
    //将 LineChartDataSet 对象放入数组中
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    
    LineChartData *data = [[LineChartData alloc]initWithDataSets:dataSets];
    if (self.type != 1) {
        self.lineView.xAxis.labelCount = xCount;
    }
    self.lineView.leftAxis.labelCount = 6;
    self.lineView.leftAxis.axisMaximum = 200;
    self.lineView.leftAxis.axisMinimum = 0;
    self.lineView.leftAxis.forceLabelsEnabled = YES;
    self.lineView.data = data;
    return data;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat height = self.contentView.bounds.size.height;
    self.lineView.frame = CGRectMake(10, CGRectGetMaxY(self.titleLab.frame) + 10, self.contentView.bounds.size.width - 20, height - 60);
//    ViewBorderRadius(self.lineView, 1, 3, [UIColor RandomColor]);
}

- (NSMutableArray *)xValue {
    if (_xValue == nil) {
        _xValue = [[NSMutableArray alloc]init];
    }
    return _xValue;
}

#pragma mark- 获取当月天数
- (NSUInteger)getMonthDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
    NSUInteger numberOfDaysInMonth = range.length;
    return numberOfDaysInMonth;
}

- (NSString * _Nonnull)stringForValue:(double)value axis:(ChartAxisBase * _Nullable)axis {
    NSString *xAxisStringValue = @"";
    int myInt = (int)value;
    if (self.type == 0) {
        if (myInt % 4 == 0) {
            xAxisStringValue = [self.xValue objectAtIndex:myInt];
        }
    } else if (self.type == 1) {
        NSLog(@" %d %@ %@", myInt, self.xValue[myInt], self.xValue);
        xAxisStringValue = [self.xValue objectAtIndex:myInt];
    } else {
        int month = myInt + 1;
        NSInteger allDay = [self getMonthDay]; //总天数
        if (month == 1) {
            xAxisStringValue = [self.xValue objectAtIndex:0];
        }
        if (allDay == 30) {
            if (month % 6 == 0) {
                xAxisStringValue = [self.xValue objectAtIndex:myInt];
            }
        } else {
            if (month % 6 == 0) {
                xAxisStringValue = [self.xValue objectAtIndex:myInt];
            }
            if (allDay == 31) {
                if (month == 30) {
                    xAxisStringValue = @"";
                }
                if (month == 31) {
                    xAxisStringValue = [self.xValue objectAtIndex:myInt];
                }
            } else if (allDay == 28) {
                if (month == 28) {
                    xAxisStringValue = [self.xValue objectAtIndex:myInt];
                }
            } else if (allDay == 29) {
                if (month == 29) {
                    xAxisStringValue = [self.xValue objectAtIndex:myInt];
                }
            }
        }
    }
    return xAxisStringValue;
}


@end
