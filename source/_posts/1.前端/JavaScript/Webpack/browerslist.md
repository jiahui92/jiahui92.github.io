---
title: browerslist
toc: true
date: 2020-03-20 00:00:01
tags:
---

【[参考资料](https://www.jianshu.com/p/2a935a7dbab0)】 【[官方文档](https://github.com/browserslist/browserslist)】
```js
> 1%  # 占有率大于1%
last 2 versions  # 最新两个版本（新版本占有率通常还小于1%）
Android >= 3.2
iOS 7
not ie <= 8
```


这个参数最好写在`package.json`或`.browserlist`，可以让所有插件共用，比如
* babel-preset-env
* postcss-loader
* eslint-plugin-compat
