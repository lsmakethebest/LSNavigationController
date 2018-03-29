

//
//  LSNavigationBar.m
//  LSNavigationController
//
//  Created by liusong on 2018/3/27.
//  Copyright © 2018年 liusong. All rights reserved.
//

#import "LSNavigationBar.h"
#import <objc/runtime.h>

@implementation LSTopNavigationBar
@end




@implementation LSNavigationBar

-(void)layoutSubviews{
    [super layoutSubviews];
    for (UIView *view in self.subviews) {
        NSString *className=NSStringFromClass([view class]);
        if ([className isEqualToString:@"_UIBarBackground"]) {
            
            CGFloat height=[UIApplication sharedApplication].statusBarFrame.size.height;
            CGRect frame=self.bounds;
            frame.size.height =self.frame.size.height+height;
            frame.origin.y=-height;
            view.frame=frame;
            
        }
    }
}
-(void)setThemeBackgroundImage:(UIImage *)image{
    [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}
-(void)pushNavigationItem:(UINavigationItem *)item animated:(BOOL)animated
{
    [super pushNavigationItem:item animated:animated];
}

@end



