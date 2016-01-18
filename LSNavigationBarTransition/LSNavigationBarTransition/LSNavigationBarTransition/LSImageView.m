//
//  LSImageView.m
//  LSNavigatitonTransition
//
//  Created by ls on 16/1/16.
//  Copyright © 2016年 song. All rights reserved.
//

#import "LSImageView.h"

@interface LSImageView (){
    UIView *_maskView;
}
@end
@implementation LSImageView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        _maskView=[[UIView alloc]init];
        _maskView.backgroundColor=[UIColor colorWithRed:0.255 green:0.269 blue:0.225 alpha:0.000];
        [self addSubview:_maskView];
        [self setScaleAlpha:0.5];
    }
    return self;
}

-(void)setScaleAlpha:(CGFloat)scaleAlpha
{
    _scaleAlpha=scaleAlpha;//128 138 135
    _maskView.backgroundColor=[UIColor colorWithRed:192/255.0 green:192/255.0 blue:192/255.0 alpha:0.5-0.5*scaleAlpha];
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _maskView.frame=self.bounds;
}
@end
