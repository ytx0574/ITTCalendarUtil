//
//  ITTMonth.m
//  ITTCalendarUtil
//
//  Created by Johnson on 6/6/15.
//  Copyright (c) 2015 Johnson. All rights reserved.
//

#import "ITTMonth.h"
#import "ITTDateUtil.h"
#import "ITTDay.h"

#define FIRST_MONTH_OF_YEAR  1
#define LAST_MONTH_OF_YEAR  12

@interface ITTMonth()
- (void)caculateMonth;
@end

@implementation ITTMonth

@synthesize days;

- (NSString *)description
{
    return [NSString stringWithFormat:@"year:%@ month:%@ number of days in month:%@",
            @(_year), @(_month), @(_numberOfDays)];
}

#pragma mark - PublicMethods
- (id)initWithMonth:(NSUInteger)month
{
    self = [super init];
    if (self)
    {
        _today = [[ITTDay alloc] initWithYear:[ITTDateUtil getCurrentYear] month:month day:1];
        [self caculateMonth];
    }
    return self;
}

- (id)initWithMonth:(NSUInteger)month year:(NSUInteger)year
{
    self = [super init];
    if (self)
    {
        _today = [[ITTDay alloc] initWithYear:year month:month day:1];
        [self caculateMonth];
    }
    return self;
}

- (id)initWithDate:(NSDate*)d
{
    self = [super init];
    if (self)
    {
        _today = [[ITTDay alloc] initWithDate:d];
        [self caculateMonth];
    }
    return self;
}

- (id)initWithMonth:(NSUInteger)month year:(NSUInteger)year day:(NSUInteger)day
{
    self = [super init];
    if (self)
    {
        _today = [[ITTDay alloc] initWithYear:year month:month day:day];
        [self caculateMonth];
    }
    return self;
}

- (NSUInteger)getYear
{
    return _year;
}

- (NSUInteger)getMonth
{
    return _month;
}

- (ITTDay *)dayAtDay:(NSUInteger)day
{
    NSInteger index = day - 1;
    NSAssert(!(index < 0||index > 31), @"invalid day index %@", @(index));
    return [daysOfMonth objectAtIndex:index];
}

- (ITTDay *)firstDay
{
    return [daysOfMonth objectAtIndex:0];
}

- (ITTDay *)lastDay
{
    return [daysOfMonth objectAtIndex:_numberOfDays - 1];
}


- (ITTMonth *)nextMonth
{
    NSUInteger year = _year;
    NSUInteger month = _month + 1;
    NSUInteger day = 1;
    if (month > LAST_MONTH_OF_YEAR) 
    {
        year++;
        month = 1;
    }
    ITTMonth *calMonth = [[ITTMonth alloc] initWithMonth:month year:year day:day];
    return calMonth;
}

- (ITTMonth *)previousMonth
{
    NSUInteger year = _year;
    NSUInteger month = _month - 1;
    NSUInteger day = 1;
    if (month < FIRST_MONTH_OF_YEAR) 
    {
        year--;
        month = 12;
    }
    ITTMonth *calMonth = [[ITTMonth alloc] initWithMonth:month year:year day:day];
    return calMonth;
}

- (BOOL)isThisMonth;
{
    ITTDay *day = [[ITTDay alloc] initWithDate:[NSDate date]];
    return (self.getYear == [day getYear] && self.getMonth == [day getMonth]);
}

- (BOOL)isThisMonth:(ITTDay *)day;
{
    return (self.getYear == [day getYear] && self.getMonth == [day getMonth]);
}

- (BOOL)isEqualMonth:(ITTMonth *)month;
{
    return (self.getMonth == month.getMonth && self.getYear == month.getYear);
}

- (DayType)dayType:(ITTDay*)calDay
{
    if ([self getYear] == [calDay getYear]) {
        if ([[self previousMonth] getMonth] == [calDay getMonth]) {
            return DayTypePreviousMonth;
        }else if ([self getMonth] == [calDay getMonth]) {
            ITTDay *today = [[ITTDay alloc] initWithDate:[NSDate date]];
            if ([calDay getDay] < [today getDay]) {
                return DayTypeCurrentMonthPast;
            } if ([today getDay] == [today getDay]) {
                return DayTypeCurrentMonthToday;
            }else {
                return DayTypeCurrentMonthFuture;
            }
        }else if ([[self nextMonth] getMonth] == [calDay getMonth]) {
            return DayTypeNextMonth;
        }
        return DayTypeNextMonth;
    }
    return DayTypeUnknown;
}

#pragma mark - PrivateMethods
- (void)caculateMonth
{
    _numberOfDays = [ITTDateUtil numberOfDaysInMonth:[_today getMonth] year:[_today getYear]];
    _year = [_today getYear];
    _month = [_today getMonth];
    daysOfMonth = [[NSMutableArray alloc] init];
    for (NSInteger day = 1; day <= _numberOfDays; day++)
    {
        ITTDay *calDay = [[ITTDay alloc] initWithYear:_year month:_month day:day];
        [daysOfMonth addObject:calDay];
        
    }
}

#pragma mark - GetMothods
- (NSUInteger)days
{
    return _numberOfDays;
}
@end
