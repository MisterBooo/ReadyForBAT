//
//  AsyncDrawLayer.h
//  AsyncDrawDemo
//
//  Created by yangyang on 2018/5/5.
//  Copyright © 2018年 mooc. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface AsyncDrawLayer : CALayer
@property (nonatomic, assign, readonly) NSInteger drawsCount;

- (void)increaseCount;

@end
