//
//  UITableViewController+ScrollToFullScreenEffect.m
//  BehaviourDemo
//
//  Created by joehsieh on 2015/10/30.
//  Copyright © 2015年 JH. All rights reserved.
//

#import "UITableViewController+ScrollToFullScreenEffect.h"
#import "NJScrollToFullScreenBehaviour.h"
#import "MultiplexerProxyBehaviour.h"

@implementation UITableViewController (ScrollToFullScreenEffect)

- (void)applyScrollToFullScreenEffect
{
    NJScrollToFullScreenBehaviour *scrollToFullScreenBehavior = [[NJScrollToFullScreenBehaviour alloc] initWithOwner:self scrollView:self.tableView];
    MultiplexerProxyBehaviour *multiplexerProxyBehaviour = [[MultiplexerProxyBehaviour alloc] initWithOwner:self];
    multiplexerProxyBehaviour.targets = @[self, scrollToFullScreenBehavior];
    self.tableView.delegate = (id)multiplexerProxyBehaviour;
}
@end
