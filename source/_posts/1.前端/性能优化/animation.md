---
title: 高性能动画
toc: true
date: 2020-03-11 00:00:04
tags:
---

【[参考资料](https://www.jianshu.com/p/67757d73efcf)】
* animatin，transition，transform
* javascript+canvas/webGL/SVG
* requestAnimationFrame
* GPU acceleration

ps:可以结合着`浏览器组成`来看


requestAnimationFrame：让浏览器合理安排js的执行时机，如果用setTimout的话，这个时间间隔取不准，比如60fps的浏览器；如下图，可能会错过页面渲染的时机，就得等到下一次了；
![](/img/Snip20200311_3.png)
