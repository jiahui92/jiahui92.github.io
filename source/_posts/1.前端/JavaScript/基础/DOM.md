---
title: DOM
toc: true
date: 2020-09-13 00:00:07
tags:
---

# DOMContentLoaded
DOM树加载完毕后触发，而`onload`事件会等待js、css、img等资源


# MutationObserver
dom监听事件：属性、child的增删改等
```js
var observer = new MutationObserver(function(mutations) {
  mutations.forEach(function(mutation) {
    console.log(mutation.type);
  });    
});

observer.observe(document.body, { childList: true })
```

# onpage
* onpageshow
* onpagehide

## BFCache
下单页跳转到地址选择页面，如果在地址选择完毕后使用history.back返回下单也，某些手机浏览器下，下单页是不会刷新的；此时可以使用onpageshow事件（往返缓存【[参考资料](https://developer.mozilla.org/en-US/docs/Archive/Misc_top_level/Working_with_BFCache)】）来强行刷新，但在一些不支持此api的浏览器下，就没有办法了；最好的是`将页面抽成组件调用，从而避免页面跳转`；
```js
window.onpageshow = (event) => {
  event.presisted && location.reload();
}
```


# onmouse
* mouseenter、mouseleave 不冒泡
* mouseout：移入子代元素会触发，且冒泡
* mouseleave：移入子代元素不会触发，且不冒泡
mouseover mousemove


# 委托代理事件
```js
document.body.onclick = () => {
  event.target
}
```

# 模拟事件
fireEvent, dispatchEvent

