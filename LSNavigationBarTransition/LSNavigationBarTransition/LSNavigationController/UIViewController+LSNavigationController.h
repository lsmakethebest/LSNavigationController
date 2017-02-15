//
//  UIViewController+LSNavigationController.h
//  LSNavigationBarTransition
//
//  Created by 刘松 on 2017/2/9.
//  Copyright © 2017年 song. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewController (LSNavigationController)

//是否正常push  只要设置为YES之后，push的效果就是系统正常的效果
@property (nonatomic,assign) BOOL ls_normalPush;

/*
  Nav->(VC.Nav1.VC1)->(VC.Nav2.VC2)->VC3->VC4-VC5->VC6
  
  最上层导航控制器 VC6调用 self.navigationController获取到的其实为Nav2
  self.ls_topNavigationController才是Nav
 
*/

@property (nonatomic,weak) UINavigationController *ls_topNavigationController;

@end
