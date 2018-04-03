






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
#import "UIViewController+LSNavigationController.h"
#import "UINavigationBar+LSNavigationController.h"
@implementation UIView (LSNavigationController)

+(void)load{
//    [UINavigationBar ls_navBar_exchangeInstanceMethod:[self class] originalSel:@selector(hitTest:withEvent:) newSel:@selector(ls_hitTest:withEvent:)];
    
    [UINavigationBar ls_navBar_exchangeInstanceMethod:[self class] originalSel:@selector(pointInside:withEvent:) newSel:@selector(ls_pointInside:withEvent:)];
    [UINavigationBar ls_navBar_exchangeInstanceMethod:[self class] originalSel:@selector(didAddSubview:) newSel:@selector(ls_didAddSubview:)];
}


-(void)ls_didAddSubview:(UIView *)subview
{
    [self ls_didAddSubview:subview];
    if (self.ls_nav_enlargeTop) {
       UIViewController *vc= (UIViewController*)[self nextResponder];
        if ([vc isKindOfClass:[UIViewController class]]) {
            if(vc.navigationBar){
                if (subview.viewLevel!=UIViewLevelHigh) {
                    [self bringSubviewToFront:vc.navigationBar];
                }
            }
        }
    }
    
    
}
-(BOOL)ls_nav_enlargeTop{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

-(void)setLs_nav_enlargeTop:(BOOL)ls_nav_enlargeTop{
    objc_setAssociatedObject(self, @selector(ls_nav_enlargeTop), @(ls_nav_enlargeTop), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setViewLevel:(UIViewLevel)viewLevel
{
    objc_setAssociatedObject(self, @selector(viewLevel), @(viewLevel), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(UIViewLevel)viewLevel
{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}


-(BOOL)ls_pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    
    if (self.ls_nav_enlargeTop) {
        if (point.y>0) {
            BOOL v=[self ls_pointInside:point withEvent:event];
            return v;
        }else{
            CGRect rect= CGRectMake(self.bounds.origin.x ,self.bounds.origin.y -[UIApplication sharedApplication].statusBarFrame.size.height-44,self.bounds.size.width ,self.bounds.size.height );
            BOOL v= CGRectContainsPoint(rect, point);
            return v;
        }
    } else {
        BOOL v=[self ls_pointInside:point withEvent:event];
        return v;
    }
}

//- (UIView*) ls_hitTest:(CGPoint) point withEvent:(UIEvent*) event{
//    UIView *view=[self ls_hitTest:point withEvent:event];
//    if (view) {
//        return view;
//    }else{
//        if (self.ls_nav_enlargeTop==NO)
//        {
//            return view;
//        }else{
//            for (UIView *subview in self.subviews) {
//                if ([subview isKindOfClass:[LSNavigationBar class]]) {
//                    CGPoint newPoint=[subview convertPoint:point fromView:self];
//                    return  [subview hitTest:newPoint withEvent:event];
//                }
//            }
//            return   nil;
//        }
//    }
//}


@end
