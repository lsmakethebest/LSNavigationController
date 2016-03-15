/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 The interaction controller for the Swipe demo.  Tracks a UIScreenEdgePanGestureRecognizer
 from a specified screen edge and derives the completion percentage for the
 transition.
 */

#import "LSInteractionTransition.h"
#import "LSNavigationController.h"
@interface LSInteractionTransition ()
@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, weak) LSNavigationController* navigationController;
@property (nonatomic, weak) UIView* temoView;
@property (nonatomic, strong) LSStack* leftStack;
@property (nonatomic, weak) UIView* leftView;
@property (nonatomic, weak) UIView* rightView;
@property (nonatomic, weak) UIView* leftNavigationBarView;
@property (nonatomic, weak) UIView* rightNavigationBarView;
@property (nonatomic, weak) UIView* maskView;
@end

@implementation LSInteractionTransition
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.leftStack = [[LSStack alloc] init];
    }
    return self;
}
- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.transitionContext = transitionContext;
    UIView* containerView = transitionContext.containerView;
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    fromViewController.navigationController.navigationBar.hidden=NO;
    CGRect frame = toViewController.view.frame;
    frame.origin.x = -Screen_Width/2;
    toViewController.view.frame = frame;
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];

    //导航栏截图添加到fromView上
    UIView* rightNavigationBarView = [fromViewController.navigationController.navigationBar snapshotViewAfterScreenUpdates:NO];
    rightNavigationBarView.frame = CGRectMake(0, -44, Screen_Width, 44);
    [fromViewController.view addSubview:rightNavigationBarView];
    self.rightNavigationBarView = rightNavigationBarView;

    self.navigationController = (LSNavigationController*)fromViewController.navigationController;
    
    //导航栏截图添加到toView上
    UIView* leftNavigationBarView = [self.navigationController.stack getTop];
    leftNavigationBarView.frame = CGRectMake(0, -44, Screen_Width, 44);
    [toViewController.view addSubview:leftNavigationBarView];
    self.leftNavigationBarView = leftNavigationBarView;

    self.rightView = fromViewController.view;
    self.leftView = toViewController.view;
    
    //蒙版view
    UIView* maskView = [[UIView alloc] init];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.frame = CGRectMake(0, 0, Screen_Width, self.navigationController.view.frame.size.height);
    [self.leftView addSubview:maskView];
    maskView.alpha = 0.5;
    self.maskView = maskView;
}

- (void)updateWithPercent:(CGFloat)percent
{
 
    self.navigationController.navigationBar.hidden = YES;
    CGFloat scale = fabs(percent);
    self.rightView.transform = CGAffineTransformMakeTranslation(scale * Screen_Width, 0);
    self.leftView.transform = CGAffineTransformMakeTranslation(scale * Screen_Width / 2, 0);
    [self.transitionContext updateInteractiveTransition:percent];
    self.maskView.alpha = 0.5 - percent / 2;
}

- (void)finishBy:(BOOL)finished
{
    if (!finished) {
        [UIView animateWithDuration:0.3 animations:^{
            self.rightView.transform = CGAffineTransformIdentity;
            self.leftView.transform = CGAffineTransformIdentity;
            self.maskView.alpha = 0.5;
        }
            completion:^(BOOL finished) {
                [self.transitionContext cancelInteractiveTransition];
                [self.transitionContext updateInteractiveTransition:0];
                [self.transitionContext completeTransition:NO];
                [self.maskView removeFromSuperview];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    self.navigationController.navigationBar.hidden = NO;
                        [self.rightNavigationBarView removeFromSuperview];
                        self.rightNavigationBarView = nil;
                        [self.leftNavigationBarView removeFromSuperview];
                        self.leftNavigationBarView = nil;
                });
            }];
    }
    else { //完成
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        [UIView animateWithDuration:0.3 animations:^{
            self.rightView.transform = CGAffineTransformMakeTranslation(width, 0);
            self.leftView.transform = CGAffineTransformMakeTranslation(width / 2, 0);
            self.maskView.alpha = 0;
        }
            completion:^(BOOL finished) {
                [self.maskView removeFromSuperview];
                [self.transitionContext updateInteractiveTransition:1];
                [self.transitionContext finishInteractiveTransition];
                [self.transitionContext completeTransition:YES];
                [self.rightNavigationBarView removeFromSuperview];
                self.rightNavigationBarView = nil;
                self.leftView.transform = CGAffineTransformIdentity;
                CGRect frame = self.leftView.frame;
                frame.origin.x = 0;
                self.leftView.frame = frame;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    self.navigationController.navigationBar.hidden = NO;
                    [self.leftNavigationBarView removeFromSuperview];
                    self.leftNavigationBarView = nil;
                });
            }];
    }
}
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}
@end

#pragma mark - 栈
@interface LSStack ()

@property (nonatomic, strong) NSMutableArray *views;

@end


@implementation LSStack

-(NSMutableArray *)views
{
    if (_views==nil) {
        _views=[NSMutableArray array];
    }
    return _views;
}
-(void)pop
{
    if (![self isEmpty]) {
        [self.views removeLastObject];
    }
}
-(void)push:(id)obj
{
    if (obj) {
        [self.views addObject:obj];
    }
}
-(id)getTop
{
    if (![self isEmpty]) {
        return self.views.lastObject;
    }else {
        
        return nil;
    }
    
}
-(BOOL)isEmpty
{
    if (self.views.count) {
        return NO;
    }else{
        return YES;
    }
}


@end
