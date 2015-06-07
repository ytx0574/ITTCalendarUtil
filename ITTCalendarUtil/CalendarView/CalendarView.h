//
//  CalendarView.h
//  ITTCalendarUtil
//
//  Created by Johnson on 6/7/15.
//  Copyright (c) 2015 Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ITTDay;
@class ITTMonth;

@protocol CalendarViewDelegate <NSObject>

- (void)didSelectDay:(ITTDay *)day;

@end

@interface CalendarView : UIView

@property (nonatomic, assign) CGFloat headerViewHeight;

@property (nonatomic, strong) NSArray *months;

@property (nonatomic, strong) id<CalendarViewDelegate> delegate;

@end
