//
//  LYProxy.h
//  NSTimer
//
//  Created by yy on 2019/2/12.
//  Copyright © 2019年 1. All rights reserved.


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//  NSProxy 类详解  http://ios.jobbole.com/87856/

@interface LYProxy : NSProxy
//这记得 要weak strong 的strong的话 跟没做似的
@property (nonatomic, weak) id target;

@end

NS_ASSUME_NONNULL_END
