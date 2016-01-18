

//
//  LSStack.m
//  LSNavigatitonTransition
//
//  Created by ls on 16/1/15.
//  Copyright © 2016年 song. All rights reserved.
//

#import "LSStack.h"

@interface LSStack ()

@property (nonatomic, strong) NSMutableArray *images;

@end

static id instance = nil;

@implementation LSStack
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone*)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
    ;
}

-(NSMutableArray *)images
{
    if (_images==nil) {
        _images=[NSMutableArray array];
    }
    return _images;
}
-(void)pop
{
    if (![self isEmpty]) {
        [self.images removeLastObject];
    }
}
-(void)push:(id)obj
{
    if (obj) {
        [self.images addObject:obj];
    }
}
-(id)getTop
{
    if (![self isEmpty]) {
        return self.images.lastObject;
    }else {
        
        return nil;
    }
    
}
-(BOOL)isEmpty
{
    if (self.images.count) {
        return NO;
    }else{
        return YES;
    }
}
@end
