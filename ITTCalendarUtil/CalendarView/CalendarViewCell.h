//
//  CollectionViewCell.h
//  test
//
//  Created by Johnson on 6/7/15.
//  Copyright (c) 2015 Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ITTDay;
@class ITTMonth;

@interface CalendarViewCell : UICollectionViewCell

- (void)setInfo:(ITTDay *)day month:(ITTMonth *)month;

@end
