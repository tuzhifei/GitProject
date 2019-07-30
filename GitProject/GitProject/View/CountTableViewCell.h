//
//  CountTableViewCell.h
//  ChartsDemo
//
//  Created by mark on 2019/5/30.
//  Copyright © 2019 mark. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PieModel, PurchaseModel;
@interface CountTableViewCell : UITableViewCell

@property(nonatomic, assign) BOOL isRight;

- (void)configWithModel:(PurchaseModel *)model;

@end

NS_ASSUME_NONNULL_END
