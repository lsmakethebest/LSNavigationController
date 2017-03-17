//
//  LSNavigationController.h
//  LSNavigationBarTransition
//
//  Created by ls on 16/1/16.
//  Copyright © 2016年 song. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
     1.没有设置VC2.ls_normalPush
     Nav->(VC.Nav1.VC1)->(VC.Nav2.VC2)->(VC.Nav3.VC3)->(VC.Nav4.VC4)
     
     popToRootViewControllerAnimated
     在VC4里调用,其实是pop到VC1
     
     popViewControllerAnimated
     正常调用即可
     
     popToViewController
     如果要显示VC2 VC2=self.ls_topNavigationController.viewControllers[1]
     在VC4里调用  [self.navigationController popToViewController:VC2 animated:YES];
     
     2.设置了 VC2.ls_normalPush=YES
     Nav->(VC.Nav1.VC1)->(VC.Nav2.VC2)->VC3->VC4-VC5->VC6
     
     popToRootViewControllerAnimated
     VC6里调用,其实是pop到VC2
     
     popViewControllerAnimated
     VC6调用会pop到VC5
     VC2调用会pop到VC1
     
     popToViewController
     如果要显示VC3 VC3=self.navigationController.viewControllers[1]
     在VC6里调用  [self.navigationController popToViewController:VC3 animated:YES];
     
     如果要显示VC1 VC1=self.ls_topNavigationController.viewControllers[0]
     在VC6里调用  [self.navigationController popToViewController:VC1 animated:YES];


*/

@interface LSNavigationController : UINavigationController<UIGestureRecognizerDelegate, UINavigationControllerDelegate>

//是否开启全屏右滑   默认为YES
@property (nonatomic, assign) BOOL fullScreenGesture;



@end


