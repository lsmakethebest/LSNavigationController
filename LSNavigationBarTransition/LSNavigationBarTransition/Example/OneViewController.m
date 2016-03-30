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

@property (nonatomic, assign) int time;

@end
@implementation OneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.time=0;
    [self.navigationController.navigationBar setBackgroundImage:[UIColor imageWithColor] forBarMetrics:UIBarMetricsDefault];
    
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(startTime) userInfo:nil repeats:YES];
}

-(void)startTime
{

    self.myLabel.text=[NSString stringWithFormat:@"%d",self.time];
    self.time++;
}
@end
