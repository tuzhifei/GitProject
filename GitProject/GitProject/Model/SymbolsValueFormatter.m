//
//  SymbolsValueFormatter.m
//  GitProject
//
//  Created by mark on 2019/9/3.
//  Copyright © 2019 mark. All rights reserved.
//

#import "SymbolsValueFormatter.h"

@implementation SymbolsValueFormatter

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis {
    if (value == 0) {
        return [NSString stringWithFormat:@"%ld",(NSInteger)value];
    }
    else {
        return [NSString stringWithFormat:@"%ld%%",(NSInteger)value];
    }
}

@end
