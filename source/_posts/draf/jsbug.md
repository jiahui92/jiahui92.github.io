---
title: jsbug
toc: true
hidden: true
date: 2020-04-07 00:00:01
tags:
---

## BFCache
https://developer.mozilla.org/en-US/docs/Archive/Misc_top_level/Working_with_BFCache

```
onpageshow
	=> event.presisted && location.reload();
```

将页面抽成组件调用，从而避免页面跳转



## 点透事件
* stopImediatePropagation阻止click事件继续执行
* 300ms的延迟是因为要等待"doubleclick"放大页面事件；使用meta指定该页面不能放大时，不会有300ms延迟的；

## 弹层滚动
* 滚动中间层到底，会触发外层继续滚动；
* 增加oveflow:hidden修复完毕之后，弹出层的动作会导致，页面自动回滚到最顶部
* 继续修复：overflow:hidden之后强行使页面偏移到滚动处；结束后再恢复；

## 移动端 300ms click 延迟
[配合meta和fastclick.js解决](https://www.jianshu.com/p/67bae6dfca90) : 在检测到touchend事件的时候，会通过DOM自定义事件立即出发模拟一个click事件，并把浏览器在300ms之后真正的click事件阻止掉
