---
title: Preload
toc: true
date: 2020-03-01 00:00:05
tags:
---


【[参考资料](https://www.cnblogs.com/xiaohuochai/p/9183874.html)】
* Chrome有五种优先级来加载资源，preload能修改资源的默认加载优先级
  * preload: 用于调整当前页面资源的加载优先级
  * prefetch: 提前加载后续可能会用到的资源（因此优先级会很低）

```html
<link rel="preload" href="./app.js" as="script">

<link rel="prefetch" href="./comment.js">
```

[preload-webpack-plugin 插件](https://github.com/GoogleChromeLabs/preload-webpack-plugin)

