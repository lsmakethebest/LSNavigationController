//
//  ViewController.m
//  LSNavigatitonTransition
//
//  Created by ls on 16/1/11.
//  Copyright © 2016年 song. All rights reserved.
//

#import "UIColor+Extension.h"
#import "OneViewController.h"

@interface OneViewController ()

@property (weak, nonatomic) IBOutlet UILabel *myLabel;


@end
@implementation OneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent=NO;
    [self.navigationController.navigationBar setBackgroundImage:[[UIColor orangeColor] imageWithColor] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    [[UIBarButtonItem appearance ] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(startTime) userInfo:nil repeats:YES];
}

-(void)startTime
{
    static int i=0;
    self.myLabel.text=[NSString stringWithFormat:@"%d",i];
    i++;
}
@end
