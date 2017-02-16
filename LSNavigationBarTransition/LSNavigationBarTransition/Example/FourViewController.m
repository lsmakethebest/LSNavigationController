






//
//  FourViewController.m
//  LSNavigationBarTransition
//
//  Created by ls on 16/3/14.
//  Copyright © 2016年 song. All rights reserved.
//

#import "FourViewController.h"
#import "UIColor+Extension.h"

#import "LSNavigationControllerKit.h"

@interface FourViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIColor imageWithColor] forBarMetrics:UIBarMetricsDefault];
 
    
    self.edgesForExtendedLayout=UIRectEdgeNone;
    if (!self.navigationController.ls_normalPush) {
        self.navigationController.navigationBarHidden=YES;
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"dsfdsflkk----%ld",indexPath.row];
    return cell;
}

- (IBAction)popToTwo:(id)sender {
    [self.navigationController popToViewController:self.navigationController.viewControllers[0] animated:YES];
}
- (IBAction)popToOne:(id)sender {
    [self.navigationController popToViewController:self.ls_topNavigationController.viewControllers[0] animated:YES];
    
}


@end
