//
//  PieCollectionViewCell.h
//  GitProject
//
//  Created by mark on 2019/7/30.
//  Copyright © 2019 mark. All rights reserved.
//

#import "BaseCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@class PurchaseModel;
@interface PieCollectionViewCell : BaseCollectionViewCell

- (void)reloadWithModel:(NSArray <PurchaseModel*> *)modelArray;


@end

NS_ASSUME_NONNULL_END
