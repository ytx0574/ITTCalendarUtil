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

@interface ViewController ()

@property (nonatomic, strong) NSArray *arrayWithDays;
@property (weak, nonatomic) IBOutlet CalendarView *calendarView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ITTMonth *month = [[ITTMonth alloc] initWithDate:[NSDate dateWithTimeInterval:-24 * 60 * 60 * 30 sinceDate:[NSDate date]]];
    self.calendarView.months = @[[ITTDateUtil allDays:month], [ITTDateUtil allDays:month]];
    self.calendarView.delegate = (id)self;
    self.calendarView.headerViewHeight = 111;
    [self.calendarView sizeToFit];
    
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
