
//
//  LSNavigationController.m
//  LSNavigationController
//
//  Created by liusong on 2018/3/22.
//  Copyright © 2018年 liusong. All rights reserved.
//

#import "LSNavigationController.h"
#import <objc/runtime.h>
#import "LSNavigationBar.h"
#import "LSViewController.h"
#import <objc/runtime.h>
@interface LSNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,strong) UIPanGestureRecognizer *panRecognizer;

@end


@implementation LSNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.hidden=YES;
    LSTopNavigationBar *navbar=[[LSTopNavigationBar alloc]init] ;
    navbar.hidden=NO;
    [self setValue:navbar forKeyPath:@"_navigationBar"];

    self.interactivePopGestureRecognizer.delegate=self;
    
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{

    if ([viewController isKindOfClass:[LSViewController class]]) {
        LSViewController *vc=(LSViewController*)viewController;
        vc.ls_navigationController=self;
    }
    if (self.viewControllers.count>=1) {
        viewController.hidesBottomBarWhenPushed=YES;
    }
    [super pushViewController:viewController animated:animated];
}
-(void)setCancelGesture:(BOOL)cancelGesture
{
    _cancelGesture=cancelGesture;
    self.interactivePopGestureRecognizer.enabled=!cancelGesture;
}
@end





