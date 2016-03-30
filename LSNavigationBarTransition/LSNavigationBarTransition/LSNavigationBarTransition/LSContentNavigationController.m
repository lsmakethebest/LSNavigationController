

//
//  LSContentNavigationController.m
//  LSNavigationBarTransition
//
//  Created by ls on 16/3/22.
//  Copyright © 2016年 song. All rights reserved.
//

#import "LSContentNavigationController.h"
#import "LSContentViewController.h"
#import "LSNavigationController.h"
@implementation LSContentNavigationController

- (void)pushViewController:(UIViewController*)viewController animated:(BOOL)animated
{
    if (self.normalPush) {
        NSMutableArray *array=[NSMutableArray arrayWithArray:self.viewControllers];
        [array addObject:viewController];
        [self setViewControllers:array animated:animated];
        return;
    }
    viewController.hidesBottomBarWhenPushed = YES;
    LSContentViewController* contentViewController = [LSContentViewController contentViewControllerWithViewController:viewController];

    UIImage* backButtonImage = [UIImage imageNamed:@"backImage"];
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(didClickBackButton)];
    [self.navigationController pushViewController:contentViewController animated:animated];
//    viewController.ls_navigationController = self.navigationController;
}

#pragma mark - 自己添加的左上角返回按钮
- (void)didClickBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (UIViewController*)popViewControllerAnimated:(BOOL)animated
{
return  [self.navigationController popViewControllerAnimated:animated];
    return nil;
}

- (NSArray<UIViewController*>*)popToRootViewControllerAnimated:(BOOL)animated
{


//    NSMutableArray *array=[NSMutableArray arrayWithArray:self.navigationController.viewControllers];
//    for (int i=0; i<self.navigationController.viewControllers.count-1; i++) {
//        [array removeLastObject];
//    }
//    [self.navigationController setViewControllers:array animated:YES];
//    return self.viewControllers.firstObject;
    return [self.navigationController popToRootViewControllerAnimated:animated];
}
#pragma mark -根据不同情况决定返回的子控制器个数
-(NSArray<UIViewController *> *)viewControllers
{
    NSArray *controllers=[super viewControllers];
//    if (controllers.count==1) {
//     
//        controllers=self.navigationController.viewControllers;
//    }
    return controllers;
}
-(NSArray<UIViewController *> *)ls_viewControllers
{
    
    return nil;
}
- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    LSNavigationController *nav = self.navigationController;
    NSInteger index = [nav.viewControllers indexOfObject:viewController];
    return [self.navigationController popToViewController:self.navigationController.viewControllers[index] animated:animated];
}
@end
