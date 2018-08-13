//
//  LSNavigationController.h
//  LSNavigationController
//
//  Created by liusong on 2018/3/22.
//  Copyright © 2018年 liusong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+LSNavigationController.h"
#import "UINavigationBar+LSNavigationController.h"


@interface LSNavigationController : UINavigationController

@property (nonatomic,assign) BOOL cancelGesture;//禁用整个导航控制器手势 如果想在启用必须在设置为NO

@end


@interface LSTopNavigationBar : UINavigationBar
@end

@interface LSNavigationBar : UINavigationBar
@end

@interface LSNavigationItem : UINavigationItem
@end







