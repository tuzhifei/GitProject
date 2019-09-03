//
//  PieCollectionViewCell.m
//  GitProject
//
//  Created by mark on 2019/7/30.
//  Copyright © 2019 mark. All rights reserved.
//

#import "PieCollectionViewCell.h"
#import "GitProject-Bridging-Header.h"
#import "GitProject-Swift.h"
#import "PurchaseModel.h"
#import "CountTableViewCell.h"
#import "PurchaseModel.h"

typedef void(^SelectBlock)(NSInteger index);
@interface PieCollectionViewCell ()<UITableViewDelegate, UITableViewDataSource, ChartViewDelegate>

@property(nonatomic, copy)SelectBlock selectBlock;
@property(nonatomic, strong)PieChartView *pieChartView;
@property(nonatomic, strong) UITableView *leftTable;
@property(nonatomic, strong) UITableView *rightTable;
@property (nonatomic,copy)NSArray *pieAry;
@property(nonatomic, strong)NSArray <PurchaseModel *> *purchaseArr;
@property(nonatomic, strong)NSArray <PurchaseModel *> *leftArray;
@property(nonatomic, strong)NSArray <PurchaseModel *> *rightArray;


@end

@implementation PieCollectionViewCell

+ (CGSize)cellSize {
    CGFloat width = kScreenWidth - 20;
    return CGSizeMake(width, width * 0.69f);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.pieChartView];
//        [self.contentView addSubview:self.leftTable];
//        [self.contentView addSubview:self.rightTable];
    }
    return self;
}

- (PieChartView *)pieChartView {
    if (_pieChartView == nil) {
        _pieChartView = [[PieChartView alloc] init];
        _pieChartView.delegate = self;
        _pieChartView.backgroundColor = [UIColor clearColor];
        [_pieChartView setExtraOffsetsWithLeft:5.f top:10.f right:5.f bottom:5.f];
        _pieChartView.usePercentValuesEnabled = YES;//是否根据所提供的数据, 将显示数据转换为百分比格式
        _pieChartView.dragDecelerationEnabled = YES;//拖拽饼状图后是否有惯性效果
        _pieChartView.drawCenterTextEnabled = YES;//是否显示区块文本
        _pieChartView.dragDecelerationEnabled = NO;
        _pieChartView.drawHoleEnabled = YES;//饼状图是否是空心
        _pieChartView.holeRadiusPercent = 0.5;//空心半径占比
        _pieChartView.holeColor = [UIColor clearColor];//空心颜色
        _pieChartView.transparentCircleRadiusPercent = 0.52;//半透明空心半径占比
        _pieChartView.transparentCircleColor = [UIColor colorWithRed:210/255.0 green:145/255.0 blue:165/255.0 alpha:0.3];//半透明空心的颜色
        _pieChartView.noDataText = @"暂无数据";
        _pieChartView.noDataTextColor = [UIColor redColor];
        _pieChartView.entryLabelColor = [UIColor purpleColor];
        ViewBorderRadius(_pieChartView, 1, 3, [UIColor clearColor]);
        _pieChartView.drawCenterTextEnabled = YES;//是否绘制中间的文本
        NSString *text = @"我是中心";
        NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:text];
        NSDictionary *dic = @{NSForegroundColorAttributeName: [UIColor cyanColor],
                              NSFontAttributeName: [UIFont systemFontOfSize:12]};
        [attribute setAttributes:dic range:NSMakeRange(0, text.length)];
        _pieChartView.centerAttributedText = attribute;
        _pieChartView.legend.enabled = false;
    }
    return _pieChartView;
}

- (UITableView *)leftTable {
    if (_leftTable == nil) {
        _leftTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftTable.delegate = self;
        _leftTable.dataSource = self;
        _leftTable.rowHeight = 50;
        _leftTable.backgroundColor = [UIColor clearColor];
        _leftTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _leftTable.scrollEnabled = NO;
        //        ViewBorderRadius(_leftTable, 1, 3, [UIColor RandomColor]);
    }
    return _leftTable;
}

- (UITableView *)rightTable {
    if (_rightTable == nil) {
        _rightTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _rightTable.delegate = self;
        _rightTable.dataSource = self;
        _rightTable.rowHeight = 50;
        _rightTable.backgroundColor = [UIColor clearColor];
        _rightTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _rightTable.scrollEnabled = NO;
        //        ViewBorderRadius(_rightTable, 1, 3, [UIColor RandomColor]);
    }
    return _rightTable;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.leftTable) {
        static NSString *reuseId = @"CountTableViewCell";
        CountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
        if (cell == nil) {
            cell = [[CountTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        if (self.purchaseArr.count != 0) {
            PurchaseModel *model = self.purchaseArr[indexPath.row];
            [cell configWithModel:model];
        }
        return cell;
    } else {
        static NSString *reuseIdTwo = @"CountTableViewCell";
        CountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdTwo];
        if (cell == nil) {
            cell = [[CountTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdTwo];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        [cell setIsRight:YES];
        if (self.purchaseArr.count > 3) {
            PurchaseModel *model = self.purchaseArr[indexPath.row + 3];
            [cell configWithModel:model];
        }
        return cell;
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.contentView.bounds.size.width;
    CGFloat height = self.contentView.bounds.size.height;
    self.pieChartView.frame = CGRectMake(10, self.titleLab.bottom + 10, width  - 20, height - self.titleLab.bottom - 10);
//    ViewBorderRadius(self.pieChartView, 1, 3, [UIColor RandomColor]);
}

//- (void)reloadWithDataArray:(NSArray <PieModel*> *)dataSource {
//    self.pieAry = [NSArray new];
//    self.pieAry = [NSArray arrayWithArray:dataSource];
//    [self dataWithSource:dataSource];
//    [self.tableView reloadData];
//}

- (void)reloadWithModel:(NSArray <PurchaseModel*> *)modelArray {
    self.purchaseArr = [[NSArray alloc]init];
    self.purchaseArr = [NSArray arrayWithArray:modelArray];
    [self dataWithSource:modelArray buttonType:0];
    [self.leftTable reloadData];
    [self.rightTable reloadData];
}

- (void)dataWithSource:(NSArray <PurchaseModel *> *)dataSource buttonType:(NSInteger) type{
    NSMutableArray <PieChartDataEntry *> *values = [[NSMutableArray alloc] init];
    NSMutableArray <UIColor *> *colors = [[NSMutableArray alloc] init];
    NSMutableArray <PurchaseModel *> *pieArr = [NSMutableArray arrayWithArray:dataSource];
    PieChartDataEntry *entry = nil;
    CGFloat sumCount = 0;
    if (type == 0) {
        for (int i = 0; i < pieArr.count; i++) {
            PurchaseModel *model = pieArr[i];
            sumCount = sumCount + model.amount;
            CGFloat percent = model.amount/sumCount;
            model.percent = percent;
            //NSString *legendStr = [NSString stringWithFormat:@"%@  |   %.1f%%", model.purchase_type_name, model.percent * 100];
            [colors addObject:model.color];
            entry = [[PieChartDataEntry alloc]initWithValue:model.amount label:model.purchase_type_name];
            [values addObject:entry];
        }
        
    } else {
        for (int i = 0; i < pieArr.count; i++) {
            PurchaseModel *model = pieArr[i];
            sumCount = sumCount + model.count;
            CGFloat percent = model.count/sumCount;
            model.percent = percent;
            [colors addObject:model.color];
            entry = [[PieChartDataEntry alloc]initWithValue:model.count label:model.purchase_type_name];
            [values addObject:entry];
        }
    }
    if (sumCount != 0) {
        PieChartDataSet *dataSet = [[PieChartDataSet alloc]initWithEntries:values label:@""];
        /* 设置每块扇形区块的颜色 */
        dataSet.colors = colors;
        dataSet.sliceSpace = 3.0f; //相邻区块之间的间距
        dataSet.selectionShift = 8;//选中区块时, 放大的半径
        dataSet.drawIconsEnabled = NO; //扇形区块是否显示图片
        dataSet.entryLabelColor = [UIColor whiteColor];//每块扇形文字描述的颜色
        dataSet.entryLabelFont = [UIFont systemFontOfSize:8];//每块扇形的文字字体大小
        dataSet.valueFont = [UIFont systemFontOfSize:10];//每块扇形数值的字体大小
        dataSet.drawValuesEnabled = YES;//是否显示每块扇形的数值
        //折线
        dataSet.xValuePosition = PieChartValuePositionInsideSlice;//文字的位置
        dataSet.yValuePosition = PieChartValuePositionOutsideSlice;//数值的位置，只有在外面的时候，折线才有用
        dataSet.valueLinePart1OffsetPercentage = 0.5; //折线中第一段起始位置相对于区块的偏移量, 数值越大, 折线距离区块越远
        dataSet.valueLinePart1Length = 0.4;//折线中第一段长度占比
        dataSet.valueLinePart2Length = 0.6;//折线中第二段长度占比
        dataSet.valueLineWidth = 1;//折线的粗细
        dataSet.valueLineColor = [UIColor brownColor];//折线颜色
        dataSet.valueTextColor = [UIColor redColor];
        //设置每块扇形数值的格式
        NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
        pFormatter.numberStyle = NSNumberFormatterPercentStyle;
        pFormatter.maximumFractionDigits = 1;
        pFormatter.multiplier = @1.f;
        pFormatter.percentSymbol = @" %";
        dataSet.valueFormatter = [[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter];
        
        PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
        self.pieChartView.data = data;
        
    } else {
        //        self.pieChartView.data = nil;
        //        self.pieChartView.noDataText = @"暂无数据";
        PieChartDataEntry *entryTwo = [[PieChartDataEntry alloc]initWithValue:1 label:@""];
        PieChartDataSet *dataSet = [[PieChartDataSet alloc]initWithEntries:@[entryTwo] label:@""];
        dataSet.drawValuesEnabled = NO;
        dataSet.colors = @[[UIColor lightGrayColor]];
        PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
        self.pieChartView.data = data;
    }
    //    self.pieChartView.rotationAngle = 0.0;case linear
    
   
    
    [self.pieChartView animateWithXAxisDuration:0.5f easingOption:ChartEasingOptionLinear];//设置动画效果
    
}



@end
