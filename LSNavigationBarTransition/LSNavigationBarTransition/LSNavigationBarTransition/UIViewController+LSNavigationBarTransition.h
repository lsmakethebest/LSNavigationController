//
//  UIViewController+LSNavigationBarTransition.h
//  LSNavigationBarTransition
//
//  Created by ls on 16/1/16.
//  Copyright © 2016年 song. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LSNavigationBarTransition)

@property (nonatomic, strong) UINavigationBar *ls_navigationBar;
@property (nonatomic, assign) BOOL ls_prefersNavigationBarBackgroundViewHidden;
@end
