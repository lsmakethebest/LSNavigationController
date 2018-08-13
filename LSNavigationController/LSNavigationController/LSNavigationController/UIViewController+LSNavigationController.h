//
//  UIViewController+LSNavigationController.h
//  LSNavigationController
//
//  Created by liusong on 2018/3/30.
//  Copyright © 2018年 liusong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSNavigationBar;



@interface UIViewController (LSNavigationController)

@property (nonatomic,weak) LSNavigationBar *navigationBar;

@property (nonatomic,assign) BOOL cancelGesture; //取消当前页面手势 不影响其他VC手势使用



//创建UINavigationBar
-(void)reloadNavigationBar;

//删除UINavigationBar
-(void)removeNavigationBar;

//根据UIColor生成UIImage
- (UIImage*)ls_imageWithColor:(UIColor*)color;


@end
