//
//  LSNavigationController.h
//  LSNavigationBarTransition
//
//  Created by ls on 16/1/16.
//  Copyright © 2016年 song. All rights reserved.
//
#import "LSContentNavigationController.h"
#import "LSContentViewController.h"
#import "LSNavigationController.h"

//最大移动比例可以pop
#define LSRightScale 0.4

@implementation LSNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationBar.hidden = YES;
    
    
    [[UINavigationBar appearance ] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UIBarButtonItem appearance ] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [[UIBarButtonItem appearance ]setTintColor:[UIColor whiteColor]];
    
    
}
- (instancetype)initWithRootViewController:(UIViewController*)rootViewController
{
    if (self = [super init]) {
        LSContentViewController* contentViewController = [LSContentViewController contentViewControllerWithViewController:rootViewController];
        //        rootViewController.ls_navigationController = self;
        self.viewControllers = @[ contentViewController ];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder*)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        UIViewController* rootViewController = self.topViewController;

        LSContentViewController* contentViewController = [LSContentViewController contentViewControllerWithViewController:rootViewController];
        [self pushViewController:contentViewController animated:NO];
        //解决用storyBoard初始化根控制器 设置title不显示问题
        NSString* title = rootViewController.navigationItem.title;
        rootViewController.title = [NSString stringWithFormat:@"%@.", rootViewController.navigationItem.title];
        rootViewController.title = title;

        //        self.viewControllers=@[contentViewController];
        //        rootViewController.ls_navigationController = self;
    }
    return self;
}
@end
