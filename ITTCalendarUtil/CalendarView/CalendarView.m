//
//  CalendarView.m
//  ITTCalendarUtil
//
//  Created by Johnson on 6/7/15.
//  Copyright (c) 2015 Johnson. All rights reserved.
//

#import "CalendarView.h"
#import "CalendarViewCell.h"
#import "CalendarViewReusableView.h"
#import "ITTDateUtil.h"

@interface CalendarView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    CalendarViewCell *_cell;
    CalendarViewReusableView *_reusableView;
}

@property (nonatomic, strong) UICollectionView *collectionView;

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
    if (self.months.count == 1) {
        self.collectionView.frame = CGRectMake(0, 0, self.collectionView.frame.size.width, self.headerViewHeight + self.collectionView.frame.size.width / 7 * [self.months.firstObject count] / 7);
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    }
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
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CalendarViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CalendarViewCell"];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CalendarViewReusableView class]) bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CalendarViewReusableView"];
        _collectionView.backgroundColor = [self backgroundColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

#pragma mark - SetMethods
- (void)setMonths:(NSArray *)months
{
    _months = months;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
{
    return [self.months count];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return [self.months[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    CalendarViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CalendarViewCell" forIndexPath:indexPath];
    [cell setInfo:self.months[indexPath.section][indexPath.row]];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectDay:)]) {
        [self.delegate didSelectDay:self.months[indexPath.section][indexPath.row]];
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CalendarViewReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CalendarViewReusableView" forIndexPath:indexPath];
    return reusableView;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    return CGSizeMake([collectionView bounds].size.width / 7, [collectionView bounds].size.width / 7);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
{
    return 0.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
{
    return 0.f;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
{
    return CGSizeMake(collectionView.frame.size.width, self.headerViewHeight);
}

@end
