//
//  ITTMonth.h
//  ITTCalendarUtil
//
//  Created by Johnson on 6/7/15.
//  Copyright (c) 2015 Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ITTDay;

#define NUMBER_OF_DAYS_IN_WEEK  7

#define PreviousMonthColor           [UIColor grayColor]
#define NextMonthColor               [UIColor redColor]

#define CurrentMonthPastDayColor     [UIColor yellowColor]
#define CurrentDayColor              [UIColor blueColor]
#define CurrentMonthFutureDayColor   [UIColor orangeColor]

typedef NS_ENUM(NSInteger, DayType)
{
    DayTypeUnknown = 0,
    DayTypePreviousMonth,
    DayTypeCurrentMonthPast,
    DayTypeCurrentMonthToday,
    DayTypeCurrentMonthFuture,
    DayTypeNextMonth
};

@interface ITTMonth : NSObject
{
@private
    NSUInteger      _month;
    NSUInteger      _year;
    NSUInteger      _numberOfDays;
    ITTDay       *_today;
    NSMutableArray  *daysOfMonth;
}

@property (nonatomic, readonly) NSUInteger days;;

- (id)initWithDate:(NSDate*)date;
- (id)initWithMonth:(NSUInteger)month;
- (id)initWithMonth:(NSUInteger)month year:(NSUInteger)year;
- (id)initWithMonth:(NSUInteger)month year:(NSUInteger)year day:(NSUInteger)day;

- (NSUInteger)getYear;
- (NSUInteger)getMonth;

- (ITTDay *)dayAtDay:(NSUInteger)day;
- (ITTDay *)firstDay;
- (ITTDay *)lastDay;

- (ITTMonth *)nextMonth;
- (ITTMonth *)previousMonth;

- (DayType)dayType:(ITTDay*)calDay;

@end
