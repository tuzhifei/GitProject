//
//  CollectionViewController.m
//  GitProject
//
//  Created by mark on 2019/9/9.
//  Copyright © 2019 mark. All rights reserved.
//

#import "CollectionViewController.h"
#import "HeadCollectionReusableView.h"
static NSString *useId = @"UICollectionViewCell";
@interface CollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong)UICollectionView *collectionView;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self waterfall];
}

-(void)waterfall{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 10.0f;
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0f, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64.0f) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor colorWithRed:237 / 255.0f green:237 / 255.0f blue:237 / 255.0f alpha:1.0f];
    self.collectionView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    self.collectionView.delegate=self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    [flowLayout setHeaderReferenceSize:CGSizeMake(kScreenWidth, 100)];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:useId];
    [self.collectionView registerClass:[HeadCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeadCollectionReusableView"];
    ViewBorderRadius(self.collectionView, 1, 3, [UIColor RandomColor]);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        HeadCollectionReusableView *headerV =(HeadCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeadCollectionReusableView" forIndexPath:indexPath];
        headerV.backgroundColor = [UIColor whiteColor];
        reusableView = headerV;
    }
    return reusableView;
}

#pragma mark - UICollectionViewDelegateWaterfallLayout
//返回 indexPath 处的 item 的大小。
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (self.view.bounds.size.width - 20);
    return CGSizeMake(width, 200);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.0f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0.0f, 10.0f, 0.0f, 10.0f);
    
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 3;
    
}

- (UICollectionViewCell* )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    UICollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:useId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor RandomColor];
    return cell;
    
}

//点击单元格

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%ld区--%ld单元格",(long)indexPath.section,(long)indexPath.row);
    
}



@end
