//
//  ViewController.m
//  GitProject
//
//  Created by mark on 2019/7/26.
//  Copyright © 2019 mark. All rights reserved.
//

#import "ViewController.h"
#import "CardCollectionViewCell.h"
#import "BarCollectionViewCell.h"
#import "PieCollectionViewCell.h"
#import "PurchaseModel.h"
#import "PageCollectionView.h"

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
        [layout setSectionInset:UIEdgeInsetsMake(10, 10, 0, 10)];
        CGFloat maxY = self.buttonView.bottom + 20;
        _collectionView = [[PageCollectionView alloc]initWithFrame:CGRectMake(0, maxY, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height - maxY + headHeight) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[CardCollectionViewCell class] forCellWithReuseIdentifier:[CardCollectionViewCell cellIdentifier]];
        [_collectionView registerClass:[BarCollectionViewCell class] forCellWithReuseIdentifier:[BarCollectionViewCell cellIdentifier]];
        [_collectionView registerClass:[PieCollectionViewCell class] forCellWithReuseIdentifier:[PieCollectionViewCell cellIdentifier]];
        
        
        NSArray *classArray = @[
                                [CardCollectionViewCell class],
//                                [BarCollectionViewCell class],
//                                [PieCollectionViewCell class]
                                ];
        NSArray *sizeArray = @[
                               [NSValue valueWithCGSize:[CardCollectionViewCell cellSize]],
//                               [NSValue valueWithCGSize:[BarCollectionViewCell cellSize]],
//                               [NSValue valueWithCGSize:[PieCollectionViewCell cellSize]],
                               ];
        
//        _collectionView.tabAnimated = [TABCollectionAnimated
//                                       animatedWithCellClassArray:classArray
//                                       cellSizeArray:sizeArray
//                                       animatedCountArray:@[@(4), @(1), @(1)]];
        _collectionView.tabAnimated = [TABCollectionAnimated animatedWithCellClassArray:classArray
                                                                          cellSizeArray:sizeArray
                                                                     animatedCountArray:@[@(4)]
                                                                   animatedSectionArray:@[@(0)]];

        ViewBorderRadius(_collectionView, 1, 3, [UIColor RandomColor]);
        
   
    }
    return _collectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }
    return 1;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[CardCollectionViewCell cellIdentifier] forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    } else if (indexPath.section == 1) {
        BarCollectionViewCell *barCell = [collectionView dequeueReusableCellWithReuseIdentifier:[BarCollectionViewCell cellIdentifier] forIndexPath:indexPath];
        barCell.backgroundColor = [UIColor whiteColor];
        return barCell;
    } else {
        PieCollectionViewCell *pieCell = [PieCollectionViewCell cellWithIndexPath:indexPath atCollectionView:collectionView];
        pieCell.backgroundColor = [UIColor whiteColor];
        [pieCell reloadWithModel:[self offViewData]];
        return pieCell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [CardCollectionViewCell cellSize];
    }
    return [BarCollectionViewCell cellSize];
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
        model.total_count = (arc4random_uniform(50));
        model.total_amount = (arc4random_uniform(50));
        CGFloat red = (arc4random_uniform(255))/255.0;
        CGFloat green = (arc4random_uniform(235))/255.0;
        CGFloat blue = (arc4random_uniform(200))/255.0;
        UIColor *rgb = [UIColor colorWithRed:red green:green blue:blue alpha:1];
        model.color = rgb;
        [officeArr addObject:model];
    }
    return officeArr;
}

@end
