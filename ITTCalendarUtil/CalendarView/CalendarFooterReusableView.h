//
//  CalendarFooterReusableView.h
//  MyChild
//
//  Created by Johnson on 6/10/15.
//  Copyright (c) 2015 hu.yuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SignModel;
@class ITTDay;

@interface CalendarFooterReusableView : UICollectionReusableView

@property (nonatomic, copy) void(^clickTouchUpInsideComplete)(NSInteger type);

@end
