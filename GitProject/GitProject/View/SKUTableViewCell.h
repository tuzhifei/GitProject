//
//  SKUTableViewCell.h
//  ChartsDemo
//
//  Created by mark on 2019/6/3.
//  Copyright © 2019 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SaleRankModel;
@interface SKUTableViewCell : UITableViewCell


@property(nonatomic, assign)BOOL isHide;

- (void)configWithModel:(SaleRankModel *)model;

@end

NS_ASSUME_NONNULL_END
