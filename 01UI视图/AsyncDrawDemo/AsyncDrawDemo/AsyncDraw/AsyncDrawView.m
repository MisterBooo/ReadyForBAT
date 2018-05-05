//
//  AsyncDrawView.m
//  AsyncDrawDemo
//
//  Created by yangyang on 2018/5/5.
//  Copyright © 2018年 mooc. All rights reserved.
//

#import "AsyncDrawView.h"
#import "AsyncDrawLayer.h"

@interface AsyncDrawView ()
@property (nonatomic, weak) AsyncDrawLayer *drawLayer;
@end

@implementation AsyncDrawView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.opaque = NO;
        self.layer.contentsScale = [[UIScreen mainScreen] scale];
        
        if ([self.layer isKindOfClass:[AsyncDrawLayer class]])
        {
            _drawLayer = (AsyncDrawLayer *)self.layer;
        }
    }
    return self;
}

+ (Class)layerClass
{
    return [AsyncDrawLayer class];
}

- (void)didMoveToWindow
{
    [super didMoveToWindow];
    
    if (!self.window)
    {
        // 没有 Window 说明View已经没有显示在界面上，此时应该终止绘制
    }
    else if (!self.layer.contents)
    {
        [self setNeedsDisplay];
    }
}

- (void)setNeedsDisplay
{
    [self.layer setNeedsDisplay];
}

- (void)setNeedsDisplayInRect:(CGRect)rect
{
    [self.layer setNeedsDisplayInRect:rect];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawInRect:self.bounds withContext:context asynchronously:NO];
}

- (void)displayLayer:(CALayer *)layer
{
    if (!layer) return;
    
    if (layer != self.layer) return;
    
    if (![layer isKindOfClass:[AsyncDrawLayer class]]) {
        return;
    }
    
    AsyncDrawLayer *tempLayer = (AsyncDrawLayer *)layer;

    [tempLayer increaseCount];
    
    NSUInteger oldCount = tempLayer.drawsCount;
    
    void (^drawBlock)(void) = ^{
        
        void (^failedBlock)(void) = ^{
            // 可以做一个中断的回调
        };
        
        //防止重用产生问题
        if (tempLayer.drawsCount != oldCount)
        {
            failedBlock();
            return;
        }
        
        CGSize contextSize = layer.bounds.size;
        BOOL contextSizeValid = contextSize.width >= 1 && contextSize.height >= 1;
        CGContextRef context = NULL;
        BOOL drawingFinished = YES;
        
        if (contextSizeValid) {
            UIGraphicsBeginImageContextWithOptions(contextSize, layer.isOpaque, layer.contentsScale);
            
            context = UIGraphicsGetCurrentContext();
            
            CGContextSaveGState(context);
            
            if (self.bounds.origin.x || self.bounds.origin.y)
            {
                CGContextTranslateCTM(context, self.bounds.origin.x, -self.bounds.origin.y);
            }
            
            if (tempLayer.drawsCount != oldCount)
            {
                drawingFinished = NO;
            }
            else
            {
                // [UIView backgroundColor] must be used from main thread only !
                if (self.backgroundColor &&
                    self.backgroundColor != [UIColor clearColor])
                {
                    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
                    CGContextFillRect(context, self.bounds);
                }
                drawingFinished = [self drawInRect:self.bounds withContext:context asynchronously:YES];
            }
            
            CGContextRestoreGState(context);
        }
        
        
        // 所有耗时的操作都已完成，但仅在绘制过程中未发生重绘时，将结果显示出来
        if (drawingFinished && oldCount == tempLayer.drawsCount)
        {
            CGImageRef CGImage = context ? CGBitmapContextCreateImage(context) : NULL;
            
            {
                // 让 UIImage 进行内存管理
                UIImage * image = CGImage ? [UIImage imageWithCGImage:CGImage] : nil;
                
                void (^finishBlock)(void) = ^{
                    
                    // 由于block可能在下一runloop执行，再进行一次检查
                    if (oldCount != tempLayer.drawsCount)
                    {
                        failedBlock();
                        return;
                    }
                    
                    layer.contents = (id)image.CGImage;
                    
                    layer.opacity = 0.0;
                    
                    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                        layer.opacity = 1.0;
                    } completion:NULL];
                };
                
                dispatch_async(dispatch_get_main_queue(), finishBlock);
            }
            
            if (CGImage) {
                CGImageRelease(CGImage);
            }
        }
        else
        {
            failedBlock();
        }
        
        UIGraphicsEndImageContext();
    };
    
    layer.contents = nil;
    dispatch_async(dispatch_get_global_queue(0, 0), drawBlock);
}

- (BOOL)drawInRect:(CGRect)rect withContext:(CGContextRef)context asynchronously:(BOOL)asynchronously
{
    // 子类去做实际绘制工作
    // 一般异步绘制是需要结合CoreGraphic API来使用，图文混排的原理网上有很多介绍，大家搜一搜就知道了
    return YES;
}

@end
