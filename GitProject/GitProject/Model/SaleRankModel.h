//
//  SaleRankModel.h
//  router
//
//  Created by mark on 2019/6/13.
//  Copyright © 2019 Wireless Department. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SaleRankModel : NSObject


@property(nonatomic, strong)NSString *name;
@property(nonatomic, assign) NSInteger quantity;
@property(nonatomic, assign) int rank;

+ (instancetype)createModelWithDictionary:(NSDictionary *)dict;



@end

NS_ASSUME_NONNULL_END
