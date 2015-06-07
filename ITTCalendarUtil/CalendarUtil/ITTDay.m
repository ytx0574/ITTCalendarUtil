//
//  ITTDay.m
//  ITTCalendarUtil
//
//  Created by Johnson on 6/6/15.
//  Copyright (c) 2015 Johnson. All rights reserved.
//

#import "ITTDay.h"
#import "ITTDateUtil.h"

#define SECOND_OF_A_DAY 24*60*60

@interface ITTDay()
- (void)cacluateDate;
@end

@implementation ITTDay

@synthesize date;

- (NSString *)description
{
    return [NSString stringWithFormat:@"year:%@ month:%@ day:%@ week:%@ %@", @(_year), @(_month), @(_day), @([self getMeaningfulWeekDay]), [self getWeekDayName]];
}

#pragma mark - PublicMethods
- (id)initWithDate:(NSDate*)d
{
    self = [super init];
    if (self) {
        _date = d;
        [self cacluateDate];
    }
    return self;
}

- (id)initWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)d
{
    self = [super init];
    if (self) {
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setYear:year];
        [comps setMonth:month];
        [comps setDay:d];
        [comps setHour:0];
        [comps setMinute:0];
        [comps setSecond:0];
        _date = [[NSCalendar currentCalendar] dateFromComponents:comps];
        [self cacluateDate];
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

- (NSUInteger)getDay
{
    return _day;        
}

- (NSUInteger)getWeekDay
{
    return _weekDay;            
}

- (NSComparisonResult)compare:(ITTDay*)calDay
{
    NSComparisonResult result = NSOrderedSame;
    if([self getYear] < [calDay getYear]) {
        result = NSOrderedAscending;
    }
    else if([self getYear] == [calDay getYear]) {
        if([self getMonth] < [calDay getMonth]) {
            result = NSOrderedAscending;
        }
        else if([self getMonth] == [calDay getMonth]) {
            if([self getDay] < [calDay getDay]) {
                result = NSOrderedAscending;
            }
            else if([self getDay] == [calDay getDay]) {
                result = NSOrderedSame;
            }
            else {
                result = NSOrderedDescending;
            }
        }
        else {
            result = NSOrderedDescending;
        }
    }
    else {
        result = NSOrderedDescending;
    }
    return result;
}

- (NSString *)getWeekDayName
{
    NSString *name = @"KnownName";
    switch (_weekDay) {
        case 1:
            name = @"Sunday";
            break;
        case 2:
            name = @"Monday";
            break;
        case 3:
            name = @"Tuesday";
            break;
        case 4:
            name = @"Wednesday";
            break;
        case 5:
            name = @"Thurday";
            break;
        case 6:
            name = @"Friday";
            break;
        case 7:
            name = @"Saturday";
            break;
        default:
            break;
    }
    return name;
}


- (ITTDay *)nextDay
{
    NSDate *nextDayDate = [_date dateByAddingTimeInterval:SECOND_OF_A_DAY];
    ITTDay *nextDay = [[ITTDay alloc] initWithDate:nextDayDate];
    return nextDay;
}

- (ITTDay *)previousDay
{
    NSDate *previousDayDate = [_date dateByAddingTimeInterval:-1*SECOND_OF_A_DAY];
    ITTDay *previousDay = [[ITTDay alloc] initWithDate:previousDayDate];
    return previousDay;
}

- (WeekDay)getMeaningfulWeekDay
{
    WeekDay wd = WeekDayUnknown;
    switch (_weekDay) {
        case 1:
            wd = WeekDaySunday;
            break;
        case 2:
            wd = WeekDayMonday;            
            break;
        case 3:
            wd = WeekDayTuesday;                        
            break;
        case 4:
            wd = WeekDayWednesday;
            break;
        case 5:
            wd = WeekDayThurday;
            break;
        case 6:
            wd = WeekDayFriday;
            break;
        case 7:
            wd = WeekDaySaturday;
            break;
        default:
            break;
    }
    return wd;
}

- (BOOL)isToday
{
    return ([ITTDateUtil getCurrentYear] == _year && 
            [ITTDateUtil getCurrentMonth] == _month && 
            [ITTDateUtil getCurrentDay] == _day);
}

- (BOOL)isEqualToDay:(ITTDay*)calDay
{
    BOOL equal = FALSE;
    if (calDay) {
        equal = ([calDay getYear] == _year && 
                 [calDay getMonth] == _month && 
                 [calDay getDay] == _day);    
    }
    return equal;
}

#pragma mark - PrivateMethods
- (void)cacluateDate
{
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:_date];
    _month = comps.month;
    _day = comps.day;
    _year = comps.year;
    _weekDay = comps.weekday;
}

#pragma mark - GetMehtods
- (NSDate *)date
{
    return _date;
}
@end
