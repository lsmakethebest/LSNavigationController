

//
//  ThreeViewController.m
//  LSNavigatitonTransition
//
//  Created by ls on 16/1/16.
//  Copyright © 2016年 song. All rights reserved.
//

#import "ThreeViewController.h"
#import "UIColor+Extension.h"
@implementation ThreeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[[UIColor colorWithRed:0.402 green:0.559 blue:1.000 alpha:1.000] imageWithColor] forBarMetrics:UIBarMetricsDefault];
}

- (IBAction)popToRoot:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)dealloc
{
    
}
@end
