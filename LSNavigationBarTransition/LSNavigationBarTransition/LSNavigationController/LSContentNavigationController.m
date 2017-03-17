

//
//  LSContentNavigationController.m
//  LSNavigationBarTransition
//
//  Created by ls on 16/3/22.
//  Copyright © 2016年 song. All rights reserved.
//

#import "LSContentNavigationController.h"
#import "LSNavigationController.h"
#import "UIViewController+LSNavigationController.h"

@interface LSContentNavigationController ()<UIGestureRecognizerDelegate>


@end

@implementation LSContentNavigationController

- (void)pushViewController:(UIViewController*)viewController animated:(BOOL)animated
{
    //设置最上层导航控制器，方便获取到
    viewController.ls_topNavigationController=self.navigationController;
    UIImage* backButtonImage = [UIImage imageNamed:[@"LSNavigationController.bundle" stringByAppendingPathComponent:@"backImage"]];
    
    if (self.ls_normalPush||viewController.ls_normalPush) {
        self.ls_normalPush=YES;
        if (self.ls_normalPush) {
            viewController.ls_normalPush=YES;
        }
            
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(didClickBackButton)];
        [super pushViewController:viewController animated:animated];
        
        return;
    }
    
    
    viewController.hidesBottomBarWhenPushed = YES;
    LSContentViewController* contentViewController = [LSContentViewController contentViewControllerWithViewController:viewController];
    
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(didClickBackButton)];
    [self.navigationController pushViewController:contentViewController animated:animated];

}


#pragma mark - 自己添加的左上角返回按钮
- (void)didClickBackButton
{
    if (self.viewControllers.lastObject.ls_normalPush) {
        [self popViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (UIViewController*)popViewControllerAnimated:(BOOL)animated
{
    if (self.viewControllers.count>=2&&self.viewControllers.lastObject.ls_normalPush) {
        return  [super popViewControllerAnimated:animated];
    }
    return  [self.navigationController popViewControllerAnimated:animated];
    
}

- (NSArray<UIViewController*>*)popToRootViewControllerAnimated:(BOOL)animated
{

    if (self.ls_normalPush) {
        return  [super popToRootViewControllerAnimated:animated];
    }
    return [self.navigationController popToRootViewControllerAnimated:animated];
}


- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.ls_normalPush&&[self.viewControllers containsObject:viewController]) {
        return  [super popToViewController:viewController animated:animated];
    }
    return [self.navigationController popToViewController:viewController animated:animated];
    
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate=self;
    self.ls_cancelGesture=YES;
    
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.ls_cancelGesture==NO) {
        return NO;
    }
    return self.viewControllers.count>1;
}


@end


static NSValue *ls_tabBarRectValue;
@implementation LSContentViewController

+ (instancetype)contentViewControllerWithViewController:(UIViewController*)viewController
{
    
    LSContentNavigationController* contentNavigationController = [[LSContentNavigationController alloc] init];
    contentNavigationController.viewControllers=@[viewController];
    LSContentViewController* contentViewController = [[LSContentViewController alloc] init];
    
    [contentViewController.view addSubview:contentNavigationController.view];
    
    [contentViewController addChildViewController:contentNavigationController];
    
    return contentViewController;
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    if (self.tabBarController && !ls_tabBarRectValue) {
        ls_tabBarRectValue = [NSValue valueWithCGRect:self.tabBarController.tabBar.frame];
    }

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (self.tabBarController && [self rootViewController].hidesBottomBarWhenPushed) {
        self.tabBarController.tabBar.frame = CGRectZero;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.translucent = YES;
    if (self.tabBarController && !self.tabBarController.tabBar.hidden && ls_tabBarRectValue) {
        self.tabBarController.tabBar.frame = ls_tabBarRectValue.CGRectValue;
    }
}



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

- (NSString *)title {
    return [self rootViewController].title;
}

-(UIViewController*)rootViewController
{
    LSContentNavigationController *nav=self.childViewControllers.firstObject;
    return nav.topViewController;
}


@end



