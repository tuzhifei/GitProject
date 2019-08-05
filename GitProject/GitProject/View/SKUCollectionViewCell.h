//
//  SKUCollectionViewCell.h
//  ChartsDemo
//
//  Created by mark on 2019/6/3.
//  Copyright © 2019 mark. All rights reserved.
//

#import "BaseCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@class SaleRankModel;
@interface SKUCollectionViewCell : BaseCollectionViewCell

- (void)reloadWithDataSource:(NSArray <SaleRankModel *> *)dataSource;

@end

NS_ASSUME_NONNULL_END
