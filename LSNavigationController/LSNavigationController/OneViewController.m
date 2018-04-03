//
//  OneViewController.m
//  LSNavigationController
//
//  Created by liusong on 2018/3/29.
//  Copyright © 2018年 liusong. All rights reserved.
//

#import "OneViewController.h"
#import "TwoViewController.h"
@interface OneViewController ()
@property (weak, nonatomic)  UILabel *label;
@property (nonatomic,assign) int i ;
@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self reloadNavigationBar];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleTime) userInfo:nil repeats:YES];
    
    [self.navigationBar setBackgroundImage:[self imageWithColor:[UIColor orangeColor]] forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithTitle:@"push" style:(UIBarButtonItemStylePlain) target:self action:@selector(click)];
    self.navigationItem.rightBarButtonItem=item;
    self.title=@"第一页";
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
    [self.view addSubview:label];
    label.font=[UIFont systemFontOfSize:14];

    self.label=label;
    NSLog(@"one ---------------");
    
  
}
-(void)click
{
    [self.navigationController pushViewController:[[TwoViewController alloc]init] animated:YES];
}

-(void)handleTime
{
    self.label.text=[NSString stringWithFormat:@"文字:%d",self.i];
    self.i++;
}



@end
