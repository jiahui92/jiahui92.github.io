---
title: chrome devtool
toc: true
date: 2020-03-11 00:00:03
tags:
---

【[参考资料1](https://zhuanlan.zhihu.com/p/29879682)】
【[参考资料2](https://juejin.im/post/5c009115f265da612859d8e2)】



![](/img/Snip20200311_1.png)
* Summary 统计图：展示各个事件阶段耗费的时间
  * Parse HTML
  * Event: mousedown等js event
  * Layout
  * Recalculate style
  * Paint
  * Composite
* Bottom-Up 排序：可以看到各个事件消耗时间排序
* Call Tree 调用栈：Main选择一个事件，可以看到整个事件的调用栈
* Event Log 事件日志


## Rendering工具
[测试页面](https://googlechrome.github.io/devtools-samples/jank/)
* shift + command + P
* show rendering

![](/img/Snip20200311_2.png)

