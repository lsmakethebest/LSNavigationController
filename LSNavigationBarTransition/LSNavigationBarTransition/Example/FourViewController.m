






//
//  FourViewController.m
//  LSNavigationBarTransition
//
//  Created by ls on 16/3/14.
//  Copyright © 2016年 song. All rights reserved.
//

#import "FourViewController.h"
#import "UIColor+Extension.h"
@interface FourViewController ()

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[[UIColor colorWithRed:0.556 green:1.000 blue:0.274 alpha:1.000] imageWithColor] forBarMetrics:UIBarMetricsDefault];
}

- (IBAction)popToTwoViewController:(id)sender {
    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
}

@end
