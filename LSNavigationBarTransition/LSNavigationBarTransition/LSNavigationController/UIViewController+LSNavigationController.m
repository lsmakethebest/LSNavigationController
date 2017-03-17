//
//  UIViewController+LSNavigationController.m
//  LSNavigationBarTransition
//
//  Created by 刘松 on 2017/2/9.
//  Copyright © 2017年 song. All rights reserved.
//

#import "UIViewController+LSNavigationController.h"
#import <objc/runtime.h>
#import "LSNavigationController.h"

@implementation UIViewController (LSNavigationController)


-(void)setLs_normalPush:(BOOL)ls_normalPush
{
    objc_setAssociatedObject(self, @selector(ls_normalPush), @(ls_normalPush), OBJC_ASSOCIATION_ASSIGN);
}

-(BOOL)ls_normalPush
{
   return  [objc_getAssociatedObject(self, _cmd) boolValue];
}

-(void)setLs_cancelGesture:(BOOL)ls_cancelGesture
{
    objc_setAssociatedObject(self, @selector(ls_cancelGesture), @(ls_cancelGesture), OBJC_ASSOCIATION_ASSIGN);
}

-(BOOL)ls_cancelGesture
{
    return  [objc_getAssociatedObject(self, _cmd) boolValue];
}



-(void)setLs_topNavigationController:(UINavigationController *)ls_topNavigationController
{
    objc_setAssociatedObject(self, @selector(ls_topNavigationController), ls_topNavigationController, OBJC_ASSOCIATION_RETAIN);
}

-(UINavigationController *)ls_topNavigationController
{
    return  objc_getAssociatedObject(self, _cmd) ;
}


@end
