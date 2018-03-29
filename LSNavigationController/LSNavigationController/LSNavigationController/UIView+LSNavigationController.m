






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

static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;

+(void)load
{
    [UINavigationBar ls_navBar_exchangeInstanceMethod:[self class] originalSel:@selector(hitTest:withEvent:) newSel:@selector(ls_hitTest:withEvent:)];
    
}
- (void)ls_nav_setEnlargeEdge:(CGFloat) size
{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)ls_nav_setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left
{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect) enlargedRect
{
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge)
    {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    }
    else
    {
        return self.bounds;
    }
}
- (UIView*) ls_hitTest:(CGPoint) point withEvent:(UIEvent*) event
{
    CGRect rect = [self enlargedRect];
    UIView *view=[self ls_hitTest:point withEvent:event];
    if (view) {
        return view;
    }else{
        if (CGRectEqualToRect(rect, self.bounds))
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
