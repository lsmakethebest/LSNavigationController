


//
//  ThreeViewController.m
//  LSNavigationController
//
//  Created by liusong on 2018/3/28.
//  Copyright © 2018年 liusong. All rights reserved.
//

#import "ThreeViewController.h"
#import "UIView+LSNavigationController.h"
@interface ThreeViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets=YES;
    [self reloadNavigationBar];
   
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationBar setBackgroundImage:[self imageWithColor:[UIColor cyanColor]] forBarMetrics:UIBarMetricsDefault];
    

    UITableView *view=[[UITableView alloc]initWithFrame:CGRectMake(0, -64, 375, 300) style:(UITableViewStyleGrouped)];
    view.dataSource=self;
    view.delegate=self;

    view.estimatedSectionHeaderHeight=0;
    view.estimatedSectionFooterHeight=0;
    view.estimatedRowHeight=0;
    UIView *header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    view.tableHeaderView=header;

    [self.view addSubview:view];

    
    UIButton *btn=[[UIButton alloc]init];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"back" forState:UIControlStateNormal];
    btn.backgroundColor=[UIColor orangeColor];
    btn.frame=CGRectMake(100,407, 50, 50);
    [self.view addSubview:btn];
    
    
   


    
    
    
    self.title=@"第三页";
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"back" style:(UIBarButtonItemStylePlain) target:self action:@selector(back)];
    
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"show" style:(UIBarButtonItemStylePlain) target:self action:@selector(show)];
    
    
}

-(void)show
{

    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, -64, 375, 667)];
    button.backgroundColor=[[UIColor orangeColor]colorWithAlphaComponent:0.3];
    button.viewLevel=UIViewLevelHigh;
    [self.view addSubview:button];
    [button addTarget:self action:@selector(hide:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)hide:(UIButton*)btn
{
    [btn removeFromSuperview];
}



-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.forbidAllGesture=YES;

  
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.forbidAllGesture=NO;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

@end
