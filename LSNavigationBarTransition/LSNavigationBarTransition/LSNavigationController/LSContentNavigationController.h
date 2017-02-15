//
//  LSContentNavigationController.h
//  LSNavigationBarTransition
//
//  Created by ls on 16/3/22.
//  Copyright © 2016年 song. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LSNavigationController.h"

@interface LSContentNavigationController : UINavigationController

@end


@interface LSContentViewController : UIViewController

+ (instancetype)contentViewControllerWithViewController:(UIViewController*)viewController;


@end

