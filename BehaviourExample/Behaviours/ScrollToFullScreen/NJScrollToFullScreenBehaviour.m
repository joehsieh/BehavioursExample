//
//  NJScrollToFullScreenBehaviour.m
//  BehaviourExample
//
//  Created by joehsieh on 2015/10/26.
//  Copyright © 2015年 NJ. All rights reserved.
//

#import "NJScrollToFullScreenBehaviour.h"
#import <objc/runtime.h>
#import "Aspects.h"

@interface NJScrollToFullScreenBehaviour ()
/*! Last offset of cotent, default: (0.0, 0.0)*/
@property (nonatomic, assign) CGPoint lastContentOffset;
@end
@implementation NJScrollToFullScreenBehaviour

- (instancetype)initWithOwner:(id)owner scrollView:(UIScrollView *)scrollView
{
    self = [super initWithOwner:owner];
    if (self) {
        self.scrollView = scrollView;
    }
    return self;
}

- (void)setOwner:(id)owner
{
    [super setOwner:owner];
    [self.owner aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated) {
        [self nj_resetPositionOfComponents];
    } error:NULL];
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _lastContentOffset = scrollView.contentOffset;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!scrollView.isTracking) {
        return;
    }
    CGFloat movedDistance = scrollView.contentOffset.y - _lastContentOffset.y;
    if (ABS(movedDistance) < _distanceOfThresholdForDraggingToFullScreen) {
        return;
    }
    [self nj_tunesPositionOfComponentsByMovedDistance:movedDistance scrollView:scrollView];
}

- (void)nj_tunesPositionOfComponentsByMovedDistance:(CGFloat)movedDistance scrollView:(UIScrollView *)scrollView
{
    BOOL moveUp = movedDistance <= 0.0;
    // Tunes the position of navigationBar
    if (!_disableNavigationBarEffectIfNeed && [self.owner respondsToSelector:@selector(navigationController)] && [self.owner isKindOfClass:[UIViewController class]]) {
        UINavigationBar *navigationBar = [[self.owner navigationController] navigationBar];
        CGRect rect = navigationBar.frame;
        CGFloat heightOfNavigationBar = CGRectGetHeight(navigationBar.frame);
        CGFloat heightOfStatusBar = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
        CGFloat maxNavigationBarY = heightOfStatusBar;
        CGFloat minNavigationBarY = -(heightOfStatusBar + heightOfNavigationBar);
        UIEdgeInsets contentInset = scrollView.contentInset;
        if (moveUp) {
            rect.origin.y = maxNavigationBarY;
            if (movedDistance != 0.0) {
                contentInset.top = heightOfNavigationBar + heightOfStatusBar;
            }
        }
        else {
            rect.origin.y = minNavigationBarY;
            if (movedDistance != 0.0) {
                contentInset.top = 0.0;
            }
        }
        [UIView animateWithDuration:0.3 animations:^{
            navigationBar.frame = rect;
            scrollView.contentInset = contentInset;
            scrollView.scrollIndicatorInsets = contentInset;
        }];
    }
    
    // Tunes the position of tabBar
    if (!_disableTabBarEffectIfNeed && [self.owner respondsToSelector:@selector(tabBarController)]) {
        UITabBar *tabBar = [[self.owner tabBarController] tabBar];
        CGRect rect = tabBar.frame;
        CGFloat maxTabBarY = CGRectGetMaxY([self.owner view].frame);
        CGFloat heightOfTabBar = CGRectGetHeight(tabBar.frame);
        CGFloat minTabBarY = maxTabBarY - heightOfTabBar;
        UIEdgeInsets contentInset = scrollView.contentInset;
        if (moveUp) {
            rect.origin.y = minTabBarY;
            contentInset.bottom = heightOfTabBar;
        }
        else {
            rect.origin.y = maxTabBarY;
            contentInset.bottom = 0.0;
        }
        [UIView animateWithDuration:0.3 animations:^{
            tabBar.frame = rect;
            scrollView.contentInset = contentInset;
            scrollView.scrollIndicatorInsets = contentInset;
        }];
    }
}

- (void)nj_resetPositionOfComponents
{
    [self nj_tunesPositionOfComponentsByMovedDistance:0.0 scrollView:_scrollView];
}

@end
