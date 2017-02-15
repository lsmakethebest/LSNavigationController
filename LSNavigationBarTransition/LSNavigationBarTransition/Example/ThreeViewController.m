

//
//  ThreeViewController.m
//  LSNavigatitonTransition
//
//  Created by ls on 16/1/16.
//  Copyright © 2016年 song. All rights reserved.
//

#import "ThreeViewController.h"
#import "UIColor+Extension.h"
#import "LSNavigationController.h"
#import "FourViewController.h"
#import "LSNavigationControllerKit.h"
@implementation ThreeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIColor imageWithColor] forBarMetrics:UIBarMetricsDefault];
}

- (IBAction)popToRoot:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)popToTwo:(id)sender {
    
    
    [self.navigationController popToViewController:self.ls_topNavigationController.viewControllers[1] animated:YES];
}

@end
