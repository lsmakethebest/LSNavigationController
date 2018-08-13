//
//  UIViewController+LSNavigationController.m
//  LSNavigationController
//
//  Created by liusong on 2018/3/30.
//  Copyright © 2018年 liusong. All rights reserved.
//

#import "UIViewController+LSNavigationController.h"
#import <objc/runtime.h>
#import "LSNavigationController.h"
#import "UINavigationBar+LSNavigationController.h"


@interface UIViewController ()


@property (nonatomic,weak) LSNavigationController *ls_navigationController;
@property (nonatomic,strong) LSNavigationItem *ls_navigation_item;

@end

@implementation UIViewController (LSNavigationController)

+(void)load{

    [UINavigationBar ls_navBar_exchangeInstanceMethod:[self class] originalSel:@selector(viewDidAppear:) newSel:@selector(ls_viewDidAppear:)];
    
    [UINavigationBar ls_navBar_exchangeInstanceMethod:[self class] originalSel:@selector(navigationItem) newSel:@selector(ls_navigationItem)];
    
    [UINavigationBar ls_navBar_exchangeInstanceMethod:[self class] originalSel:@selector(setTitle:) newSel:@selector(ls_setTitle:)];

}

//#pragma mark - 以下为方法替换
-(void)ls_setTitle:(NSString *)title
{
    [self ls_setTitle:title];
    if (self.ls_navigation_item) {
        self.ls_navigation_item.title=title;
    }
}


-(void)ls_viewDidAppear:(BOOL)animated
{
    [self ls_viewDidAppear:animated];
    //只有通过LSNavigationController push过来的VC才做此设置
    if (self.ls_navigationController) {
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
}

-(UINavigationItem *)ls_navigationItem
{
    if (self.ls_navigation_item) {
        return self.ls_navigation_item;
    }
    return  [self ls_navigationItem];
}

#pragma mark - 以下为私有方法
-(void)bringNavigationBarToFront
{
    [self.view bringSubviewToFront:self.navigationBar];
}

-(void)removeNavigationBar
{
    if (self.navigationBar) {
        [self.navigationBar removeFromSuperview];
        self.ls_navigation_item=nil;
    }
}
-(void)reloadNavigationBar
{
    [self removeNavigationBar];
    CGSize size = [UIApplication sharedApplication].statusBarFrame.size;
    LSNavigationBar *navigationBar=[[LSNavigationBar alloc]init];

    self.edgesForExtendedLayout=UIRectEdgeTop;
    navigationBar.frame=CGRectMake(0, size.height, size.width, 44);
    self.view.ls_isViewControllerBaseView=YES;
    
    self.navigationBar=navigationBar;
    [self.view addSubview:navigationBar];
    self.ls_navigation_item=[[LSNavigationItem alloc]init];
    navigationBar.items=@[self.ls_navigation_item];
}

- (UIImage*)ls_imageWithColor:(UIColor*)color
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

#pragma mark - 以下为增加属性
-(void)setLs_navigation_item:(LSNavigationItem *)ls_navigation_item
{
     objc_setAssociatedObject(self, @selector(ls_navigation_item), ls_navigation_item, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(LSNavigationItem *)ls_navigation_item
{
    return  objc_getAssociatedObject(self, _cmd);
}

-(LSNavigationController *)ls_navigationController
{
    return  objc_getAssociatedObject(self, _cmd);
}
-(void)setLs_navigationController:(LSNavigationController *)ls_navigationController
{
     objc_setAssociatedObject(self, @selector(ls_navigationController), ls_navigationController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setNavigationBar:(LSNavigationBar *)navigationBar
{
    objc_setAssociatedObject(self, @selector(navigationBar), navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(LSNavigationBar *)navigationBar
{
    return  objc_getAssociatedObject(self, _cmd);
}

-(void)setCancelGesture:(BOOL)cancelGesture
{
     objc_setAssociatedObject(self, @selector(cancelGesture), @(cancelGesture), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (!((LSNavigationController*)self.navigationController).cancelGesture) {
        //导航控制器没有全局取消 直接设置
        self.navigationController.interactivePopGestureRecognizer.enabled=!cancelGesture;
    }
}

-(BOOL)cancelGesture
{
     return  [objc_getAssociatedObject(self, _cmd) boolValue];
}



@end



