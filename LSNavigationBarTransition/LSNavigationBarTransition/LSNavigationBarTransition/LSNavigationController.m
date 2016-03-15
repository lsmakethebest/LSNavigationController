//
//  LSNavigationController.h
//  LSNavigationBarTransition
//
//  Created by ls on 16/1/16.
//  Copyright © 2016年 song. All rights reserved.
//
#import "LSInteractionTransition.h"
#import "LSNavigationController.h"
#import "UIViewController+LSNavigationBarTransition.h"
#import <objc/runtime.h>
//最大移动比例可以pop
#define LSRightScale 0.4
//边缘手势比例
#define LSScreenEdgeScale 0.3

@implementation LSNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.fullScreenGesture = YES;
    self.delegate = self;
    self.navigationBar.delegate = self;
    self.stack = [[LSStack alloc] init];
    UIGestureRecognizer* gesture = self.interactivePopGestureRecognizer;
    gesture.enabled = NO;
    UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [self.view addGestureRecognizer:pan];
    pan.delegate = self;
}
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController*)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return self.interactionAnimation;
}
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController*)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController*)fromVC toViewController:(UIViewController*)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        return nil;
    }
    return self.interactionAnimation;
}
- (void)handleGesture:(UIPanGestureRecognizer*)recognizer
{

    CGFloat x = [recognizer translationInView:recognizer.view].x;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat locationX = [recognizer locationInView:recognizer.view].x;
    CGFloat scale = x / width;
    switch (recognizer.state) {
    case UIGestureRecognizerStateBegan: {
        if (!self.fullScreenGesture) {
            if (locationX > Screen_Width * LSScreenEdgeScale) {
                recognizer.enabled = NO;
                recognizer.enabled = YES;
                return;
            }
        }
        //此处是解决 如果连续右滑 但是每次都是滑动不点距离又松手，会出现导航栏不显示 截图也不显示bug
        if (self.navigationBar.hidden) {
            recognizer.enabled = NO;
            recognizer.enabled = YES;
            return;
        }
        self.interactionAnimation = [[LSInteractionTransition alloc] init];
        [self popViewControllerAnimated:YES];
    } break;
    case UIGestureRecognizerStateChanged: {
        if (x < 0) {
            [self.interactionAnimation updateWithPercent:0];
            return;
        }
        [self.interactionAnimation updateWithPercent:scale];
        break;
    }

    case UIGestureRecognizerStateEnded:
    case UIGestureRecognizerStateCancelled:
    case UIGestureRecognizerStateFailed: {
        CGFloat velocityX = [recognizer velocityInView:recognizer.view].x;
        if (velocityX > 800) {
            [self.interactionAnimation finishBy:YES];
            self.interactionAnimation = nil;
            return;
        }
        [self.interactionAnimation finishBy:scale > LSRightScale];
        self.interactionAnimation = nil;
        break;
    }
    default:
        break;
    }
}

- (void)pushViewController:(UIViewController*)viewController animated:(BOOL)animated
{
    [self.stack push:[self.navigationBar snapshotViewAfterScreenUpdates:NO]];
    [super pushViewController:viewController animated:animated];
}
- (NSArray<UIViewController*>*)popToViewController:(UIViewController*)viewController animated:(BOOL)animated
{
    int count = (int)self.viewControllers.count;
    int index = 0;
    for (int i = 0; i < count; i++) {
        if (self.viewControllers[i] == viewController) {
            index = i;
        }
    }
    if (count - 1 - index != 1 && count - 1 - index > 0) {
        for (int i = 0; i < count - 1 - index; i++) {
            [self.stack pop];
        }
    }
    return [super popToViewController:viewController animated:animated];
}
- (NSArray<UIViewController*>*)popToRootViewControllerAnimated:(BOOL)animated
{
    NSInteger count = self.viewControllers.count;
    if (self.viewControllers.count != 2 && self.viewControllers.count > 1) {
        for (int i = 0; i < count - 1; i++) {
            [self.stack pop];
        }
    }
    return [super popToRootViewControllerAnimated:animated];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer
{
    return self.viewControllers.count != 1 && ![[self valueForKey:@"_isTransitioning"] boolValue];
}
//此方法只有pop出去一个控制器时才会调用
- (void)navigationBar:(UINavigationBar*)navigationBar didPopItem:(UINavigationItem*)item
{
    [self.stack pop];
}
@end
