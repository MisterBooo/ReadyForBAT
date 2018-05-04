//
//  ObjectA1.m
//  DesignPatten
//
//  Created by MisterBooo on 2018/5/4.
//  Copyright © 2018年 MisterBooo. All rights reserved.
//

#import "ObjectA1.h"

@implementation ObjectA1
- (void)handle{
    // before 业务逻辑操作
    NSLog(@"before 业务逻辑操作");

    [super handle];
    
    NSLog(@"after 业务逻辑操作");
    // after 业务逻辑操作
}
@end
