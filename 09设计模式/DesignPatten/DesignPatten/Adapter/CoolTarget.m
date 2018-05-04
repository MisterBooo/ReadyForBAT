//
//  CoolTarget.m
//  DesignPatten
//
//  Created by MisterBooo on 2018/5/4.
//  Copyright © 2018年 MisterBooo. All rights reserved.
//

#import "CoolTarget.h"

@implementation CoolTarget
- (void)request{
    // 额外处理
    NSLog(@"额外处理111111");
    
    [self.target operation];
    
    NSLog(@"额外处理2222222");

    // 额外处理
}
@end
