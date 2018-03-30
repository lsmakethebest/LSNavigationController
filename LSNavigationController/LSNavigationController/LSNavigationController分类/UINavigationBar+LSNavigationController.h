//
//  UINavigationBar+LSNavigationController.h
//  LSNavigationController
//
//  Created by liusong on 2018/3/28.
//  Copyright © 2018年 liusong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (LSNavigationController)

+ (void)ls_navBar_exchangeInstanceMethod : (Class) dClass originalSel :(SEL)originalSelector newSel: (SEL)newSelector;

@end
