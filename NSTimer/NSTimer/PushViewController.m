//
//  PushViewController.m
//  NSTimer
//
//  Created by yy on 2019/2/12.
//  Copyright © 2019年 1. All rights reserved.
//

#import "PushViewController.h"
#import <objc/message.h>
#import "LYProxy.h"
#import "NSTimer+LYTimer.h"

@interface PushViewController ()

@property (nonatomic, strong) NSTimer * timer;
//模式二
@property (nonatomic, strong) id target;
//模式三
@property (nonatomic, strong) LYProxy * lyProxy;

@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*
        模式一  直接pop返回 造成循环引用
        综合原因，当前的timer会对当前的target进行强引用， self和timerx相互强引用
     
     */
//    [self createTimer];
    
    //模式二
//    [self createTwoTimer];
    
    //模式三 借助一个类 叫 NSProxy
//    [self createProxy];
    
    //模式4 带block 的timer
    [self createBlockTimer];
    
}
#pragma 模式一

- (void)createTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(test) userInfo:nil repeats:YES];
}
- (void)test{
    NSLog(@"test");
}
#pragma 在合适的时机去掉这个函数 释放掉

- (void)releaseTimer{
    [_timer invalidate];
    _timer = nil;
}

/**
   子视图的生命周期  模式1的时候 得 解开，其他的 得注释掉
 */
//- (void)didMoveToParentViewController:(UIViewController *)parent
//{
//    if (!parent) {
//        //如果 parent 为 nil 当前的视图被移除了
//        [self releaseTimer];
//    }
//}

#pragma 模式二 引入一个中间者

// 把当前的强引用 转到 target 即可，当前的VC能释放，就OK

- (void)createTwoTimer{
    _target = [NSObject new];
    //当前的target 得加一个 test 方法
    class_addMethod([_target class], @selector(test), class_getMethodImplementation([self class], @selector(test)), "v@:");
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:_target selector:@selector(test) userInfo:nil repeats:YES];
}

#pragma 模式三 引入一个虚基类

- (void)createProxy{
    //只有 alloc
    _lyProxy = [LYProxy alloc];
    //设置为 当前的self ，因为真正处理这个消息的是当前的 VC
    _lyProxy.target = self;
    //把当前timer处理变成了_lyProxy，_lyProxy 要把消息 转发 当前的 self 
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:_lyProxy selector:@selector(test) userInfo:nil repeats:YES];
}

- (void)createBlockTimer{
    __weak typeof(self)weakSelf = self;
    // ios  10.0 以后 用Block 没问题
    if (@available(iOS 10.0, *)) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f repeats:YES block:^(NSTimer * _Nonnull timer) {
            [weakSelf test];
        }];
    } else {
        _timer = [NSTimer ly_scheduledTimerWithTimeInterval:1.0f repeats:YES block:^{
             [weakSelf test];
        }];
    }
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
    //用于 模式2,3,4 当前 timer 的target 为 当前VC的 一个 变量，当pop回去的时候，出栈的时候，当前VC的引用计数是为0的，它就会调用自己的析构函数，然后销毁timer  然后 timer 的target也就在timer这 被释放了，完美解决 循环引用的问题
    [self releaseTimer];
}

@end
