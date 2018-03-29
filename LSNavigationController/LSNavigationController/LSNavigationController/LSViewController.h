//
//  LSViewController.h
//  LSNavigationController
//
//  Created by liusong on 2018/3/27.
//  Copyright © 2018年 liusong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSNavigationBar.h"
#import "LSNavigationController.h"
@interface LSViewController : UIViewController

@property (nonatomic,weak) LSNavigationBar *navigationBar;

@property (nonatomic,weak) LSNavigationController *ls_navigationController;
@property (nonatomic,assign) BOOL cancelGesture; //取消当前页面手势 不影响其他VC手势使用
@property (nonatomic,assign) BOOL cancelAllGesture;//取消整个导航控制器手势 如果想在启用必须在设置为NO

-(void)navigationBarClickBack;
-(void)reloadNavigationBar;
- (UIImage*)imageWithColor:(UIColor*)color;

@end
