---
title: EventLoop
toc: true
date: 2020-03-12 00:00:06
tags:
---

* https://juejin.im/post/5b498d245188251b193d4059 （基础知识）
* https://github.com/aooy/blog/issues/5 (结合渲染,dom操作/事件)
* http://www.ruanyifeng.com/blog/2014/10/event-loop.html （着重看Node）



## 宏任务 macrotask
setTimeout、setInterval、ajax、domEvent(click等)

## 微任务 microtask
Promise、MutationObserver、postMessage
process.nextTiick、setImmediate

## Node异步任务优先级
【[参考资料](https://www.jianshu.com/p/d070e11ffa4d)】
* idle观察者 > I/O观察者 > Check观察者
* idle观察者: `process.nextTick`早已在等待系统空闲的回调
* Check观察者: `setTimeout`等定时器


## EventLoop
1. 所有同步任务都在主线程上执行，形成一个执行栈（execution context stack），函数调用时开一个新栈。
2. 主线程之外，还存在一个"任务队列"（task queue）。只要异步任务有了运行结果，就在"任务队列"之中放置一个事件。
3. 一旦"执行栈"中的所有同步任务执行完毕，系统就会读取"任务队列"，放入执行栈，开始执行（首先**取一个**最老的macrotask执行，然后再执行microtask队列中的所有任务）。执行完microtask队列里的任务，有可能会渲染更新。（浏览器不会立即重新渲染UI，取决于是否修改了dom和浏览器觉得是否有必要在此时立即将新状态呈现给用户；同时刷新频率也会受限于显示器的60Hz/75Hz，也就是即使软件层面上渲染了，但是硬件还没有展示处理给用户）
4. 主线程**不断循环重复上面的第三步**。

![](/img/Snip20200312_10.png)

## 应用
* [vue里的nextTick实现](/wiki/1.前端/z.框架_源码_原理/Vue/index)
* Promise pollyfill的依赖库[setimmediate](https://github.com/yuzujs/setImmediate)
* 合理使用task来控制任务的优先级，比如浏览器通过macrotask来将ajax回调事件靠后处理；

