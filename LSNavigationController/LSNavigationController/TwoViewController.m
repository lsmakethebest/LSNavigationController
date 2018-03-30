

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
//    [self reloadNavigationBar];
    self.navigationBar.hidden=YES;
    self.title=@"第二页";
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithTitle:@"push" style:(UIBarButtonItemStylePlain) target:self action:@selector(push)];
    self.navigationItem.rightBarButtonItem=item;
   
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 00, 100, 100)];
    view.backgroundColor=[UIColor redColor];
    [self.view addSubview:view];
    
    
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(100, 300, 80, 50)];
    [btn setTitle:@"push" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    NSLog(@"22222222");
    
  
}




-(void)push
{
    [self.navigationController pushViewController:[[ThreeViewController alloc]init] animated:YES];
}

@end
