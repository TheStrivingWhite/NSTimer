//
//  LYProxy.m
//  NSTimer
//
//  Created by yy on 2019/2/12.
//  Copyright © 2019年 1. All rights reserved.
//

#import "LYProxy.h"

@implementation LYProxy


/**
    标展的消息转发
    1.获取当前的方法签名
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    if (sel == NSSelectorFromString(@"test")) {
        // 方法为 timer 的 方法 去 target的结构体里找方法的签名
        return [self.target methodSignatureForSelector:sel];
    }
    
    return [super methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    if (invocation.selector == NSSelectorFromString(@"test")) {
        [invocation invokeWithTarget:self.target];
    }else{
        [super forwardInvocation:invocation];
    }
}

@end
