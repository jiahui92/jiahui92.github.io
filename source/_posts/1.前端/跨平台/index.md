---
title: index
toc: true
date: 2020-03-11 00:00:00
tags:
---

目前看起来xcx, rn, weex, electron的方案都是通过jsBridge通信来实现的（详细可以看xmind的V8），而Flutter则是通过编译来实现。

## weex
sendTasks是通过对js暴露的一个native方法（JSCore拓展），这样js就可以与Native层通信，而JSCore拓展就是所谓的JSBridge【[参考资料](https://www.jianshu.com/p/41cde2c62b81)】
```js
// 底层会注册好这些module，以及对应method
[self registerModule:@"dom" ...]
[self registerModule:@"navigator" ...]
[self registerModule:@"animation" ...]
[self registerModule:@"modal" ...]
[self registerModule:@"webview" ...]
[self registerModule:@"picker" ...]
...

// 上层封装
sendTasks(id, [{ module: 'dom', method: 'scrollToElement', args: [elementRef]}])

// 上层调用
const dom = weex.requireModule('dom')
dom.scrollToElement(el, { offset: 0 })

// WXxxx的暴露
WXEnvironment.appName
```

## React Native
【[参考资料](https://zhuanlan.zhihu.com/p/41920417)】
![](https://pic4.zhimg.com/80/v2-60eb566b812a49fa945e802abe8dd453_720w.jpg)


## Flutter
全靠编译【[参考代码](https://zhuanlan.zhihu.com/p/36861174)】，Flutter的代码好难看。。。但性能好；
