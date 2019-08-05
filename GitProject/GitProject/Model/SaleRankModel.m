//
//  SaleRankModel.m
//  router
//
//  Created by mark on 2019/6/13.
//  Copyright © 2019 Wireless Department. All rights reserved.
//

#import "SaleRankModel.h"

@implementation SaleRankModel

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
       
    }
    return self;
}

+ (instancetype)createModelWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}




@end
