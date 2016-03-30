//
//  UIColor+Extension.m
//  LSNavigatitonTransition
//
//  Created by ls on 16/1/13.
//  Copyright © 2016年 song. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)
+(UIImage*)imageWithColor
{
    UIGraphicsBeginImageContext(CGSizeMake(1, 1));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddRect(context, CGRectMake(0, 0, 1, 1));
    [[self randomColor] set];
    CGContextFillPath(context);
   UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+ (UIColor *)randomColor {
    
    CGFloat red = ( arc4random() % 256 / 256.0 );
    CGFloat blue= ( arc4random() % 256 / 256.0 );
    CGFloat green= ( arc4random() % 256 / 256.0 );
    return [UIColor colorWithRed:red green:blue blue:green alpha:1.0];
}
@end
