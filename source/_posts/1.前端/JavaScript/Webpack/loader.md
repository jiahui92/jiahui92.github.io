---
title: loader
toc: true
date: 2020-03-01 00:00:01
tags:
---

常用loader
* 编译：babel-loader、vue-loader 、ts-loader等
* 样式：style-loader、css-loader、less-loader、postcss-loader(autoprefix)等
* 文件：raw-loader、file-loader 、url-loader等
* 校验测试：mocha-loader、jshint-loader 、eslint-loader等


一种特殊的plugin，专门用于转换代码格式，比如将less转为css，ts转为js，或者babel转换成es5


## loader开发
```js
// loader插件的结构一般为
module.exports = (source) => {
  // TODO需要执行的逻辑
}
```

webpack的ast是用recast生成的，而recast则依赖babel一系列的库
https://juejin.im/post/5d50d1d9f265da03aa25607b
