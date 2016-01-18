

//
//  LSSwizzle.m
//  LSNavigatitonTransition
//
//  Created by ls on 16/1/15.
//  Copyright © 2016年 song. All rights reserved.
//

#import "LSSwizzle.h"

#import <objc/runtime.h>
@implementation LSSwizzle
void LSSwizzleInstanceMethod(Class class, SEL originalSelector, SEL swizzledSelector)
{
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

    BOOL didAddMethod = class_addMethod(class,
        originalSelector,method_getImplementation(swizzledMethod),method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
            swizzledSelector,
            method_getImplementation(originalMethod),
            method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
