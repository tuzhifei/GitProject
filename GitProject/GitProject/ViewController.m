//
//  ViewController.m
//  GitProject
//
//  Created by mark on 2019/7/26.
//  Copyright © 2019 mark. All rights reserved.
//

#import "ViewController.h"
#import "PurchaseModel.h"
#import "PageCollectionView.h"
#import "CardCollectionViewCell.h"
#import "BarCollectionViewCell.h"
#import "PieCollectionViewCell.h"
#import "SKUCollectionViewCell.h"
#import "SaleRankModel.h"
#import "LineChartCollectionViewCell.h"
#import "CollectionViewController.h"
#define headHeight 90
@interface ViewController ()<UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate>
@property (nonatomic , assign) BOOL  isHover;
@property (nonatomic , assign) BOOL  isMidRefresh;
@property(nonatomic, strong)PageCollectionView *collectionView;
@property(nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic , strong)UIScrollView * scrollView;
@property(nonatomic, strong)UIView *headView;
@property(nonatomic, strong)UIView *buttonView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES];

    self.dataArray = [[NSMutableArray alloc]init];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.headView];
    [self.scrollView addSubview:self.buttonView];
    [self.scrollView addSubview:self.collectionView];
    
    // 启动动画
    [self.collectionView tab_startAnimation];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self afterGetData];
    });
}

-(UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, self.view.width, self.view.height - 20)];
        _scrollView.contentSize = CGSizeMake(self.view.width, self.view.height + headHeight);
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
//        ViewBorderRadius(_scrollView, 1, 3, [UIColor RandomColor]);
    }
    return _scrollView;
}

- (UIView *)headView {
    if (_headView == nil) {
        _headView = [[UIView alloc]init];
        _headView.frame = CGRectMake(0, 0, self.scrollView.bounds.size.width, headHeight);
        _headView.backgroundColor = [UIColor RandomColor];
//        ViewBorderRadius(_headView, 1, 3, [UIColor RandomColor]);
    }
    return _headView;
}

- (UIView *)buttonView {
    if (_buttonView == nil) {
        _buttonView = [[UIView alloc]init];
        _buttonView.frame = CGRectMake(20, headHeight + 10, self.scrollView.width - 40, 28);
        _buttonView.backgroundColor = [UIColor whiteColor];
        ViewBorderRadius(_buttonView, 14, .5f, [UIColor lightGrayColor]);
    }
    return _buttonView;
}

- (PageCollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat maxY = self.buttonView.bottom + 10;
        _collectionView = [[PageCollectionView alloc]initWithFrame:CGRectMake(0, maxY, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height - maxY + headHeight) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[CardCollectionViewCell class] forCellWithReuseIdentifier:[CardCollectionViewCell cellIdentifier]];
        [_collectionView registerClass:[BarCollectionViewCell class] forCellWithReuseIdentifier:[BarCollectionViewCell cellIdentifier]];
        [_collectionView registerClass:[PieCollectionViewCell class] forCellWithReuseIdentifier:[PieCollectionViewCell cellIdentifier]];
        [_collectionView registerClass:[SKUCollectionViewCell class] forCellWithReuseIdentifier:[SKUCollectionViewCell cellIdentifier]];
        [_collectionView registerClass:[LineChartCollectionViewCell class] forCellWithReuseIdentifier:[LineChartCollectionViewCell cellIdentifier]];

        //ViewBorderRadius(_collectionView, 1, 3, [UIColor RandomColor]);

        
//        NSArray *classArray = @[
//                                [CardCollectionViewCell class],
//                                [BarCollectionViewCell class],
//                                [PieCollectionViewCell class]
//                                ];
//        NSArray *sizeArray = @[
//                               [NSValue valueWithCGSize:[CardCollectionViewCell cellSize]],
//                               [NSValue valueWithCGSize:[BarCollectionViewCell cellSize]],
//                               [NSValue valueWithCGSize:[PieCollectionViewCell cellSize]],
//                               ];
        
//        _collectionView.tabAnimated = [TABCollectionAnimated
//                                       animatedWithCellClassArray:classArray
//                                       cellSizeArray:sizeArray
//                                       animatedCountArray:@[@(4), @(1), @(1)]];
//        _collectionView.tabAnimated = [TABCollectionAnimated animatedWithCellClassArray:classArray
//                                                                          cellSizeArray:sizeArray
//                                                                     animatedCountArray:@[@(4)]
//                                                                   animatedSectionArray:@[@(0)]];

        
   
    }
    return _collectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CardCollectionViewCell *cardCell = [CardCollectionViewCell cellWithIndexPath:indexPath atCollectionView:collectionView];
        return cardCell;
    } else if (indexPath.section == 1) {
        BarCollectionViewCell *barCell = [BarCollectionViewCell cellWithIndexPath:indexPath atCollectionView:collectionView];
        return barCell;
    } else if (indexPath.section == 2) {
        PieCollectionViewCell *pieCell = [PieCollectionViewCell cellWithIndexPath:indexPath atCollectionView:collectionView];
        [pieCell reloadWithModel:[self offViewData]];
        return pieCell;
    } else if (indexPath.section == 3) {
        LineChartCollectionViewCell *lineChartCell = [LineChartCollectionViewCell cellWithIndexPath:indexPath atCollectionView:collectionView];
        return lineChartCell;
    } else {
        SKUCollectionViewCell *skuCell = [SKUCollectionViewCell cellWithIndexPath:indexPath atCollectionView:collectionView];
        [skuCell reloadWithDataSource:[self skuData]];
        return skuCell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [CardCollectionViewCell cellSize];
    }
    else if (indexPath.section == 1) {
        return [BarCollectionViewCell cellSize];
    }
    else if (indexPath.section == 2) {
        return [PieCollectionViewCell cellSize];
    }
    else if (indexPath.section == 3) {
        return [LineChartCollectionViewCell cellSize];
    }
    else {
        return [SKUCollectionViewCell cellSize];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CollectionViewController *collectonVc = [CollectionViewController new];
        [self.navigationController pushViewController:collectonVc animated:YES];
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}



- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}

/**监听scrollView的偏移量*/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        //偏移量大于等于某个值悬停
        if (self.scrollView.contentOffset.y >= headHeight) {
            self.scrollView.contentOffset = CGPointMake(0, headHeight);
            self.isHover = YES;
        }else{
            if (self.isHover) {
                self.scrollView.contentOffset = CGPointMake(0, headHeight);
            }
        }
        
        if (self.isMidRefresh && self.collectionView.contentOffset.y<=0 && scrollView.contentOffset.y <=0) {
            self.scrollView.contentOffset = CGPointZero;
        }else{
            /**设置下面列表的位置*/
            if (self.scrollView.contentOffset.y < headHeight) {
                if (!self.isHover) {
                    //列表的便宜度都设置为零
                    self.collectionView.contentOffset = CGPointZero;
                }
            }
        }
    } else {
        [self collectionViewDidScroll:self.collectionView];
    }
}

- (void)collectionViewDidScroll:(UIScrollView *)scrollView {
    if (self.isMidRefresh && scrollView.contentOffset.y < 0 && !self.isHover  && self.scrollView.contentOffset.y<=0) {
        self.scrollView.contentOffset = CGPointZero;
    } else {
        if (!self.isHover) {
            self.collectionView.contentOffset = CGPointZero;
        }
        if (scrollView.contentOffset.y <=0) {
            self.isHover = NO;
            scrollView.contentOffset = CGPointZero;
        }else{
            self.isHover = YES;
        }
    }
}


#pragma mark - Target Methods

/**
 获取到数据后
 */
- (void)afterGetData {
    
    // 模拟数据
    for (int i = 0; i < 5; i ++) {
        [self.dataArray addObject:[NSObject new]];
    }
    // 停止动画,并刷新数据
    [self.collectionView tab_endAnimation];
}

- (NSMutableArray <PurchaseModel *> *)offViewData {
    NSMutableArray <PurchaseModel *> *officeArr = [NSMutableArray new];
    NSArray *name = @[@"家用电器", @"食用酒水", @"个护健康", @"服饰箱包", @"母婴产品", @"其他"];
    for (int i = 0; i < name.count; i++) {
        PurchaseModel *model = [[PurchaseModel alloc]init];
        model.purchase_type_name = [NSString stringWithFormat:@"%@", name[i]];
        model.amount = (arc4random_uniform(200));
        model.count = (arc4random_uniform(110));
        CGFloat red = (arc4random_uniform(255))/255.0;
        CGFloat green = (arc4random_uniform(235))/255.0;
        CGFloat blue = (arc4random_uniform(200))/255.0;
        UIColor *rgb = [UIColor colorWithRed:red green:green blue:blue alpha:1];
        model.color = rgb;
        [officeArr addObject:model];
    }
    return officeArr;
}

- (NSMutableArray <SaleRankModel *> *)skuData {
    NSMutableArray <SaleRankModel *> *skuData = [NSMutableArray new];
    NSArray *name = @[@"汉堡", @"食用酒水", @"土豆", @"牛奶", @"母婴产品", @"水果", @"西瓜", @"桃子", @"香蕉", @"南瓜"];
    for (int i = 0; i < name.count; i++) {
        SaleRankModel *model = [[SaleRankModel alloc]init];
        model.name = name[i];
        model.rank = i + 1;
        model.quantity = arc4random_uniform(1000);
        [skuData addObject:model];
    }
    return skuData;
}

@end
