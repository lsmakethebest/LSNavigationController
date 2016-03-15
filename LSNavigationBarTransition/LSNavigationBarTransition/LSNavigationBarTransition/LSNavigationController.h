//
//  LSNavigationController.h
//  LSNavigationBarTransition
//
//  Created by ls on 16/1/16.
//  Copyright © 2016年 song. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSInteractionTransition.h"


@interface LSNavigationController : UINavigationController<UIGestureRecognizerDelegate, UINavigationControllerDelegate, UIViewControllerInteractiveTransitioning, UIViewControllerTransitioningDelegate, UINavigationBarDelegate>

//交互动画
@property (nonatomic, strong) LSInteractionTransition *interactionAnimation;

@property (nonatomic, strong) LSStack* stack;
//是否开启全屏右滑
@property (nonatomic, assign) BOOL fullScreenGesture;


@end
