//
//  AsyncDrawLayer.m
//  AsyncDrawDemo
//
//  Created by yangyang on 2018/5/5.
//  Copyright © 2018年 mooc. All rights reserved.
//

#import "AsyncDrawLayer.h"

@implementation AsyncDrawLayer

- (void)increaseCount
{
    _drawsCount += 1;
}

- (void)setNeedsDisplay
{
    [self increaseCount];
    [super setNeedsDisplay];
}

- (void)setNeedsDisplayInRect:(CGRect)r
{
    [self increaseCount];
    [super setNeedsDisplayInRect:r];
}

@end
