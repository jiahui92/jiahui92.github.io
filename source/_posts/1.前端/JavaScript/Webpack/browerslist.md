---
title: browerslist
toc: true
date: 2020-03-01 00:00:01
tags:
---

https://www.jianshu.com/p/2a935a7dbab0

```js
"browserslist": [
    "> 1%",  // 占有率大于1%
    "last 2 versions",  // 最新两个版本（新版本的占有率通常还比较低）
    "Android >= 3.2", 
    "Firefox >= 20", 
    "iOS 7"
  ]
```


这个参数配在package.json中，可以让所有插件共用，比如
* babel-preset-env
* postcss-loader
* eslint-plugin-compat
