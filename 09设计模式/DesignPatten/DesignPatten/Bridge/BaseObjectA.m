//
//  BaseObjectA.m
//  DesignPatten
//
//  Created by MisterBooo on 2018/5/4.
//  Copyright © 2018年 MisterBooo. All rights reserved.
//

#import "BaseObjectA.h"

@implementation BaseObjectA
/*
 A1 --> B1、B2、B3         3种
 A2 --> B1、B2、B3         3种
 A3 --> B1、B2、B3         3种
 */
- (void)handle{
    NSLog(@"BaseObjectA handle");
    [self.objB fetchData];
}
@end
