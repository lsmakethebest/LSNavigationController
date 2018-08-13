

//
//  UINavigationBar+LSNavigationController.m
//  LSNavigationController
//
//  Created by liusong on 2018/3/28.
//  Copyright © 2018年 liusong. All rights reserved.
//

#import "UINavigationBar+LSNavigationController.h"
#import <objc/runtime.h>
#import "LSNavigationController.h"


@implementation UINavigationBar (LSNavigationController)

+ (void)ls_navBar_exchangeInstanceMethod : (Class) dClass originalSel :(SEL)originalSelector newSel: (SEL)newSelector
{
    Method originalMethod = class_getInstanceMethod(dClass, originalSelector);
    Method newMethod = class_getInstanceMethod(dClass, newSelector);
    //将 newMethod的实现 添加到系统方法中 也就是说 将 originalMethod方法指针添加成
    //方法newMethod的  返回值表示是否添加成功
    BOOL isAdd = class_addMethod(dClass, originalSelector,
                                 method_getImplementation(newMethod),
                                 method_getTypeEncoding(newMethod));
    //添加成功了 说明 本类中不存在新方法
    //所以此时必须将新方法的实现指针换成原方法的，否则 新方法将没有实现。
    if (isAdd) {
        class_replaceMethod(dClass, newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        //添加失败了 说明本类中 有methodB的实现，此时只需要将
        // originalMethod和newMethod的IMP互换一下即可。
        method_exchangeImplementations(originalMethod, newMethod);
    }
    
}
+(void)load
{
    Class dClass=[self class];
    [self ls_navBar_exchangeInstanceMethod:dClass originalSel:@selector(pushNavigationItem:) newSel:@selector(ls_pushNavigationItem:)];
    [self ls_navBar_exchangeInstanceMethod:dClass originalSel:@selector(pushNavigationItem:animated:) newSel:@selector(ls_pushNavigationItem:animated:)];
    
}


-(void)ls_pushNavigationItem:(UINavigationItem *)item
{
    if ([self isKindOfClass:[LSTopNavigationBar class]]) {
        item=[[UINavigationItem alloc]init];
        item.leftBarButtonItem=[UIBarButtonItem new];
    }
    [self ls_pushNavigationItem:item];
}

-(void)ls_pushNavigationItem:(UINavigationItem *)item animated:(BOOL)animated
{
    if ([self isKindOfClass:[LSTopNavigationBar class]]) {
        item=[[UINavigationItem alloc]init];
    }
    [self ls_pushNavigationItem:item animated:animated];
}


@end



@implementation UIView (LSNavigationController)

+(void)load{
    [UINavigationBar ls_navBar_exchangeInstanceMethod:[self class] originalSel:@selector(didAddSubview:) newSel:@selector(ls_didAddSubview:)];
}
-(BOOL)ls_isViewControllerBaseView{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

-(void)setLs_isViewControllerBaseView:(BOOL)ls_isViewControllerBaseView{
    objc_setAssociatedObject(self, @selector(ls_isViewControllerBaseView), @(ls_isViewControllerBaseView), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(void)setViewLevel:(UIViewLevel)viewLevel{
    objc_setAssociatedObject(self, @selector(viewLevel), @(viewLevel), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIViewLevel)viewLevel{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}


-(void)ls_didAddSubview:(UIView *)subview
{
    [self ls_didAddSubview:subview];
    if (self.ls_isViewControllerBaseView) {
        if (subview.viewLevel==UIViewLevelHigh) {
            return;
        }
        UIViewController *vc= (UIViewController*)[self nextResponder];
        if ([vc isKindOfClass:[UIViewController class]]) {
            if(vc.navigationBar){
                [self bringSubviewToFront:vc.navigationBar];
            }
        }
    }
}
@end

