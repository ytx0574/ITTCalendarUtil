//
//  ITTDateUtil.h
//  ITTCalendarUtil
//
//  Created by Johnson on 6/7/15.
//  Copyright (c) 2015 Johnson. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ITTMonth;

typedef NS_ENUM(NSInteger, MonthOfFirstDayType)
{
    MonthOfFirstDayTypeSunday,
    MonthOfFirstDayTypeMonday
};

@interface ITTDateUtil : NSObject

+ (BOOL)isLeapYear:(NSInteger)year;

+ (NSInteger)numberOfDaysInMonth:(NSInteger)month;

+ (NSInteger)numberOfDaysInMonth:(NSInteger)month year:(NSInteger) year;

+ (NSInteger)getCurrentYear;

+ (NSInteger)getCurrentMonth;

+ (NSInteger)getCurrentDay;

+ (NSInteger)getMonthWithDate:(NSDate*)date;

+ (NSInteger)getDayWithDate:(NSDate*)date;

+ (NSDate *)dateSinceNowWithInterval:(NSInteger)dayInterval;

+ (NSArray *)allDaysFromMonth:(ITTMonth *)month;

+ (NSArray *)allDaysFromMonth:(ITTMonth *)month monthOfFirstDayType:(MonthOfFirstDayType)type;

@end
