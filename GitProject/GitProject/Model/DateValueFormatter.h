//
//  DateValueFormatter.h
//  GitProject
//
//  Created by mark on 2019/9/3.
//  Copyright © 2019 mark. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//

typedef enum : NSUInteger {
    DayType = 0,
    WeekType,
    MonthType,
} DateType;


@interface DateValueFormatter : NSObject<IChartAxisValueFormatter>


- (instancetype)initWithType:(DateType)type;



@end

NS_ASSUME_NONNULL_END
