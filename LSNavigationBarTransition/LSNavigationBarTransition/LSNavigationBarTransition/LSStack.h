//
//  LSStack.h
//  LSNavigatitonTransition
//
//  Created by ls on 16/1/15.
//  Copyright © 2016年 song. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSStack : NSObject
+ (instancetype)sharedInstance;
- (id)getTop;
- (void)push:(id)obj;
- (void)pop;
@end
