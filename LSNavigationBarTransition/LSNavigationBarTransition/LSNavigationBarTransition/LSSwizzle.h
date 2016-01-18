//
//  LSSwizzle.h
//  LSNavigatitonTransition
//
//  Created by ls on 16/1/15.
//  Copyright © 2016年 song. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSSwizzle : NSObject
void LSSwizzleInstanceMethod(Class class, SEL originalSelector, SEL swizzledSelector);
@end
