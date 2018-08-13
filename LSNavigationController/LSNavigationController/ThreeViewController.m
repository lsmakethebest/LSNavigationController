


//
//  ThreeViewController.m
//  LSNavigationController
//
//  Created by liusong on 2018/3/28.
//  Copyright © 2018年 liusong. All rights reserved.
//

#import "ThreeViewController.h"
#import "OneViewController.h"
#import "FourViewController.h"
@interface ThreeViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self reloadNavigationBar];
   self.cancelGesture=YES;
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationBar setBackgroundImage:[self ls_imageWithColor:[UIColor cyanColor]] forBarMetrics:UIBarMetricsDefault];
    


    UITableView *view=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 375, 300) style:(UITableViewStyleGrouped)];
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
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"push" style:(UIBarButtonItemStylePlain) target:self action:@selector(push)];

}

-(void)push
{
    [self.navigationController pushViewController:[[FourViewController alloc]init] animated:YES];
}


-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    
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
