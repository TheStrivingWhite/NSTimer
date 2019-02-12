# NSTimer
NSTimer 引起循环引用的4种解决办法
第一种是在合适的时候销毁掉当前的timer
第二种引入了一个中间值，中间值的思路是:当前 timer 的target 为 当前VC的 一个 变量，当pop回去的时候，出栈的时候，当前VC的引用计数是为0的，它就会调用自己的析构函数，然后销毁timer  然后 timer 的target也就在timer这 被释放了，完美解决 循环引用的问题
第三种的是用到了 NSProxy
第四种 区分 版本号 10.0以后用系统自带block的timer创建方法，10.0以前的话，得自己创建一个带block的类
注释代码里都有\n
