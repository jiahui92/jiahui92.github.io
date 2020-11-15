---
title: BOM
toc: true
date: 2020-09-13 00:00:06
tags:
---

# location
* href ==> https://www.baidu.com:8800/search/error.html?a=1#title
  * origin ==> https://www.baidu.com:8800
    * protocol ==> https:
    * host ==> www.baidu.com:8800
      * hostname ==> www.baidu.com
      * port ==> 8800
  * pathname ==> /search/error.html
  * search ==> ?a=1
  * hash ==> #title

## method
* assign(url) 与location.href = url 一样
* replace(url)
* reload()


# histroy
* back()
* forward()
* go(n)

## 无刷新更改url
* pushState
* popState
* replaceState
* state
```js
// stateObj有640k大小限制
history.pushState(stateObj, 'some title', '/next-page.html');
```

## onpopstate
* window.onhashchange 可用于降级支持onpopstate；
* 使用非hash路由时，注意需要后端支持，因为存在用户使用"/next-page.html"来刷新页面的场景
* js执行的pushState不会触发该函数，只有go,back,forward
```js
// copy from https://developer.mozilla.org/zh-CN/docs/Web/API/Window/1.html

window.onpopstate = function(event) {
  alert("location: " + document.location + ", state: " + JSON.stringify(event.state));
};
//绑定事件处理函数. 
history.pushState({page: 1}, "title 1", "?page=1");    //添加并激活一个历史记录条目 http://example.com/example.html?page=1,条目索引为1
history.pushState({page: 2}, "title 2", "?page=2");    //添加并激活一个历史记录条目 http://example.com/example.html?page=2,条目索引为2
history.replaceState({page: 3}, "title 3", "?page=3"); //修改当前激活的历史记录条目 http://ex..?page=2 变为 http://ex..?page=3,条目索引为3
history.back(); // 弹出 "location: http://example.com/example.html?page=1, state: {"page":1}"
history.back(); // 弹出 "location: http://example.com/example.html, state: null
history.go(2);  // 弹出 "location: http://example.com/example.html?page=3, state: {"page":3}
```

# navigation
包含浏览器信息、系统信息、设备信息、设备能力【[参考资料](https://developer.mozilla.org/en-US/docs/Web/API/Navigator)】
* appName 浏览器名字
* appVersion 浏览器版本
* cookieEnabled
* userAgent
* platform 系统平台
* plugins 浏览器插件
* language 用户优先使用语言

## 设备状态
* connection 联网信息
* onLine 是否联网
* hardwareConcurrency  cpu核数

## 设备能力
* clipboard
* geolocation
* bluetooth
* usb

# performance
浏览器性能相关信息【[参考资料](https://developer.mozilla.org/en-US/docs/Web/API/Performance)】
* 内存使用信息
* 页面加载性能
* http请求加载性能
* 还有一堆性能测试／收集相关的函数

timing被丢弃了（但仍有很多浏览器兼容），使用`performance.getEntries()[0]`替代，其中返回的entries中，也包含了资源请求等数据。

## 前端性能监控
* DNS查询耗时 = domainLookupEnd - domainLookupStart
* TCP链接耗时 = connectEnd - connectStart
* request请求耗时 = responseEnd - responseStart
* 解析dom树耗时 = domComplete - domInteractive
* 白屏时间 = domloadng - fetchStart
* domready时间 = domContentLoadedEventEnd - fetchStart
* onload时间 = loadEventEnd - fetchStart
