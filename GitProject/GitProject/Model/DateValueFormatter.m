//
//  DateValueFormatter.m
//  GitProject
//
//  Created by mark on 2019/9/3.
//  Copyright © 2019 mark. All rights reserved.
//

#import "DateValueFormatter.h"

@interface DateValueFormatter()

@property(nonatomic, strong)NSArray *xValue;
@property(nonatomic, assign)DateType type;

@end
@implementation DateValueFormatter

- (instancetype)initWithType:(DateType)type {
    if (self = [super init]) {
        _type = type;
        [self loadData];
    }
    return self;
}

- (void)loadData {
    self.xValue = [[NSArray alloc]init];
    switch (self.type) {
        case DayType:
        {
            self.xValue = [self dayData];
        }
            break;
        case WeekType:
        {
            self.xValue = [self weekData];
        }
            break;
            
        case MonthType:
        {
            self.xValue = [self monthData];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark- 今日
- (NSArray *)dayData {
    NSMutableArray <NSString *> *dayArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < 25; i ++) {
        NSString *dayStr = [NSString stringWithFormat:@"%02d:00", i];
        [dayArr addObject:dayStr];
    }
    return dayArr;
}

#pragma mark- 本周
- (NSArray *)weekData {
    return @[@"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日"];
}

#pragma mark- 本月
- (NSArray *)monthData {
    NSMutableArray <NSString *> *weekArr = [[NSMutableArray alloc]init];
    NSInteger day = [self getMonthDay]; //当月天数
    for (int i = 0; i < day; i ++) {
        NSString *dataStr = [NSString stringWithFormat:@"%d", i+1];
        [weekArr addObject:dataStr];
    }
    return weekArr;
}

#pragma mark- 获取当月天数
- (NSUInteger)getMonthDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
    NSUInteger numberOfDaysInMonth = range.length;
    return numberOfDaysInMonth;
}

- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis{
    NSString *xAxisStringValue = @"";
    int myInt = (int)value;
    if (self.type == DayType) {
        if (myInt % 4 == 0) {
            xAxisStringValue = [self.xValue objectAtIndex:myInt];
        }
    }
    else if (self.type == WeekType) {
        xAxisStringValue = [self.xValue objectAtIndex:myInt];
    }
    else {
        int month = myInt + 1;
        NSInteger allDay = [self getMonthDay]; //总天数
        if (month == 1) {
            xAxisStringValue = [self.xValue objectAtIndex:0];
        }
        if (allDay == 30) {
            if (month % 6 == 0) {
                xAxisStringValue = [self.xValue objectAtIndex:myInt];
            }
        } else {
            if (month % 6 == 0) {
                xAxisStringValue = [self.xValue objectAtIndex:myInt];
            }
            if (allDay == 31) {
                if (month == 30) {
                    xAxisStringValue = @"";
                }
                if (month == 31) {
                    xAxisStringValue = [self.xValue objectAtIndex:myInt];
                }
            } else if (allDay == 28) {
                if (month == 28) {
                    xAxisStringValue = [self.xValue objectAtIndex:myInt];
                }
            } else if (allDay == 29) {
                if (month == 29) {
                    xAxisStringValue = [self.xValue objectAtIndex:myInt];
                }
            }
        }
    }
    return xAxisStringValue;
}


@end
