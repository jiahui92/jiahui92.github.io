---
title: loader:module.rules
toc: true
date: 2020-03-20 00:00:03
tags:
---

use的loader执行顺序是，从后往前
less --> postcss --> css --> style

```js
{
  module: {
    rules: [
      {
        test: /\.css$/,
        // postcss-loader是为了打包兼容性
        use: ['style-loader', 'css-loader', 'postcss-loader', 'less-loader'],
      }
    ]
  }
}
```