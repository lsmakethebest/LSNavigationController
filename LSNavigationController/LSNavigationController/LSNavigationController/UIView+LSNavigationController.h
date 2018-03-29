//
//  UIView+EnlargeTouchArea.h
//  LSNavigationController
//
//  Created by liusong on 2018/3/29.
//  Copyright © 2018年 liusong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationBar+LSNavigationController.h"
@interface UIView (LSNavigationController)
- (void)ls_nav_setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;
- (void)ls_nav_setEnlargeEdge:(CGFloat) size;
@end
