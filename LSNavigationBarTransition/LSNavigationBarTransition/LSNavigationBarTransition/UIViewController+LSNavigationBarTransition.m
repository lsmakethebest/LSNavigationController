

//
//  UIViewController+LSNavigationBarTransition.m
//  LSNavigationBarTransition
//
//  Created by ls on 16/1/16.
//  Copyright © 2016年 song. All rights reserved.
//

#import "LSSwizzle.h"
#import "UIColor+Extension.h"
#import "UIViewController+LSNavigationBarTransition.h"
#import <objc/runtime.h>

@implementation UIViewController (LSNavigationBarTransition)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        LSSwizzleInstanceMethod([self class],
                                @selector(viewDidLoad),
                                @selector(ls_viewDidLoad));
        LSSwizzleInstanceMethod([self class],
                                @selector(viewWillLayoutSubviews),
                                @selector(ls_viewWillLayoutSubviews));
        
    });
}
- (void)ls_viewDidLoad
{
    [self ls_viewDidLoad];
    //此处设置全局状态栏背景 其他控制器想修改UINavigationBar背景色可以在viewDidLoad里修改,不会影响其他控制器UINavigationBar背景色
    [self.navigationController.navigationBar setBackgroundImage:[[UIColor colorWithRed:0.671 green:0.184 blue:1.000 alpha:1.000] imageWithColor] forBarMetrics:UIBarMetricsDefault];
}
- (void)ls_viewWillLayoutSubviews
{
    if (self.navigationController.viewControllers.count) {
        
        if (!self.ls_navigationBar) {
            [self ls_addNavigationBarIfNeed];
            self.ls_prefersNavigationBarBackgroundViewHidden = YES;
        }
    }
    [self ls_viewWillLayoutSubviews];
}

- (UINavigationBar*)ls_navigationBar
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setLs_navigationBar:(UINavigationBar*)ls_navigationBar
{
    objc_setAssociatedObject(self, @selector(ls_navigationBar), ls_navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)ls_prefersNavigationBarBackgroundViewHidden
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setLs_prefersNavigationBarBackgroundViewHidden:(BOOL)hidden
{
    [[self.navigationController.navigationBar valueForKey:@"_backgroundView"]
     setHidden:hidden];
    objc_setAssociatedObject(self, @selector(ls_prefersNavigationBarBackgroundViewHidden), @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)ls_addNavigationBarIfNeed
{
    if (!self.view.window) {
        return;
    }
    if (!self.navigationController.navigationBar) {
        return;
    }
    UIView* backgroundView = [self.navigationController.navigationBar valueForKey:@"_backgroundView"];
    CGRect rect = [backgroundView.superview convertRect:backgroundView.frame toView:self.view];
    UINavigationBar* bar = [[UINavigationBar alloc] initWithFrame:rect];
    bar.barStyle = self.navigationController.navigationBar.barStyle;
    if (bar.translucent != self.navigationController.navigationBar.translucent) {
        bar.translucent = self.navigationController.navigationBar.translucent;
    }
    bar.barTintColor = self.navigationController.navigationBar.barTintColor;
    [bar setBackgroundImage:[self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault] forBarMetrics:UIBarMetricsDefault];
    bar.shadowImage = self.navigationController.navigationBar.shadowImage;
    bar.backgroundColor = self.navigationController.navigationBar.backgroundColor;
    bar.translucent = self.navigationController.navigationBar.translucent;
    self.ls_navigationBar = bar;
    if (!self.navigationController.navigationBarHidden) {
        [self.view addSubview:self.ls_navigationBar];
    }
}
@end
