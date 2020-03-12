---
title: index
toc: true
date: 2020-03-12 00:00:00
tags:
---

![](https://pic2.zhimg.com/v2-f7e8e813d292944632530dda6ce1b976_1200x500.jpg)

## Chrome的多进程架构
【[参考资料](https://zhuanlan.zhihu.com/p/47407398)】
* Browser Process
	* UI thread
	* network thread
    * storage thread
* Renderer Process: 每个页面创建一个
    * Main thread
      * JSCore
      * DOM Tree
      * CSS
      * Render Tree & Layout Tree
      * Paint
        * Layer
        * Raster
    * Web Worker
      * normal worker
      * service worker
* GPU Process
  * Composite
* Plugin Process: 每个chrome插件创建一个



## 其他
【[参考资料](https://zhuanlan.zhihu.com/p/47407398)】
* `Browser Process`和`network thread`完成一次浏览器的请求
* 事件处理
	* 优化: passive=true && non-fast scrollable region
	* 通过PaintRecords查找被点击的dom


## 其它参考资料
* [祖传资料](https://www.html5rocks.com/zh/tutorials/internals/howbrowserswork/)
* [CSS选择器解析：从右到左]( https://juejin.im/post/5d89798d6fb9a06b102769b1 )
