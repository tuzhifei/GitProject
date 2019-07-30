//
//  SKUModel.h
//  ChartsDemo
//
//  Created by mark on 2019/6/3.
//  Copyright © 2019 mark. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKUModel : NSObject


@property(nonatomic, assign)int rank;

@property(nonatomic, strong)NSString *describeStr;

@property(nonatomic, assign)NSInteger money;

@end

NS_ASSUME_NONNULL_END
