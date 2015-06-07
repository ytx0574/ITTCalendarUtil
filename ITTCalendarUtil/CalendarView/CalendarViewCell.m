//
//  CollectionViewCell.m
//  test
//
//  Created by Johnson on 6/7/15.
//  Copyright (c) 2015 Johnson. All rights reserved.
//

#import "CalendarViewCell.h"
#import "ITTHeader.h"

@interface CalendarViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation CalendarViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.label.layer.cornerRadius = self.bounds.size.height / 2;
    self.label.backgroundColor = [UIColor brownColor];
    self.label.layer.masksToBounds = YES;
}

- (void)setInfo:(ITTDay *)day;
{
    self.label.text = [NSString stringWithFormat:@"%@", @([day getDay])];
    self.label.textColor = day.color;
}

@end
