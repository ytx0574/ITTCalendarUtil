//
//  FLEXManager.m
//  Flipboard
//
//  Created by Ryan Olson on 4/4/14.
//  Copyright (c) 2014 Flipboard. All rights reserved.
//

#import "FLEXManager.h"
#import "FLEXExplorerViewController.h"
#import "FLEXWindow.h"

@interface FLEXManager () <FLEXWindowEventDelegate, FLEXExplorerViewControllerDelegate>

@property (nonatomic, strong) FLEXWindow *explorerWindow;
@property (nonatomic, strong) FLEXExplorerViewController *explorerViewController;

@end

@implementation FLEXManager

+ (void)load
{
#ifdef DEBUG
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width - 30, 200, 30, 30);
        [button setTitle:@"" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:11.f];
        [button setTitleColor:[[UIColor redColor] colorWithAlphaComponent:0.3] forState:UIControlStateNormal];
        [button addTarget:[FLEXManager sharedManager] action:@selector(showExplorer) forControlEvents:UIControlEventTouchUpInside];
        [[[[UIApplication sharedApplication] delegate] window] addSubview:button];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:[FLEXManager sharedManager] action:@selector(moveTest:)];
        [button addGestureRecognizer:pan];
    });
#endif
}

- (void)moveTest:(UIGestureRecognizer *)gestureRecognizer
{
    gestureRecognizer.view.center = [gestureRecognizer locationInView:[[[UIApplication sharedApplication] delegate] window]];
}



+ (instancetype)sharedManager
{
    static FLEXManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[[self class] alloc] init];
    });
    return sharedManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.explorerWindow = [[FLEXWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.explorerWindow.eventDelegate = self;
        
        self.explorerViewController = [[FLEXExplorerViewController alloc] init];
        self.explorerViewController.delegate = self;
        self.explorerWindow.rootViewController = self.explorerViewController;
        [self.explorerWindow addSubview:self.explorerViewController.view];
    }
    return self;
}

- (void)showExplorer
{
    self.explorerWindow.hidden = NO;
}

- (void)hideExplorer
{
    self.explorerWindow.hidden = YES;
}

- (BOOL)isHidden
{
    return self.explorerWindow.isHidden;
}


#pragma mark - FLEXWindowEventDelegate

- (BOOL)shouldHandleTouchAtPoint:(CGPoint)pointInWindow
{
    // Ask the explorer view controller
    return [self.explorerViewController shouldReceiveTouchAtWindowPoint:pointInWindow];
}


#pragma mark - FLEXExplorerViewControllerDelegate

- (void)explorerViewControllerDidFinish:(FLEXExplorerViewController *)explorerViewController
{
    [self hideExplorer];
}

@end
