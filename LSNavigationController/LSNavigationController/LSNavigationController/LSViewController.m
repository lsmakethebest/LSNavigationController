

//
//  LSViewController.m
//  LSNavigationController
//
//  Created by liusong on 2018/3/27.
//  Copyright © 2018年 liusong. All rights reserved.
//

#import "LSViewController.h"
#import "UIView+LSNavigationController.h"
@interface LSViewController ()<UINavigationBarDelegate>
@property (nonatomic,strong) UINavigationItem *item;
@end

@implementation LSViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout=UIRectEdgeNone;//代表从64开始 top 从0开始
    [self reloadNavigationBar];
}
-(void)reloadNavigationBar
{
    if (self.navigationBar) {
        [self.navigationBar removeFromSuperview];
        self.item=nil;
    }
    [self.view ls_nav_setEnlargeEdgeWithTop:44 right:0 bottom:0 left:0];
    CGSize size = [UIApplication sharedApplication].statusBarFrame.size;
    LSNavigationBar *navigationBar=[[LSNavigationBar alloc]init];
    if (self.edgesForExtendedLayout==UIRectEdgeNone) {
        navigationBar.frame=CGRectMake(0, -44, size.width, 44);
        self.view.clipsToBounds=NO;
    }else{
        navigationBar.frame=CGRectMake(0, size.height, size.width, 44);
    }
    
    [self.view addSubview:navigationBar];
    self.navigationBar=navigationBar;
    self.navigationBar.delegate=self;
    navigationBar.items=@[self.item];
    if (self.navigationController.viewControllers.count>1){    
        UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navBar_back_icon"] style:(UIBarButtonItemStylePlain) target:self action:@selector(navigationBarClickBack)];
        self.item.leftBarButtonItem=leftItem;
    }

}
-(void)setCancelAllGesture:(BOOL)cancelAllGesture
{
    LSNavigationController *nav=self.ls_navigationController;
    nav.cancelGesture=cancelAllGesture;
}

//判断如果是页面是navigationController中的第一个页面就禁止左划手势，不然在第一个页面执行左划手势后在push不到第二个页面
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.navigationController.viewControllers.firstObject == self) {
        //在根控制器界面
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }else{
        LSNavigationController *nav=(LSNavigationController*)self.navigationController;
        //不在跟控制界面
        if (nav.cancelGesture) {
            self.navigationController.interactivePopGestureRecognizer.enabled=NO;
        }else{
            self.navigationController.interactivePopGestureRecognizer.enabled = !self.cancelGesture;
        }
    }
}
-(void)setCancelGesture:(BOOL)cancelGesture
{
    _cancelGesture=cancelGesture;
    if (!((LSNavigationController*)self.navigationController).cancelGesture) {
        //导航控制器没有全局取消 直接设置
        self.navigationController.interactivePopGestureRecognizer.enabled=!cancelGesture;
    }
}
-(void)bringNavigationBarToFront
{
   [self.view bringSubviewToFront:self.navigationBar];
}

-(void)navigationBarClickBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(UINavigationItem *)item
{
    if (_item==nil) {
        _item=[[UINavigationItem alloc]init];
    }
    return _item;
}
-(UINavigationItem *)navigationItem{
    return self.item;
}

-(void)setTitle:(NSString *)title
{
    [super setTitle:title];
    self.item.title=title;
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self bringNavigationBarToFront ];
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
