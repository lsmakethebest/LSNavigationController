

//
//  UIViewController+LSNavigationBarTransition.m
//  LSNavigationBarTransition
//
//  Created by ls on 16/1/16.
//  Copyright © 2016年 song. All rights reserved.
//

#import "UIColor+Extension.h"
#import "UIViewController+LSNavigationController.h"
#import <objc/runtime.h>

@implementation UIViewController (LSNavigation)

- (void)setLs_navigationController:(LSNavigationController*)ls_navigationController
{
    objc_setAssociatedObject(self, @selector(ls_navigationController), ls_navigationController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (LSNavigationController*)ls_navigationController
{
    return objc_getAssociatedObject(self, _cmd);
}
@end
