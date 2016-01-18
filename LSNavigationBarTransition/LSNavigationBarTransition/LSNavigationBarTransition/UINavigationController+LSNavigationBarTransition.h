//
//  UINavigationController+LSNavigationBarTransition.h
//  LSNavigationBarTransition
//
//  Created by ls on 16/1/16.
//  Copyright © 2016年 song. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSImageView;
@interface UINavigationController (LSNavigationBarTransition)<UIGestureRecognizerDelegate>
@property (nonatomic, strong) LSImageView *frontControllerView;
@end
