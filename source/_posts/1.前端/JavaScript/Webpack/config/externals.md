---
title: externals
toc: true
date: 2020-03-20 00:00:07
tags:
---


将npm包移到cdn中
```html
<!-- html中引入jquery -->
<script src="//code.jquery.com/jquery-3.1.0.js"></script>
```

```js
module.exports = {
  ...
  externals: {
    jquery: 'jQuery'
  }
}
```

```js
// 源码
import jquery from 'jquery';
// 打包后
const jquery = window.jQuery;
```

