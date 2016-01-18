//
//  UIColor+Extension.m
//  LSNavigatitonTransition
//
//  Created by ls on 16/1/13.
//  Copyright © 2016年 song. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)
-(UIImage*)imageWithColor
{
    UIGraphicsBeginImageContext(CGSizeMake(1, 1));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddRect(context, CGRectMake(0, 0, 1, 1));
    [self set];
    CGContextFillPath(context);
   UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
