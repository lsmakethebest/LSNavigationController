//
//  ViewController.m
//  LSNavigatitonTransition
//
//  Created by ls on 16/1/11.
//  Copyright © 2016年 song. All rights reserved.
//

#import "UIColor+Extension.h"
#import "OneViewController.h"
#import "OneTableViewController.h"
@interface OneViewController ()

@property (weak, nonatomic) IBOutlet UILabel *myLabel;

@property (nonatomic, assign) int time;

@end
@implementation OneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.time=0;
    [self.navigationController.navigationBar setBackgroundImage:[UIColor imageWithColor] forBarMetrics:UIBarMetricsDefault];
    
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(startTime) userInfo:nil repeats:YES];
    
    UIButton *btn=[[UIButton alloc]init];
    btn.frame=CGRectMake(100, 100, 100, 50);
    [btn setTitle:@"跳转到tableview" forState:UIControlStateNormal];
    btn.backgroundColor=[UIColor redColor];
    [btn  addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)click
{
    [self.navigationController pushViewController:[[OneTableViewController alloc]init] animated:YES];
}
-(void)startTime
{

    self.myLabel.text=[NSString stringWithFormat:@"%d",self.time];
    self.time++;
}


@end
