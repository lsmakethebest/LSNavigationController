//
//  UINavigationBar+LSNavigationController.h
//  LSNavigationController
//
//  Created by liusong on 2018/3/28.
//  Copyright © 2018年 liusong. All rights reserved.
//

#import <UIKit/UIKit.h>

//UIView的level用于在当前view上添加覆盖整个屏幕的view并且不被navigationBar覆盖
typedef NS_ENUM(NSInteger,UIViewLevel){
    UIViewLevelLow=0,
    UIViewLevelMiddle,
    UIViewLevelHigh
};

@class LSTopNavigationBar;

@interface UINavigationBar (LSNavigationController)

+ (void)ls_navBar_exchangeInstanceMethod:(Class) dClass originalSel:(SEL)originalSelector newSel:(SEL)newSelector;

@end


@interface UIView (LSNavigationController)

@property (nonatomic,assign) UIViewLevel viewLevel;

//是ViewController的根view
@property (nonatomic,assign) BOOL ls_isViewControllerBaseView;

@end
