

//
//  UINavigationController+LSNavigationBarTransition.m
//  LSNavigationBarTransition
//
//  Created by ls on 16/1/16.
//  Copyright © 2016年 song. All rights reserved.
//

#import "LSSwizzle.h"
#import <objc/runtime.h>
#import "LSImageView.h"
#import "LSStack.h"
#import "UINavigationController+LSNavigationBarTransition.h"
#import "UIViewController+LSNavigationBarTransition.h"
#define LSScreenWidth [UIScreen mainScreen].bounds.size.width
#define LSRightScale 0.2
#define Scale 3
@implementation UINavigationController (LSNavigationBarTransition)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        LSSwizzleInstanceMethod([self class],
            @selector(viewDidLoad),
            @selector(ls_navigaionControllerViewDidLoad));
        LSSwizzleInstanceMethod([self class],
            @selector(pushViewController:animated:),
            @selector(ls_pushViewController:animated:));

        LSSwizzleInstanceMethod([self class],
            @selector(popViewControllerAnimated:),
            @selector(ls_popViewControllerAnimated:));

        LSSwizzleInstanceMethod([self class],
            @selector(popToViewController:animated:),
            @selector(ls_popToViewController:animated:));

        LSSwizzleInstanceMethod([self class],
            @selector(popToRootViewControllerAnimated:),
            @selector(ls_popToRootViewControllerAnimated:));
    });
}
- (void)ls_navigaionControllerViewDidLoad
{
    [self ls_navigaionControllerViewDidLoad];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIGestureRecognizer* gesture = self.interactivePopGestureRecognizer;
        gesture.enabled = NO;
        UIScreenEdgePanGestureRecognizer* pan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        pan.edges = UIRectEdgeLeft;
        [self.view addGestureRecognizer:pan];
        pan.delegate = self;

    });
}
- (void)handleGesture:(UIScreenEdgePanGestureRecognizer*)recognizer
{
    CGFloat x = [recognizer translationInView:recognizer.view].x;
    if (x < 0) {
        self.frontControllerView.transform = CGAffineTransformIdentity;
        self.view.transform = CGAffineTransformIdentity;
        self.frontControllerView.scaleAlpha=0;
        return;
    }
    self.topViewController.view.userInteractionEnabled = NO;
    switch (recognizer.state) {
    case UIGestureRecognizerStateBegan: {
        if (self.frontControllerView == nil) {
            LSImageView* imageView = [[LSImageView alloc] init];
            imageView.backgroundColor = [UIColor whiteColor];
            imageView.image = [[LSStack sharedInstance] getTop];
            CGRect frame = self.view.window.bounds;
            frame.origin.x = -LSScreenWidth * LSRightScale;
            imageView.frame = frame;
            [self.view.window insertSubview:imageView belowSubview:self.view];
            self.frontControllerView = imageView;
        }
        break;
    }
    case UIGestureRecognizerStateChanged: {
        ;
        self.frontControllerView.transform = CGAffineTransformMakeTranslation(x * LSRightScale, 0);
        self.view.transform = CGAffineTransformMakeTranslation(x, 0);
        self.frontControllerView.scaleAlpha=x/LSScreenWidth;
        break;
    }
    case UIGestureRecognizerStateCancelled:
    case UIGestureRecognizerStateEnded: {
        //打开用户交互
        self.topViewController.view.userInteractionEnabled = YES;
        if (x >= self.view.frame.size.width / Scale) {
            [UIView animateWithDuration:0.2 animations:^{
                self.frontControllerView.transform = CGAffineTransformMakeTranslation(LSScreenWidth * LSRightScale, 0);
                self.frontControllerView.scaleAlpha=1;
                self.view.transform = CGAffineTransformMakeTranslation(LSScreenWidth, 0);
            }
                completion:^(BOOL finished) {
                    [self.frontControllerView removeFromSuperview];
                    self.frontControllerView = nil;
                    self.view.transform = CGAffineTransformIdentity;
                    [self popViewControllerAnimated:NO];
                }];
        }
        else {
            [UIView animateWithDuration:0.2 animations:^{
                self.frontControllerView.transform = CGAffineTransformIdentity;
                self.frontControllerView.scaleAlpha=0;
                self.view.transform = CGAffineTransformIdentity;
            }];
        }
    } break;
    default:
        break;
    }
}

- (void)ls_pushViewController:(UIViewController*)viewController animated:(BOOL)animated
{
    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
    NSBlockOperation* operation = [NSBlockOperation blockOperationWithBlock:^{
        [[LSStack sharedInstance] push:[self captureView]];

    }];
    operation.completionBlock = ^() {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self ls_pushViewController:viewController animated:animated];
        }];
    };
    [queue addOperation:operation];
}
- (UIViewController*)ls_popViewControllerAnimated:(BOOL)animated
{
    [[LSStack sharedInstance] pop];
    return [self ls_popViewControllerAnimated:animated];
}
- (NSArray<UIViewController*>*)ls_popToViewController:(UIViewController*)viewController animated:(BOOL)animated
{

    int count = (int)self.viewControllers.count;
    //     A B D C
    for (int i = count - 1; i > 0; i--) {
        if (self.viewControllers[i] != viewController) {
            [[LSStack sharedInstance] pop];
        }
        else {
            break;
        }
    }
    return [self ls_popToViewController:viewController animated:animated];
}
- (NSArray<UIViewController*>*)ls_popToRootViewControllerAnimated:(BOOL)animated
{
    NSInteger count = self.viewControllers.count;
    for (int i = 0; i < count - 1; i++) {
        [[LSStack sharedInstance] pop];
    }
    return [self ls_popToRootViewControllerAnimated:animated];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer
{
    return self.viewControllers.count != 1 && ![[self valueForKey:@"_isTransitioning"] boolValue];
}
- (void)setFrontControllerView:(LSImageView*)frontControllerView
{
    objc_setAssociatedObject(self, @selector(frontControllerView), frontControllerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (LSImageView*)frontControllerView
{
    return objc_getAssociatedObject(self, _cmd);
}
- (UIImage*)captureView
{
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, YES, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:context];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
