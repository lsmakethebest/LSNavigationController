//
//  LSNavigationController.h
//  LSNavigationBarTransition
//
//  Created by ls on 16/1/16.
//  Copyright © 2016年 song. All rights reserved.
//
#import "LSContentNavigationController.h"
#import "LSNavigationController.h"
#import "UIViewController+LSNavigationController.h"

@interface LSNavigationController ()


@end


@implementation LSNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationBar.hidden = YES;
    self.ls_cancelGesture=YES;
    [[UINavigationBar appearance ] setTintColor:[UIColor whiteColor]];
   
    [[UINavigationBar appearance ] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];


    [[UIBarButtonItem appearance ] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    [[UIBarButtonItem appearance ]setTintColor:[UIColor whiteColor]];
    self.fullScreenGesture=YES;
    
}

-(void)setFullScreenGesture:(BOOL)fullScreenGesture
{
    _fullScreenGesture=fullScreenGesture;
    
    if (fullScreenGesture) {
        // 获取系统自带滑动手势的target对象
        id target = self.interactivePopGestureRecognizer.delegate;
        SEL action=NSSelectorFromString(@"handleNavigationTransition:");
        // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:action];
        // 设置手势代理，拦截手势触发
        pan.delegate = self;
        // 给导航控制器的view添加全屏滑动手势
        [self.view addGestureRecognizer:pan];
        // 禁止使用系统自带的滑动手势
        self.interactivePopGestureRecognizer.enabled = NO;
    }
}


-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    
    if (self.ls_cancelGesture==NO) {
        return NO;
    }
    UINavigationController *nav= self.viewControllers.lastObject.childViewControllers.firstObject;
    if (nav.ls_normalPush) {
        if (nav.viewControllers.count<2) {
            return self.viewControllers.count!=1&&![[self valueForKey:@"_isTransitioning"] boolValue];
        }else{
            return NO;
        }
    }
    return self.viewControllers.count!=1&&![[self valueForKey:@"_isTransitioning"] boolValue];
}



- (instancetype)initWithRootViewController:(UIViewController*)rootViewController
{
    if (self = [super init]) {
        LSContentViewController* contentViewController = [LSContentViewController contentViewControllerWithViewController:rootViewController];
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
    }
    return self;
}


@end
