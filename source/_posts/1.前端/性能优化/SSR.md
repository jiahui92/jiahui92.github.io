---
title: Server-Side Render
toc: true
date: 2020-03-11 00:00:02
tags:
---


解决的问题【[参考资料](https://juejin.im/post/5d7deef6e51d453bb13b66cd)】
* SEO --> 搭一个专门的网站给爬虫？
* 白屏  --> 骨架屏？



## 原理
vue直接用nuxt.js，react直接用umi.js/next.js【[参考资料](https://www.jianshu.com/p/b566a0e2bd56)】
* ReactDom.server.renderToString，应该是服务端的一套特殊domDiff吧
* 浏览器端重新执行一遍js，覆盖服务端的htmlString

## 其它问题
* 服务端路由和浏览器端路由不一致
* redux.store的两端共用
