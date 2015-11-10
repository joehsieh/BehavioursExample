//
//  NJScrollToFullScreenBehaviour.h
//  BehaviourExample
//
//  Created by joehsieh on 2015/10/26.
//  Copyright © 2015年 NJ. All rights reserved.
//

/*!
 Hide navigationBar, tabbar if need when scrollView is scrolling down to browse more items and vice versa.
 */

#import "KZBehaviour.h"

@interface NJScrollToFullScreenBehaviour : KZBehaviour <UIScrollViewDelegate>
- (instancetype)initWithOwner:(id)owner scrollView:(UIScrollView *)scrollView;
/*! Adjust the components which cover part of screen in viewController by the position of scrollView, default:nil */
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
/*! Disable effect of hiding by scrolling for navigationBar, default: NO*/
@property (nonatomic, assign) BOOL disableNavigationBarEffectIfNeed;
/*! Disable effect of hiding by scrolling for tabBar, default: NO */
@property (nonatomic, assign) BOOL disableTabBarEffectIfNeed;
/*! The distance of threshold for dragging to full screen, default: 0.0 */
@property (nonatomic, assign) CGFloat distanceOfThresholdForDraggingToFullScreen;
@end
