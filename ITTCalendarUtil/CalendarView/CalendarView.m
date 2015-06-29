//
//  CalendarView.m
//  ITTCalendarUtil
//
//  Created by Johnson on 6/7/15.
//  Copyright (c) 2015 Johnson. All rights reserved.
//

#import "CalendarView.h"
#import "CalendarViewCell.h"
#import "CalendarHeaderReusableView.h"
#import "CalendarFooterReusableView.h"
#import "ITTHeader.h"
#import "CalendarViewHeader.h"

@interface CalendarView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{

}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *monthOfDays;

@end

@implementation CalendarView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)sizeToFit
{
    [super sizeToFit];
    if (self.monthOfDays.count == 1) {
        self.collectionView.frame = CGRectMake(0, 0, self.collectionView.frame.size.width, HeaderViewHeight + FooterViewHeight + self.collectionView.frame.size.width / 7 * [self.monthOfDays.firstObject count] / 7);
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    }
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.collectionView.frame = self.bounds;
}

#pragma mark - PrivateMethods
- (void)setUp
{
    [self addSubview:self.collectionView];
}

#pragma mark - GetMethods
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CalendarViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([CalendarViewCell class])];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CalendarHeaderReusableView class]) bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([CalendarHeaderReusableView class])];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CalendarFooterReusableView class]) bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([CalendarFooterReusableView class])];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollEnabled = NO;
    }
    return _collectionView;
}

#pragma mark - SetMethods
- (void)setMonthOfDays:(NSArray *)monthOfDays
{
    _monthOfDays = monthOfDays;
    [self.collectionView reloadData];
    
    NSUInteger __block selectItemIndex = 0;
    ITTMonth *month = self.months.firstObject;
    [[monthOfDays firstObject] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isToday]) {
            selectItemIndex = idx;
            *stop = YES;
        }else if ([obj isEqualToDay:month.firstDay] && ![[[ITTMonth alloc] initWithDate:[NSDate date]] isThisMonth:obj]) {
            selectItemIndex = idx;
            *stop = YES;
        }
    }];
    
    //设置默认显示日期
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectItemIndex inSection:0];
    [self.collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    [self collectionView:self.collectionView didSelectItemAtIndexPath:indexPath];
}

- (void)setMonths:(NSArray *)months
{
    _months = months;
    NSMutableArray *arrayMonthOfDays = [NSMutableArray array];
    [months enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [arrayMonthOfDays addObject:[ITTDateUtil allDaysFromMonth:obj monthOfFirstDayType:MonthOfFirstDayTypeMonday]];
    }];
    self.monthOfDays = arrayMonthOfDays;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
{
    return [self.monthOfDays count];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return [self.monthOfDays[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    CalendarViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CalendarViewCell class]) forIndexPath:indexPath];
    
    ITTDay *day = self.monthOfDays[indexPath.section][indexPath.row];
    ITTMonth *month = self.months[indexPath.section];
    DayType dayType = [month dayType:day];
    cell.userInteractionEnabled = !(dayType == DayTypePreviousMonth || dayType == DayTypeNextMonth);

    [cell setInfo:self.monthOfDays[indexPath.section][indexPath.row] month:self.months[indexPath.section]];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectDay:)]) {
        ITTDay *day = self.monthOfDays[indexPath.section][indexPath.row];
        [self.delegate didSelectDay:day];
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CalendarHeaderReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([kind isEqualToString:UICollectionElementKindSectionHeader] ? [CalendarHeaderReusableView class] : [CalendarFooterReusableView class]) forIndexPath:indexPath];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ITTMonth *month = self.months[indexPath.section];
        reusableView.labelTitle.text = [NSString stringWithFormat:@"%@-%@", @(month.getYear), @(month.getMonth)];
    }
    
    reusableView.clickTouchUpInsideComplete = ^(HeaderClickType type){
        if (self.delegate && [self.delegate respondsToSelector:@selector(headerClickTouchUpInside:)]) {
            [self.delegate headerClickTouchUpInside:type];
        }else if (self.delegate && [self.delegate respondsToSelector:@selector(footerClickTouchUpInside:)]) {
            [self.delegate footerClickTouchUpInside:type];
        }
    };
    
    return reusableView;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    CGFloat itemWith = ([collectionView bounds].size.width - ItemIntervalWidth * 8) / 7;
    return CGSizeMake(itemWith, itemWith + 8);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
{
    return UIEdgeInsetsMake(0, ItemIntervalWidth, ItemIntervalWidth, ItemIntervalWidth);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
{
    return ItemIntervalWidth;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
{
    return ItemIntervalWidth;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
{
    return CGSizeMake(collectionView.frame.size.width, HeaderViewHeight);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;
{
    return CGSizeMake(collectionView.frame.size.width, FooterViewHeight);
}

@end
