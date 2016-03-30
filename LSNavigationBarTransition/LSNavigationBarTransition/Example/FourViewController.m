






//
//  FourViewController.m
//  LSNavigationBarTransition
//
//  Created by ls on 16/3/14.
//  Copyright © 2016年 song. All rights reserved.
//

#import "FourViewController.h"
#import "UIColor+Extension.h"
#import "LSContentNavigationController.h"
@interface FourViewController ()

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIColor imageWithColor] forBarMetrics:UIBarMetricsDefault];
}

- (IBAction)popToTwoViewController:(id)sender {
    LSContentNavigationController*nav=    self.navigationController;
    nav.normalPush=YES;
    [self.navigationController pushViewController:[[UIViewController alloc ]init] animated:YES];
//    [self.navigationController popToViewController:self.navigationController.viewControllers[2] animated:YES];
    
    
    
}
-(void)dealloc
{
    
}
@end
