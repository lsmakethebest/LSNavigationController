//
//  ViewController.m
//  LSNavigatitonTransition
//
//  Created by ls on 16/1/11.
//  Copyright © 2016年 song. All rights reserved.
//

#import "UIColor+Extension.h"
#import "OneViewController.h"
@implementation OneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent=NO;
    [self.navigationController.navigationBar setBackgroundImage:[[UIColor orangeColor] imageWithColor] forBarMetrics:UIBarMetricsDefault];

}

@end
