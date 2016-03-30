//
//  LSContentNavigationController.h
//  LSNavigationBarTransition
//
//  Created by ls on 16/3/22.
//  Copyright © 2016年 song. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSContentNavigationController : UINavigationController
-(NSArray<UIViewController *> *)ls_viewControllers;
@property (nonatomic, assign) BOOL normalPush;
@end
