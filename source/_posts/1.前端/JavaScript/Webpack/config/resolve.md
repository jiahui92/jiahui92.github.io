---
title: resolve
toc: true
date: 2020-03-20 00:00:06
tags:
---

主要用于加载模块过程中的`寻包`，比如`require('someModule')`时一级一级的往上级目录查找该模块的过程
```js
{
  noParse: /jquery/, // 不处理jquery，也可以将其抽到cdn

  resolve: {
    modules: [ // 指定require查找路径
      path.resolve('src'),
      path.resolve('node_modules'),
    ],

    // 不带后缀的引用仅尝试以下值
    extension: ['.js']
  },

  alias: {
    utils: path.resolve('src/utils'),
  }，

  ... {
    // loader优化
    rules: {
      ...,
      exclude: /node_modules/,
    }
  }
  
}
```

## mainFields
webpack会尝试使用`mainField`里的值在`package.json`中查找入口文件字段；【[官方文档](https://webpack.docschina.org/configuration/resolve/#resolve-mainfields)】【[参考资料](https://juejin.im/post/5cfe6d3be51d454d544abf30)】
```js
resolve: {
  // webpack的"target:web"对应的 mainFields
  mainFields: ['browser', 'module', 'main']
}
```

```js
// package.json
{
  ...
  "main": "/lib/index.js", // browser和nodejs的入口文件
  "module": "/lib/index.mjs", // ES Module: import
  "browser": "/lib/index.browser.js", // browser的入口文件
  ...
}
```
