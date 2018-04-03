//
//  UIView+EnlargeTouchArea.h
//  LSNavigationController
//
//  Created by liusong on 2018/3/29.
//  Copyright © 2018年 liusong. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,UIViewLevel)
{
    
    UIViewLevelLow=0,
    UIViewLevelMiddle,
    UIViewLevelHigh
};

@interface UIView (LSNavigationController)

@property (nonatomic,assign) BOOL ls_nav_enlargeTop;
@property (nonatomic,assign) UIViewLevel viewLevel;

@end
