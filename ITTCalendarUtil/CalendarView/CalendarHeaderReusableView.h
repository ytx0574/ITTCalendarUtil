//
//  CalendarViewReusableView.h
//  ITTCalendarUtil
//
//  Created by Johnson on 6/7/15.
//  Copyright (c) 2015 Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HeaderClickType)
{
    HeaderClickTypePreviousMonth,
    HeaderClickTypeNextMonth,
};

@interface CalendarHeaderReusableView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

@property (nonatomic, copy) void(^clickTouchUpInsideComplete)(NSInteger type);

@end
