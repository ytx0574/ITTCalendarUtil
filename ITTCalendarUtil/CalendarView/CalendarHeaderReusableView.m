//
//  CalendarViewReusableView.m
//  ITTCalendarUtil
//
//  Created by Johnson on 6/7/15.
//  Copyright (c) 2015 Johnson. All rights reserved.
//

#import "CalendarHeaderReusableView.h"
#import "CalendarView.h"
#import "CalendarViewHeader.h"

@interface CalendarHeaderReusableView ()

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *arrayLabels;

@end

@implementation CalendarHeaderReusableView

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGFloat itemWidth = (ScreenWidth - ItemIntervalWidth * 8) / 7;
    [self.arrayLabels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UILabel *label = obj;
        label.frame = CGRectMake(ItemIntervalWidth * idx + itemWidth * idx + ItemIntervalWidth, label.frame.origin.y, itemWidth, label.frame.size.height);
    }];
}


- (IBAction)clickLeft:(id)sender {
    self.clickTouchUpInsideComplete ? self.clickTouchUpInsideComplete(HeaderClickTypePreviousMonth) : nil;
}

- (IBAction)clickRight:(id)sender {
    self.clickTouchUpInsideComplete ? self.clickTouchUpInsideComplete(HeaderClickTypeNextMonth) : nil;
}

@end
