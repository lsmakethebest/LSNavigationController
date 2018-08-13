

//
//  TwoViewController.m
//  LSNavigationController
//
//  Created by liusong on 2018/3/27.
//  Copyright © 2018年 liusong. All rights reserved.
//

#import "TwoViewController.h"
#import "ThreeViewController.h"

@interface TwoViewController ()

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor purpleColor];
    self.edgesForExtendedLayout=UIRectEdgeTop;
    [self reloadNavigationBar];

    self.title=@"第二页";
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithTitle:@"push" style:(UIBarButtonItemStylePlain) target:self action:@selector(pushThree)];
    self.navigationItem.rightBarButtonItem=item;
   
   
    
    
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(50, 64, 100, 50)];
    [btn setTitle:@"showView" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor=[UIColor blueColor];
    [self.view addSubview:btn];
    
    UIButton *btn2=[[UIButton alloc]initWithFrame:CGRectMake(50, 164, 100, 50)];
    [btn2 setTitle:@"pushVC" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(pushVC) forControlEvents:UIControlEventTouchUpInside];
    btn2.backgroundColor=[UIColor blueColor];
    [self.view addSubview:btn2];
    
    
    UIButton *btn3=[[UIButton alloc]initWithFrame:CGRectMake(50, 234, 100, 50)];
    [btn3 setTitle:@"back" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    btn3.backgroundColor=[UIColor blueColor];
    [self.view addSubview:btn3];
    
    
    
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)show
{
    CGSize size=[UIScreen mainScreen].bounds.size;
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0,size.width, size.height)];
    view.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.6];
    view.viewLevel=UIViewLevelHigh;
    
    UIButton *btn=[[UIButton alloc]init];
    btn.frame=CGRectMake(100, 300, 100, 50);
    [btn addTarget:self action:@selector(pushVC) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"push" forState:UIControlStateNormal];
    [view addSubview:btn];
    
    UIButton *btn2=[[UIButton alloc]init];
    btn2.frame=CGRectMake(100, 200, 100, 50);
    [btn2 addTarget:self action:@selector(hide:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"隐藏" forState:UIControlStateNormal];
    [view addSubview:btn2];
    
    
    [self.view addSubview:view];
}

-(void)hide:(UIButton*)btn
{
    [btn.superview removeFromSuperview];
}
-(void)pushVC
{
    [self.navigationController pushViewController:[TwoViewController new] animated:YES];
}
-(void)pushThree
{
    [self.navigationController pushViewController:[ThreeViewController new] animated:YES];
}
@end
