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
    self.title=@"第一页";
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleTime) userInfo:nil repeats:YES];
    
    
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithTitle:@"push" style:(UIBarButtonItemStylePlain) target:self action:@selector(click)];
    self.navigationItem.rightBarButtonItem=item;
    [self.navigationBar setBackgroundImage:[self imageWithColor:[UIColor orangeColor]] forBarMetrics:UIBarMetricsDefault];
    
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
    [self.view addSubview:label];
    self.label=label;
    NSLog(@"one ---------------");
    
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    view2.backgroundColor=[UIColor redColor];
    UIBarButtonItem *item2=[[UIBarButtonItem alloc]initWithCustomView:view2];
    self.navigationItem.leftBarButtonItem=item2;
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

- (UIImage*)imageWithColor:(UIColor*)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
