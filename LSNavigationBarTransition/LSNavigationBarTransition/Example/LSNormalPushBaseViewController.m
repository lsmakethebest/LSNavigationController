

//
//  NormalPushBaseViewController.m
//  LSNavigationBarTransition
//
//  Created by 刘松 on 2017/2/9.
//  Copyright © 2017年 song. All rights reserved.
//

#import "LSNormalPushBaseViewController.h"
#import "LSNavigationControllerKit.h"

@interface LSNormalPushBaseViewController ()

@end

@implementation LSNormalPushBaseViewController


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.ls_normalPush=YES;
    }
    return self;
}



@end
