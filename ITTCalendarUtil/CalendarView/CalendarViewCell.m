//
//  CollectionViewCell.m
//  test
//
//  Created by Johnson on 6/7/15.
//  Copyright (c) 2015 Johnson. All rights reserved.
//

#import "CalendarViewCell.h"
#import "ITTHeader.h"

#define LightGrayTextColor RGBCOLOR(201, 202, 202)
#define BlackTextColor     [UIColor blackColor]

#define SignNormalBackgroundColor    RGBCOLOR(225, 242, 252)
#define SignAskLeaveBorderColor      RGBCOLOR(239, 131, 111)

#define TodayLineColor               RGBCOLOR(238, 123, 102)
#define OtherLineColor               RGBCOLOR(75, 182, 233)

@interface CalendarViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIView *viewBackGround;

@property (weak, nonatomic) IBOutlet UIView *viewSelectLine;

@end

@implementation CalendarViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.selectedBackgroundView = self.viewBackGround;
}


- (void)setInfo:(ITTDay *)day month:(ITTMonth *)month
{
    self.label.text = [NSString stringWithFormat:@"%@", @([day getDay])];
}

@end
