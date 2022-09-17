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

  // 只会对当前项目的包生效，貌似不会对node_modules里的无效
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
webpack会尝试使用`mainField`里的值在`package.json`中查找node_moduels包的入口文件字段；【[官方文档](https://webpack.docschina.org/configuration/resolve/#resolve-mainfields)】【[参考资料](https://juejin.im/post/5cfe6d3be51d454d544abf30)】
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
  "module": "/es/index.mjs", // ES Module: import
  "browser": "/browser/index.js", // browser的入口文件
  ...
}
```

### tsconfig-paths-webpack-plugin
有些ts插件也会有mainFields的配置（比如[tsconfig-paths-webpack-plugin](https://github.com/dividab/tsconfig-paths-webpack-plugin)），最好是保持和webpack的resolve.mainFields保持一致，否则会造成部分依赖包的依赖包没有按照预期进行打包，比如包A引用了B；webpack在打包A时，用的是main入口的代码，而打包B时则用了module入口的代码；
```js
{
  resolve: {
    mainFields: ['module', 'main'],
    plugins[
      new TsconfigPaths({
        configFile: 'tsconfig.json',
        mainFields: ['module', 'main'],
      })
    ]
  }
}
```
