//
//  MergeSortedList.h
//  Arithmetic
//
//  Created by MisterBooo on 2018/5/5.
//  Copyright © 2018年 MisterBooo. All rights reserved.
//



#import <Foundation/Foundation.h>

@interface MergeSortedList : NSObject
// 将有序数组a和b的值合并到一个数组result当中，且仍然保持有序
void mergeList(int a[], int aLen, int b[], int bLen, int result[]);

@end

