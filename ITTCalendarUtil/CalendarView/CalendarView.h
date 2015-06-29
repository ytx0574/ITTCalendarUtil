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

@optional
- (void)didSelectDay:(ITTDay *)day;

- (void)headerClickTouchUpInside:(NSInteger)type;

- (void)footerClickTouchUpInside:(NSInteger)type;

@end

@interface CalendarView : UIView

@property (nonatomic, strong) NSArray *months;

@property (nonatomic, strong) id<CalendarViewDelegate> delegate;

@property (nonatomic, strong) NSArray *signData;

@end
