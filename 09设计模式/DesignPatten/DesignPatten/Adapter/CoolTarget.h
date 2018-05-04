//
//  CoolTarget.h
//  DesignPatten
//
//  Created by MisterBooo on 2018/5/4.
//  Copyright © 2018年 MisterBooo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Target.h"
@interface CoolTarget : NSObject
//** 被适配对象 */
@property(nonatomic, strong) Target *target;
//对原有方法包装
- (void)request;
@end
