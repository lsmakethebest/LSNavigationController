



//
//  LSNavigationItem.m
//  LSNavigationController
//
//  Created by liusong on 2018/3/30.
//  Copyright © 2018年 liusong. All rights reserved.
//

#import "LSNavigationItem.h"

@implementation LSNavigationItem

-(void)setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem
{
    //解决ios11以下系统 设置leftBarButtonItem不显示问题 通过延迟也可以解决 但是此方法不用延时也可以解决
    dispatch_async(dispatch_get_main_queue(), ^{
        [super setLeftBarButtonItem:leftBarButtonItem];
    });
}

@end
