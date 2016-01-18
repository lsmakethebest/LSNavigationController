

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
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[[UIColor yellowColor] imageWithColor] forBarMetrics:UIBarMetricsDefault];
}
@end
