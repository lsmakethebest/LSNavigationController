






//
//  UIView+EnlargeTouchArea.m
//  LSNavigationController
//
//  Created by liusong on 2018/3/29.
//  Copyright © 2018年 liusong. All rights reserved.
//

#import "UIView+LSNavigationController.h"
#import <objc/runtime.h>
#import "LSNavigationBar.h"

@implementation UIView (LSNavigationController)

+(void)load
{
    [UINavigationBar ls_navBar_exchangeInstanceMethod:[self class] originalSel:@selector(hitTest:withEvent:) newSel:@selector(ls_hitTest:withEvent:)];
    
}

-(BOOL)ls_nav_enlargeTop
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

-(void)setLs_nav_enlargeTop:(BOOL)ls_nav_enlargeTop
{
    objc_setAssociatedObject(self, @selector(ls_nav_enlargeTop), @(ls_nav_enlargeTop), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView*) ls_hitTest:(CGPoint) point withEvent:(UIEvent*) event
{
    UIView *view=[self ls_hitTest:point withEvent:event];
    if (view) {
        return view;
    }else{
        if (self.ls_nav_enlargeTop==NO)
        {
            return view;
        }else{
            for (UIView *subview in self.subviews) {
                if ([subview isKindOfClass:[LSNavigationBar class]]) {
                    CGPoint newPoint=[subview convertPoint:point fromView:self];
                    return  [subview hitTest:newPoint withEvent:event];
                }
            }
            return   nil;
        }
    }
}

@end
