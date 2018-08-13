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
    
    [self.navigationBar setBackgroundImage:[self ls_imageWithColor:[UIColor orangeColor]] forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithTitle:@"push" style:(UIBarButtonItemStylePlain) target:self action:@selector(click)];
    self.navigationItem.rightBarButtonItem=item;
    self.title=@"第一页";
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
    [self.view addSubview:label];
    label.font=[UIFont systemFontOfSize:14];

    self.label=label;
   
    
    UIButton *close=[[UIButton alloc]init];
    close.frame=CGRectMake(100, 100, 140, 50);
    [close setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [close setTitle:@"禁止手势打开" forState:UIControlStateNormal];
    [close setTitle:@"禁止手势关闭" forState:UIControlStateSelected];
    [close addTarget:self action:@selector(closeAll:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:close];
}
-(void)closeAll:(UIButton*)btn
{
    self.navigationController.cancelGesture=!self.navigationController.cancelGesture;
    btn.selected=self.navigationController.cancelGesture;
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
