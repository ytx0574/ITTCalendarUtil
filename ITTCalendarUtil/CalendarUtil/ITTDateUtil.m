//
//  ITTDateUtil.m
//  ITTCalendarUtil
//
//  Created by Johnson on 6/6/15.
//  Copyright (c) 2015 Johnson. All rights reserved.
//

#import "ITTDateUtil.h"
#import "ITTMonth.h"
#import "ITTDay.h"

@implementation ITTDateUtil

+ (BOOL)isLeapYear:(NSInteger)year
{
    NSAssert(!(year < 1), @"invalid year number");
    BOOL leap = FALSE;
    if ((0 == (year % 400))) {
        leap = TRUE;
    }
    else if((0 == (year%4)) && (0 != (year % 100))) {
        leap = TRUE;
    }
    return leap;
}

+ (NSInteger)numberOfDaysInMonth:(NSInteger)month
{
    return [ITTDateUtil numberOfDaysInMonth:month year:[ITTDateUtil getCurrentYear]];
}

+ (NSInteger)numberOfDaysInMonth:(NSInteger)month year:(NSInteger) year
{
    NSAssert(!(month < 1||month > 12), @"invalid month number");
    NSAssert(!(year < 1), @"invalid year number");
    month = month - 1;
    static int daysOfMonth[12] = {31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    NSInteger days = daysOfMonth[month];
    /*
     * feb
     */
    if (month == 1) {
        if ([ITTDateUtil isLeapYear:year]) {
            days = 29;
        }
        else {
            days = 28;
        }
    }
    return days;
}

+ (NSInteger)getCurrentYear
{
    time_t ct = time(NULL);
	struct tm *dt = localtime(&ct);
	int year = dt->tm_year + 1900;
    return year;
}

+ (NSInteger)getCurrentMonth
{
    time_t ct = time(NULL);
	struct tm *dt = localtime(&ct);
	int month = dt->tm_mon + 1;
    return month;
}

+ (NSInteger)getCurrentDay
{
    time_t ct = time(NULL);
	struct tm *dt = localtime(&ct);
	int day = dt->tm_mday;
    return day;
}

+ (NSInteger)getMonthWithDate:(NSDate*)date
{
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:date];
    NSInteger month = comps.month;
    return month;
}

+ (NSInteger)getDayWithDate:(NSDate*)date
{
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:date];
    NSInteger day = comps.day;
    return day;
}

+ (NSDate *)dateSinceNowWithInterval:(NSInteger)dayInterval
{
    return [NSDate dateWithTimeIntervalSinceNow:dayInterval*24*60*60];
}

+ (NSArray *)allDays:(ITTMonth *)month
{
    NSMutableArray *array = [NSMutableArray array];
    
    //日 一 二 三 四 五 六
    ITTMonth *previousMonth = [month previousMonth];
    NSInteger previousInterval = month.firstDay.getWeekDay - 1;
    for (int i = 1; i <= previousInterval; i ++) {
        NSInteger dayNumber = month.previousMonth.lastDay.getDay - previousInterval + i;
        ITTDay *day = [[ITTDay alloc] initWithYear:[previousMonth getYear] month:[previousMonth getMonth] day:dayNumber];
        day.color = PreviousMonthColor;
        [array addObject:day];
    }
    
    for (int i = 1; i <= month.days; i ++) {
        ITTDay *day = [month dayAtDay:i];
        ITTDay *today = [[ITTDay alloc] initWithDate:[NSDate date]];
        if ([day getDay] < [today getDay]) {
            day.color = CurrentMonthPastDayColor;
        }else if ([day getDay] == [today getDay]) {
            day.color = CurrentDayColor;
        }else {
            day.color = CurrentMonthFutureDayColor;
        }
        [array addObject:day];
    }
    
    ITTMonth *nextMonth = [month nextMonth];
    NSInteger nextInterval = 7 - month.lastDay.getWeekDay;
    for (int i = 1; i <= nextInterval; i ++) {
        NSInteger dayNumber = i;
        ITTDay *day = [[ITTDay alloc] initWithYear:[nextMonth getYear] month:[nextMonth getMonth] day:dayNumber];
        day.color = NextMonthColor;
        [array addObject:day];
    }
    return array;
}

@end
