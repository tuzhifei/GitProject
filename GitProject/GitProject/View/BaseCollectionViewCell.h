//
//  BaseCollectionViewCell.h
//  GitProject
//
//  Created by mark on 2019/7/30.
//  Copyright © 2019 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) id model;
@property(nonatomic, assign)BOOL isHidden;
@property(nonatomic, strong) UILabel *titleLab;
- (void)segementSelectBlock:(void (^)(NSInteger index))selectBlock;
+ (NSString *)cellIdentifier;
+ (void)registerCellInCollectionView:(UICollectionView *)collectionView;
- (void)updateWithModel:(id)model;
+ (CGSize)cellSize;
+ (instancetype)cellWithIndexPath:(NSIndexPath *)indexPath atCollectionView:(UICollectionView *)collectionView;

@end

NS_ASSUME_NONNULL_END
