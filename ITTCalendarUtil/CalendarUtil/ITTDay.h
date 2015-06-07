//
//  ITTDay.h
//  ITTCalendarUtil
//
//  Created by Johnson on 6/7/15.
//  Copyright (c) 2015 Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WeekDay)
{
    WeekDayUnknown = 0,
    WeekDayMonday,
    WeekDayTuesday,
    WeekDayWednesday,
    WeekDayThurday,
    WeekDayFriday,
    WeekDaySaturday,
    WeekDaySunday
};

@interface ITTDay : NSObject
{
@private    
    NSDate      *_date;
    NSInteger   _month;
    NSInteger   _day;
    NSInteger   _year;
    NSInteger   _weekDay;
}

- (id)initWithDate:(NSDate*)d;
- (id)initWithYear:(NSInteger)year month:(NSInteger)year day:(NSInteger)day;

@property (nonatomic, retain, readonly)NSDate *date;
@property (nonatomic, strong) UIColor *color;

- (NSUInteger)getYear;
- (NSUInteger)getMonth;
- (NSUInteger)getDay;
- (NSUInteger)getWeekDay;
- (NSComparisonResult)compare:(ITTDay*)calDay;

- (NSString *)getWeekDayName;

- (ITTDay *)nextDay;
- (ITTDay *)previousDay;
- (WeekDay)getMeaningfulWeekDay;

- (BOOL)isToday;
- (BOOL)isEqualToDay:(ITTDay*)calDay;

@end
