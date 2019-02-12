//
//  NSTimer+LYTimer.m
//  NSTimer
//
//  Created by yy on 2019/2/12.
//  Copyright © 2019年 1. All rights reserved.
//

#import "NSTimer+LYTimer.h"

@implementation NSTimer (LYTimer)

+ (NSTimer *)ly_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(void))block
{
    // self 类对象，类对象在 内存中以单例存在的
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(ly_blockHandle:) userInfo:block repeats:repeats];
}
+ (void)ly_blockHandle:(NSTimer *)timer{
    void (^block)(void) = timer.userInfo;
    if (block) {
        block();
    }
}
@end
