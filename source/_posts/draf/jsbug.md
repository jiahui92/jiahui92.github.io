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



## 移动端 300ms click 延迟
[使用fastclick.js解决](https://www.jianshu.com/p/67bae6dfca90) : 在检测到touchend事件的时候，会通过DOM自定义事件立即出发模拟一个click事件，并把浏览器在300ms之后真正的click事件阻止掉

```js
// https://github.com/ftlabs/fastclick/blob/master/lib/fastclick.js#L305

clickEvent = document.createEvent('MouseEvents');

clickEvent.initMouseEvent(this.determineEventType(targetElement), true, true, window, 1, touch.screenX, touch.screenY, touch.clientX, touch.clientY, false, false, false, false, 0, null);

targetElement.dispatchEvent(clickEvent);
```


## 点透事件
* 办法一: stopImediatePropagation阻止click事件继续执行
* 办法二: 300ms的延迟是因为要等待"doubleclick"放大页面事件；可以使用fastclick取消300ms延迟；


## 弹层滚动
* 滚动中间层到底，会触发外层继续滚动；
* 增加oveflow:hidden修复完毕之后，弹出层的动作会导致，页面自动回滚到最顶部
* 继续修复：overflow:hidden之后强行使页面偏移到滚动处；结束后再恢复；

