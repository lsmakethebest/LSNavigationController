

//
//  LSContentViewController.m
//  LSNavigationBarTransition
//
//  Created by ls on 16/3/22.
//  Copyright © 2016年 song. All rights reserved.
//

#import "LSContentViewController.h"
#import "LSContentNavigationController.h"
static NSValue *ls_tabBarRectValue;
@implementation LSContentViewController

+ (instancetype)contentViewControllerWithViewController:(UIViewController*)viewController
{
    
    LSContentNavigationController* contentNavigationController = [[LSContentNavigationController alloc] init];
    contentNavigationController.viewControllers=@[viewController];
//    contentNavigationController.view.frame=CGRectMake(50, 25, 100, 100);
    LSContentViewController* contentViewController = [[LSContentViewController alloc] init];
//    contentNavigationController.view.clipsToBounds=YES;
    
    [contentViewController.view addSubview:contentNavigationController.view];
//    contentViewController.view.frame=CGRectMake(0, 300, 200, 200);
    [contentViewController addChildViewController:contentNavigationController];
    
    return contentViewController;
}
//- (void)viewDidLayoutSubviews {
//    [super viewDidLayoutSubviews];
//    
//    if (self.tabBarController && !ls_tabBarRectValue) {
//        ls_tabBarRectValue = [NSValue valueWithCGRect:self.tabBarController.tabBar.frame];
//    }
//    
//}
//
//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    
//    if (self.tabBarController && [self rootViewController].hidesBottomBarWhenPushed) {
//        self.tabBarController.tabBar.frame = CGRectZero;
//    }
//}
//
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    self.tabBarController.tabBar.translucent = YES;
//    if (self.tabBarController && !self.tabBarController.tabBar.hidden && ls_tabBarRectValue) {
//        self.tabBarController.tabBar.frame = ls_tabBarRectValue.CGRectValue;
//    }
//}

- (BOOL)hidesBottomBarWhenPushed {
    return [self rootViewController].hidesBottomBarWhenPushed;
}

- (UITabBarItem *)tabBarItem {
    return [self rootViewController].tabBarItem;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return [self rootViewController];
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return [self rootViewController];
}

//- (NSString *)title {
//    return [self rootViewController].title;
//}

-(UIViewController*)rootViewController
{
    LSContentNavigationController *nav=self.childViewControllers.firstObject;
    return nav.topViewController;
}
@end