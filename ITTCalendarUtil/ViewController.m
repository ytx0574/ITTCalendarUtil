//
//  ViewController.m
//  ITTCalendarUtil
//
//  Created by Johnson on 6/6/15.
//  Copyright (c) 2015 Johnson. All rights reserved.
//

#import "ViewController.h"
#import "CalendarViewCell.h"
#import "ITTHeader.h"
#import "CalendarView.h"

@interface ViewController ()<CalendarViewDelegate>

@property (nonatomic, strong) NSArray *arrayWithDays;
@property (weak, nonatomic) IBOutlet CalendarView *calendarView;

@property (nonatomic, strong) ITTMonth *currentMonth;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentMonth = [[ITTMonth alloc] initWithDate:[NSDate dateWithTimeInterval:-24 * 60 * 60 * 30 sinceDate:[NSDate date]]];
    self.calendarView.months = @[ _currentMonth ];
    self.calendarView.delegate = (id)self;
//    self.calendarView.headerViewHeight = 111;
    
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)headerClickTouchUpInside:(NSInteger)type
{
    ITTMonth *month = (type == 0 ? [_currentMonth previousMonth] : [_currentMonth nextMonth]);
    _currentMonth = month;
    self.calendarView.months = @[ _currentMonth ];
}

- (void)footerClickTouchUpInside:(NSInteger)type
{

}

- (void)didSelectDay:(ITTDay *)day
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
